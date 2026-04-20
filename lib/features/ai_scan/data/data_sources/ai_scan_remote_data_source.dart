import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/ai_scan/data/models/ai_scan_result_model.dart';

abstract class AiScanRemoteDataSource {
  Future<Either<Failure, AiScanResultModel>> scanWasteImage({
    required String imagePath,
  });

  Future<Either<Failure, List<AiScanResultModel>>> getMyScans();
}
