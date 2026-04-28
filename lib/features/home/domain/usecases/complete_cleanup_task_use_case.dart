import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class CompleteCleanupTaskUseCase
    implements UseCase<void, CompleteCleanupTaskParams> {
  final HomeRepository repository;

  const CompleteCleanupTaskUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CompleteCleanupTaskParams params) async {
    try {
      await repository.completeCleanupTask(
        taskId: params.taskId,
        finalWasteType: params.finalWasteType,
        finalWeightInKg: params.finalWeightInKg,
        imagePaths: params.imagePaths,
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

class CompleteCleanupTaskParams extends Equatable {
  final int taskId;
  final int finalWasteType;
  final String finalWeightInKg;
  final List<String> imagePaths;

  const CompleteCleanupTaskParams({
    required this.taskId,
    required this.finalWasteType,
    required this.finalWeightInKg,
    required this.imagePaths,
  });

  @override
  List<Object> get props => <Object>[
    taskId,
    finalWasteType,
    finalWeightInKg,
    imagePaths,
  ];
}
