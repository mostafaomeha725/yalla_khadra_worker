import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';

abstract class AiScanRepository {
  Future<Either<Failure, AiScanResultEntity>> scanWasteImage({
    required String imagePath,
  });

  Future<Either<Failure, List<AiScanResultEntity>>> getMyScans();
}
