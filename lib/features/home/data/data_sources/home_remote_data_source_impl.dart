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
}
