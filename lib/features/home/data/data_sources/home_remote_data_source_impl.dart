import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:yallakhadra/features/home/data/models/home_current_cleanup_task_model.dart';
import 'package:yallakhadra/features/home/data/models/home_main_overview_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkService _networkService;

  HomeRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, HomeMainOverviewModel>> getMainOverview() async {
    final result = await _networkService.getData(
      endPoint: EndPoints.cleanupTaskMainOverview,
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded =
          (data['succeeded'] as bool?) ??
          (data['Succeeded'] as bool?) ??
          (data['statusCode'] as num?) == 200;

      if (!succeeded) {
        return Left(
          ServerFailure(
            message: HomeMainOverviewModel.extractFailureMessage(data),
          ),
        );
      }

      return Right(HomeMainOverviewModel.fromJson(data));
    });
  }

  @override
  Future<Either<Failure, List<HomeCurrentCleanupTaskModel>>>
  getMyUncompletedTask() async {
    final result = await _networkService.getData(
      endPoint: EndPoints.cleanupTaskMyUncompletedTasks,
    );

    return result.fold((failure) => Left(failure), (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(ServerFailure(message: 'Invalid server response'));
      }

      final bool succeeded =
          (data['succeeded'] as bool?) ??
          (data['Succeeded'] as bool?) ??
          (data['statusCode'] as num?) == 200;

      if (!succeeded) {
        return Left(
          ServerFailure(
            message: HomeMainOverviewModel.extractFailureMessage(
              data,
              fallback: 'Unable to load current cleanup.',
            ),
          ),
        );
      }

      return Right(HomeCurrentCleanupTaskModel.listFromResponse(data));
    });
  }

  @override
  Future<Either<Failure, void>> completeCleanupTask({
    required int taskId,
    required int finalWasteType,
    required String finalWeightInKg,
    required List<String> imagePaths,
  }) async {
    try {
      final List<MultipartFile> images = <MultipartFile>[];
      for (final String path in imagePaths) {
        images.add(
          await MultipartFile.fromFile(path, filename: _extractFileName(path)),
        );
      }

      final FormData formData = FormData.fromMap(<String, dynamic>{
        'TaskId': taskId,
        'FinalWeightInKg': finalWeightInKg,
        'FinalWasteType': finalWasteType,
        'Images': images,
      });

      final result = await _networkService.uploadFile(
        endPoint: EndPoints.cleanupTaskComplete,
        formData: formData,
      );

      return result.fold((failure) => Left(failure), (data) {
        if (data is! Map<String, dynamic>) {
          return const Left(ServerFailure(message: 'Invalid server response'));
        }

        final bool succeeded =
            (data['succeeded'] as bool?) ??
            (data['Succeeded'] as bool?) ??
            (data['statusCode'] as num?) == 200;

        if (!succeeded) {
          return Left(
            ServerFailure(
              message: HomeMainOverviewModel.extractFailureMessage(
                data,
                fallback: 'Unable to complete cleanup task.',
              ),
            ),
          );
        }

        return const Right(null);
      });
    } catch (_) {
      return const Left(ServerFailure(message: 'Unable to complete task.'));
    }
  }

  String _extractFileName(String path) {
    final int slashIndex = path.lastIndexOf(RegExp(r'[\\/]'));
    if (slashIndex == -1 || slashIndex == path.length - 1) {
      return 'cleanup_proof.jpg';
    }
    return path.substring(slashIndex + 1);
  }

  @override
  Future<Either<Failure, void>> updateUserLocation({
    required int userId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final Map<String, dynamic> payload = <String, dynamic>{
        'Latitude': latitude,
        'Longitude': longitude,
      };

      final result = await _networkService.patchData(
        endPoint: '${EndPoints.user}/$userId',
        data: payload,
        isRaw: false,
      );

      return result.fold(
        (String message) {
          final String errorMessage = message.trim().isEmpty
              ? 'Unable to update location.'
              : message;
          return Left(ServerFailure(message: errorMessage));
        },
        (dynamic data) {
          if (data is! Map<String, dynamic>) {
            return const Left(
              ServerFailure(message: 'Invalid server response'),
            );
          }

          final bool succeeded =
              (data['succeeded'] as bool?) ??
              (data['Succeeded'] as bool?) ??
              (data['statusCode'] as num?) == 200;

          if (!succeeded) {
            final String failureMessage = HomeMainOverviewModel.extractFailureMessage(
              data,
              fallback: 'Unable to update location.',
            );
            return Left(
              ServerFailure(
                message: failureMessage.isEmpty
                    ? 'Unable to update location.'
                    : failureMessage,
              ),
            );
          }

          return const Right(null);
        },
      );
    } catch (_) {
      return const Left(ServerFailure(message: 'Unable to update location.'));
    }
  }
}
