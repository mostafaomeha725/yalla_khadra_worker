import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/home/data/models/home_current_cleanup_task_model.dart';
import 'package:yallakhadra/features/home/data/models/home_main_overview_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, HomeMainOverviewModel>> getMainOverview();

  Future<Either<Failure, HomeCurrentCleanupTaskModel?>> getMyUncompletedTask();

  Future<Either<Failure, void>> completeCleanupTask({
    required int taskId,
    required int finalWasteType,
    required String finalWeightInKg,
    required List<String> imagePaths,
  });
}
