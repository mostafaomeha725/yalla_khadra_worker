import 'dart:async';

import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:dio/dio.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/utils/safe_print.dart';

class AuthorizationInterceptor extends Interceptor {
  static const String _retryAttemptedKey = '__retry_attempted__';
  static const String _requestIdKey = '__request_id__';

  final Dio _dio;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  final List<RequestOptions> _pendingRequests = <RequestOptions>[];
  final Map<String, ErrorInterceptorHandler> _pendingHandlersById =
      <String, ErrorInterceptorHandler>{};
  final Set<String> _queuedRequestIds = <String>{};

  AuthorizationInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = sl<PreferencesStorage>();

    final String token = (prefs.getUserToken() ?? '').trim();
    final bool isAnonymousAuthRequest = _isAnonymousAuthRequest(options);

    // Ensure stale Authorization headers never leak into anonymous auth endpoints.
    if (isAnonymousAuthRequest || token.isEmpty) {
      options.headers.remove('Authorization');
      handler.next(options);
      return;
    }

    options.headers['Authorization'] = 'Bearer $token';

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final RequestOptions requestOptions = err.requestOptions;
    final bool isUnauthorized = err.response?.statusCode == 401;

    if (!isUnauthorized) {
      handler.next(err);
      return;
    }

    final String requestId = _ensureRequestId(requestOptions);

    if (_isAuthRequest(requestOptions)) {
      handler.next(err);
      return;
    }

    if (_isRefreshRequest(requestOptions)) {
      safePrint('Refresh endpoint returned 401. Clearing tokens.');
      await _clearTokens();
      handler.next(err);
      return;
    }

    if (requestOptions.extra[_retryAttemptedKey] == true) {
      safePrint('Request already retried once. Skip: $requestId');
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      _enqueueRequest(requestOptions, handler, requestId);
      safePrint('Refresh already running. Request queued: $requestId');

      try {
        await _refreshCompleter?.future;
      } catch (_) {
        // Queue failure is handled centrally in _failQueuedRequests.
      }
      return;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();
    safePrint('Refresh started');

    final bool refreshed = await _performRefresh();

    if (!refreshed) {
      safePrint('Refresh failed');
      _refreshCompleter?.completeError(StateError('Refresh failed'));
      await _failQueuedRequests(err);
      await _clearTokens();
      _isRefreshing = false;
      handler.next(err);
      return;
    }

    safePrint('Refresh success');
    _refreshCompleter?.complete();

    await _retryQueuedRequests();
    _isRefreshing = false;

    await _retryRequest(requestOptions, handler);
  }

  void _enqueueRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
    String requestId,
  ) {
    if (_queuedRequestIds.contains(requestId)) {
      return;
    }

    _queuedRequestIds.add(requestId);
    _pendingRequests.add(requestOptions);
    _pendingHandlersById[requestId] = handler;
  }

  Future<void> _retryQueuedRequests() async {
    safePrint('Retry queued requests count: ${_pendingRequests.length}');

    final List<RequestOptions> queued = List<RequestOptions>.from(
      _pendingRequests,
    );

    _pendingRequests.clear();

    for (final RequestOptions request in queued) {
      final String requestId = _ensureRequestId(request);
      final ErrorInterceptorHandler? queuedHandler = _pendingHandlersById
          .remove(requestId);

      _queuedRequestIds.remove(requestId);

      if (queuedHandler == null) {
        continue;
      }

      await _retryRequest(request, queuedHandler);
    }
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final prefs = sl<PreferencesStorage>();
    final String? newAccessToken = prefs.getUserToken();

    if (newAccessToken == null || newAccessToken.isEmpty) {
      await _clearTokens();
      handler.next(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.badResponse,
          error: 'Missing access token after refresh',
        ),
      );
      return;
    }

    final Map<String, dynamic> updatedHeaders = Map<String, dynamic>.from(
      requestOptions.headers,
    );
    updatedHeaders['Authorization'] = 'Bearer $newAccessToken';

    final Map<String, dynamic> updatedExtra = Map<String, dynamic>.from(
      requestOptions.extra,
    );
    updatedExtra[_retryAttemptedKey] = true;

    final RequestOptions retryOptions = requestOptions.copyWith(
      headers: updatedHeaders,
      extra: updatedExtra,
    );

    try {
      final Response<dynamic> response = await _dio.fetch<dynamic>(
        retryOptions,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    } catch (e) {
      handler.next(
        DioException(
          requestOptions: requestOptions,
          error: e,
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  bool _isRefreshRequest(RequestOptions requestOptions) {
    return requestOptions.path.contains(EndPoints.refreshToken);
  }

  bool _isAuthRequest(RequestOptions requestOptions) {
    final String path = requestOptions.path.toLowerCase();

    return path.contains(EndPoints.login.toLowerCase()) ||
        path.contains(EndPoints.register.toLowerCase()) ||
        path.contains(EndPoints.forgotPassword.toLowerCase()) ||
        path.contains(EndPoints.resetPassword.toLowerCase()) ||
        _isRefreshRequest(requestOptions);
  }

  bool _isAnonymousAuthRequest(RequestOptions requestOptions) {
    final String path = requestOptions.path.toLowerCase();

    return path.contains(EndPoints.login.toLowerCase()) ||
        path.contains(EndPoints.register.toLowerCase()) ||
        path.contains(EndPoints.forgotPassword.toLowerCase()) ||
        path.contains(EndPoints.verifyPasswordResetCode.toLowerCase()) ||
        path.contains(EndPoints.confirmPasswordReset.toLowerCase()) ||
        path.contains(EndPoints.resetPassword.toLowerCase());
  }

  Future<bool> _performRefresh() async {
    final prefs = sl<PreferencesStorage>();
    final String? refreshToken = prefs.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    final String? accessToken = prefs.getUserToken();

    try {
      final Response<dynamic> response = await _dio.post(
        EndPoints.refreshToken,
        data: <String, dynamic>{
          'refreshToken': refreshToken,
          if (accessToken != null && accessToken.isNotEmpty)
            'accessToken': accessToken,
        },
      );

      final dynamic responseData = response.data;
      if (responseData is! Map<String, dynamic>) {
        return false;
      }

      final dynamic data = responseData['data'];
      if (data is! Map<String, dynamic>) {
        return false;
      }

      final String? newAccessToken = data['accessToken'] as String?;
      if (newAccessToken == null || newAccessToken.isEmpty) {
        return false;
      }

      String? newRefreshToken;
      final dynamic refreshData = data['refreshToken'];
      if (refreshData is Map<String, dynamic>) {
        newRefreshToken = refreshData['token'] as String?;
      } else if (refreshData is String) {
        newRefreshToken = refreshData;
      }

      await prefs.saveUserToken(newAccessToken);
      await prefs.saveRefreshToken(newRefreshToken ?? refreshToken);

      _dio.options.headers['Authorization'] = 'Bearer $newAccessToken';

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _failQueuedRequests(DioException sourceError) async {
    final List<RequestOptions> queued = List<RequestOptions>.from(
      _pendingRequests,
    );
    _pendingRequests.clear();

    for (final RequestOptions request in queued) {
      final String requestId = _ensureRequestId(request);
      final ErrorInterceptorHandler? queuedHandler = _pendingHandlersById
          .remove(requestId);
      _queuedRequestIds.remove(requestId);

      if (queuedHandler == null) {
        continue;
      }

      queuedHandler.next(
        DioException(
          requestOptions: request,
          response: sourceError.response,
          type: sourceError.type,
          error: sourceError.error,
          message: sourceError.message,
        ),
      );
    }
  }

  String _ensureRequestId(RequestOptions requestOptions) {
    final dynamic existing = requestOptions.extra[_requestIdKey];
    if (existing is String && existing.isNotEmpty) {
      return existing;
    }

    final String generated =
        '${requestOptions.method}-${requestOptions.uri}-${identityHashCode(requestOptions)}';
    requestOptions.extra[_requestIdKey] = generated;
    return generated;
  }

  Future<void> _clearTokens() async {
    final prefs = sl<PreferencesStorage>();
    await prefs.deleteUserToken();
    await prefs.deleteRefreshToken();
    _dio.options.headers.remove('Authorization');
  }
}
