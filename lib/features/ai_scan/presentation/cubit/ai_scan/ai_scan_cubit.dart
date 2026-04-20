import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';
import 'package:yallakhadra/features/ai_scan/domain/usecases/scan_waste_image_usecase.dart';
import 'package:yallakhadra/features/ai_scan/presentation/cubit/ai_scan/ai_scan_state.dart';

class AiScanCubit extends Cubit<AiScanState> {
  final ScanWasteImageUseCase _scanWasteImageUseCase;
  final List<AiScanResultEntity> _history = <AiScanResultEntity>[];

  AiScanCubit(this._scanWasteImageUseCase) : super(const AiScanInitial());

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
