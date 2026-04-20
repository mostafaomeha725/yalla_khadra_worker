import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/network/endpoints.dart';
import 'package:yallakhadra/core/network/network_service.dart';
import 'package:yallakhadra/features/ai_scan/data/data_sources/ai_scan_remote_data_source.dart';
import 'package:yallakhadra/features/ai_scan/data/models/ai_scan_result_model.dart';

class AiScanRemoteDataSourceImpl implements AiScanRemoteDataSource {
  final NetworkService _networkService;

  AiScanRemoteDataSourceImpl(this._networkService);

  @override
  Future<Either<Failure, AiScanResultModel>> scanWasteImage({
    required String imagePath,
  }) async {
    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'Image': await MultipartFile.fromFile(
          imagePath,
          filename: _extractFileName(imagePath),
        ),
      });

      final result = await _networkService.uploadFile(
        endPoint: EndPoints.aiWasteScan,
        formData: formData,
      );

      return result.fold((failure) => Left(failure), (data) {
        if (data is! Map<String, dynamic>) {
          return const Left(ServerFailure(message: 'Invalid server response'));
        }

        final bool succeeded =
            (data['succeeded'] as bool?) ??
            (data['Succeeded'] as bool?) ??
            (data['statusCode'] as num?) == 201;
        if (!succeeded) {
          return Left(AiScanResultModel.parseResponseFailure(data));
        }

        return Right(AiScanResultModel.fromJson(data));
      });
    } catch (_) {
      return const Left(ServerFailure(message: 'Unable to analyze image.'));
    }
  }

  String _extractFileName(String path) {
    final int slashIndex = path.lastIndexOf(RegExp(r'[\\/]'));
    if (slashIndex == -1 || slashIndex == path.length - 1) {
      return 'scan_image.jpg';
    }
    return path.substring(slashIndex + 1);
  }
}
