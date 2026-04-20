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

  @override
  Future<Either<Failure, List<AiScanResultModel>>> getMyScans() async {
    final result = await _networkService.getData(
      endPoint: EndPoints.aiWasteScanMy,
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
        final ServerFailure failure = AiScanResultModel.parseResponseFailure(
          data,
        );
        if (failure.message == 'Unable to analyze image.') {
          return const Left(
            ServerFailure(message: 'Unable to load previous scans.'),
          );
        }
        return Left(failure);
      }

      final String message = data['message'] as String? ?? 'Scans retrieved.';
      final List<dynamic> payload =
          (data['data'] as List<dynamic>?) ??
          (data['Data'] as List<dynamic>?) ??
          const <dynamic>[];

      final List<AiScanResultModel> scans = payload
          .whereType<Map<String, dynamic>>()
          .map(
            (Map<String, dynamic> item) =>
                AiScanResultModel.fromScanData(data: item, message: message),
          )
          .toList(growable: false);

      return Right(scans);
    });
  }

  String _extractFileName(String path) {
    final int slashIndex = path.lastIndexOf(RegExp(r'[\\/]'));
    if (slashIndex == -1 || slashIndex == path.length - 1) {
      return 'scan_image.jpg';
    }
    return path.substring(slashIndex + 1);
  }
}
