import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/ai_scan/data/data_sources/ai_scan_remote_data_source.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/domain/repositories/ai_scan_repository.dart';

class AiScanRepositoryImpl implements AiScanRepository {
  final AiScanRemoteDataSource _remoteDataSource;

  AiScanRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AiScanResultEntity>> scanWasteImage({
    required String imagePath,
  }) async {
    final result = await _remoteDataSource.scanWasteImage(imagePath: imagePath);

    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model.result),
    );
  }
}
