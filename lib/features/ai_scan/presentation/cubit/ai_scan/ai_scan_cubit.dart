import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/domain/usecases/get_my_waste_scans_usecase.dart';
import 'package:yallakhadra/features/ai_scan/domain/usecases/scan_waste_image_usecase.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_state.dart';

class AiScanCubit extends Cubit<AiScanState> {
  final ScanWasteImageUseCase _scanWasteImageUseCase;
  final GetMyWasteScansUseCase _getMyWasteScansUseCase;
  final List<AiScanResultEntity> _history = <AiScanResultEntity>[];

  AiScanCubit(this._scanWasteImageUseCase, this._getMyWasteScansUseCase)
    : super(const AiScanInitial());

  Future<void> fetchMyScans() async {
    emit(
      AiScanLoading(
        message: 'Loading previous scans...',
        scans: List<AiScanResultEntity>.unmodifiable(_history),
        selectedImagePath: state.selectedImagePath,
      ),
    );

    final result = await _getMyWasteScansUseCase(NoParams());

    result.fold(
      (failure) => emit(
        AiScanError(
          message: failure.message,
          scans: List<AiScanResultEntity>.unmodifiable(_history),
          selectedImagePath: state.selectedImagePath,
        ),
      ),
      (scans) {
        _history
          ..clear()
          ..addAll(scans);

        emit(
          AiScanLoaded(
            scans: List<AiScanResultEntity>.unmodifiable(_history),
            selectedImagePath: state.selectedImagePath,
          ),
        );
      },
    );
  }

  void selectImage(String imagePath) {
    if (imagePath.trim().isEmpty) {
      emit(
        AiScanError(
          message: 'Please select an image first.',
          scans: _history,
          selectedImagePath: null,
        ),
      );
      return;
    }

    emit(
      AiScanImageSelected(
        scans: List<AiScanResultEntity>.unmodifiable(_history),
        selectedImagePath: imagePath,
      ),
    );
  }

  Future<void> scanSelectedImage() async {
    final String? selectedImagePath = state.selectedImagePath;
    if (selectedImagePath == null || selectedImagePath.trim().isEmpty) {
      emit(
        AiScanError(
          message: 'Please select an image first.',
          scans: List<AiScanResultEntity>.unmodifiable(_history),
          selectedImagePath: null,
        ),
      );
      return;
    }

    emit(
      AiScanLoading(
        message: 'Analyzing image...',
        scans: List<AiScanResultEntity>.unmodifiable(_history),
        selectedImagePath: selectedImagePath,
      ),
    );

    final result = await _scanWasteImageUseCase(
      ScanWasteImageParams(imagePath: selectedImagePath),
    );

    result.fold(
      (failure) => emit(
        AiScanError(
          message: failure.message,
          scans: List<AiScanResultEntity>.unmodifiable(_history),
          selectedImagePath: selectedImagePath,
        ),
      ),
      (scanResult) {
        _history.insert(0, scanResult);
        emit(
          AiScanSuccess(
            message: 'Image analyzed successfully.',
            latestScan: scanResult,
            scans: List<AiScanResultEntity>.unmodifiable(_history),
            selectedImagePath: null,
          ),
        );
      },
    );
  }
}
