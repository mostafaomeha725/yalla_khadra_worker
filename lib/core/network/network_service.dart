import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:yallakhadra/core/constants/strings.dart';
import 'package:yallakhadra/core/di/services_locator.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/authorization_interceptor.dart';
import 'package:yallakhadra/core/network/endpoints.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio) {
    dio.options
      ..baseUrl = AppStrings.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    addHeaders();
    addInterceptors();
  }

  void addInterceptors() {
    dio.interceptors.add(AuthorizationInterceptor(dio));

    // if (isDevEnviroment()) {
    dio.interceptors.add(ChuckerDioInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(requestBody: true, requestHeader: true),
    );
    // }
  }

  void addHeaders() {
    final prefs = sl<PreferencesStorage>();

    final token = prefs.getUserToken();

    dio.options.headers = {
      "Accept": "application/json",
      "Accept-Encoding": "gzip, deflate, br",

      if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
    };
  }

  void addToken(String token) {
    dio.options.headers['Authorization'] = "Bearer $token";
  }

  Future<Either<Failure, dynamic>> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isRaw = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data),
        queryParameters: queryParameters,
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data['status'] == false) {
          return Left(Failure(response.data['message']));
        }
        return Right(response.data);
      } else {
        return Left(Failure(response.data['message'].toString()));
      }
    } on SocketException {
      return const Left(Failure("No Internet Connection"));
    } on FormatException {
      return const Left(Failure("Format Exception"));
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> postEncryptedData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isRaw = true,
  }) async {
    // Convert payload to JSON string
    String jsonPayload = jsonEncode(data);

    // Calculate HMAC SHA256 signature
    String signature = hmacSha256(jsonPayload);

    // Encode the signature as Base64
    String encodedSignature = base64.encode(utf8.encode(signature));

    dio.options.headers['X-Signature'] = encodedSignature;

    try {
      var response = await dio.post(
        endPoint,
        data: data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data),
        queryParameters: queryParameters,
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(response.data);
      } else {
        return Left(Failure(response.data['message'].toString()));
      }
    } on SocketException {
      return const Left(Failure("No Internet Connection"));
    } on FormatException {
      return const Left(Failure("Format Exception"));
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> uploadFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: formData,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return const Left(Failure("No Internet Connection"));
    } on FormatException {
      return const Left(Failure("Format Exception"));
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<String, dynamic>> downloadFile({
    required String fileUrl,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {"Accept": "*/*"};

    try {
      var response = await dio.download(
        fileUrl,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: (received, total) {
          // You can use these values to show download progress
          // safePrint(
          //     'downloadFile =>Received: ${received.toString()}, Total: ${total.toString()}');

          if (total != -1) {
            // Calculate download progress percentage
            // double progress = (received / total * 100);
            // safePrint('downloadFile => progress: ${progress.toString()}}');
          }
        },
      );
      return Right(response);
    } catch (e) {
      debugPrint(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<Failure, dynamic>> putData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return const Left(Failure("No Internet Connection"));
    } on FormatException {
      return const Left(Failure("Format Exception"));
    } on DioException catch (e) {
      return handleDioExceoptions(e);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<String, dynamic>> patchData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isRaw = true,
  }) async {
    try {
      var response = await dio.patch(
        endPoint,
        queryParameters: queryParameters,
        data: data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data),
      );
      return Right(response.data);
    } on SocketException {
      return const Left("No Internet Connection");
    } on FormatException {
      return const Left("Format Exception");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Left(_extractErrorMessage(e.response?.data));
        // return Left(_l)(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return const Left("Check your connection");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // safePrint('unable to connect to the server');
        return const Left("Unable to connect to the server");
      } else {
        return Left(e.message ?? "");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, dynamic>> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on SocketException {
      return const Left("No Internet Connection");
    } on FormatException {
      return const Left("Format Exception");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Left(_extractErrorMessage(e.response?.data));
        // return Left(_l)(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return const Left("Check your connection");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // safePrint('unable to connect to the server');
        return const Left("Unable to connect to the server");
      } else {
        return Left(e.message ?? "");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return Right(response.data);
      } else {
        return Left(Failure(response.data['message']));
      }
    } on SocketException {
      return const Left(Failure("No Internet Connection"));
    } on FormatException {
      return const Left(Failure("Format Exception"));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Left(Failure(_extractErrorMessage(e.response?.data)));
        // return Left(_l)(e.message);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        // safePrint('check your connection');
        return const Left(Failure("Check your connection"));
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return const Left(Failure("Unable to connect to the server"));
      } else {
        return Left(Failure(e.message ?? ""));
        // return const Left("Check internet connection");
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Left<Failure, dynamic> handleDioExceoptions(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      return Left(Failure(_extractErrorMessage(e.response?.data)));
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return const Left(Failure("Check your connection"));
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return const Left(Failure("Unable to connect to the server"));
    } else {
      return Left(Failure(e.message ?? ""));
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is String && data.trim().isNotEmpty) {
      return data;
    }

    if (data is Map<String, dynamic>) {
      final dynamic errors = data['errors'] ?? data['Errors'];
      if (errors is Map<String, dynamic>) {
        for (final dynamic value in errors.values) {
          if (value is List<dynamic>) {
            for (final dynamic item in value) {
              if (item is String && item.trim().isNotEmpty) {
                return item;
              }
            }
          }
        }
      }

      if (errors is List<dynamic>) {
        for (final dynamic error in errors) {
          if (error is String && error.trim().isNotEmpty) {
            return error;
          }
        }
      }

      final dynamic message = data['message'] ?? data['Message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }

      final dynamic title = data['title'] ?? data['Title'];
      if (title is String && title.trim().isNotEmpty) {
        return title;
      }
    }

    return 'Request failed';
  }

  String hmacSha256(String data) {
    var hmacSha256 = Hmac(
      sha256,
      utf8.encode(EndPoints.apiSecret),
    ); // HMAC-SHA256
    var digest = hmacSha256.convert(utf8.encode(data));
    return digest.toString();
  }
}
