import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/domain/repositories/ai_scan_repository.dart';

class GetMyWasteScansUseCase
    extends UseCase<List<AiScanResultEntity>, NoParams> {
  final AiScanRepository _repository;

  GetMyWasteScansUseCase(this._repository);

  @override
  Future<Either<Failure, List<AiScanResultEntity>>> call(NoParams params) {
    return _repository.getMyScans();
  }
}
