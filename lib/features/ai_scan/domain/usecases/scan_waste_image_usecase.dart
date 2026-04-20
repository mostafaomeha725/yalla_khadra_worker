import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/domain/repositories/ai_scan_repository.dart';

class ScanWasteImageUseCase
    extends UseCase<AiScanResultEntity, ScanWasteImageParams> {
  final AiScanRepository _repository;

  ScanWasteImageUseCase(this._repository);

  @override
  Future<Either<Failure, AiScanResultEntity>> call(
    ScanWasteImageParams params,
  ) {
    return _repository.scanWasteImage(imagePath: params.imagePath);
  }
}

class ScanWasteImageParams extends Equatable {
  final String imagePath;

  const ScanWasteImageParams({required this.imagePath});

  @override
  List<Object?> get props => <Object?>[imagePath];
}
