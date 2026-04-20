import 'package:equatable/equatable.dart';
import 'package:yallakhadra/features/ai_scan/domain/entities/ai_scan_result_entity.dart';

abstract class AiScanState extends Equatable {
  final List<AiScanResultEntity> scans;
  final String? selectedImagePath;

  const AiScanState({required this.scans, required this.selectedImagePath});

  @override
  List<Object?> get props => <Object?>[scans, selectedImagePath];
}

class AiScanInitial extends AiScanState {
  const AiScanInitial()
    : super(scans: const <AiScanResultEntity>[], selectedImagePath: null);
}

class AiScanImageSelected extends AiScanState {
  const AiScanImageSelected({
    required super.scans,
    required super.selectedImagePath,
  });
}

class AiScanLoaded extends AiScanState {
  const AiScanLoaded({required super.scans, required super.selectedImagePath});
}

class AiScanLoading extends AiScanState {
  final String message;

  const AiScanLoading({
    required this.message,
    required super.scans,
    required super.selectedImagePath,
  });

  @override
  List<Object?> get props => <Object?>[message, ...super.props];
}

class AiScanSuccess extends AiScanState {
  final String message;
  final AiScanResultEntity latestScan;

  const AiScanSuccess({
    required this.message,
    required this.latestScan,
    required super.scans,
    required super.selectedImagePath,
  });

  @override
  List<Object?> get props => <Object?>[message, latestScan, ...super.props];
}

class AiScanError extends AiScanState {
  final String message;

  const AiScanError({
    required this.message,
    required super.scans,
    required super.selectedImagePath,
  });

  @override
  List<Object?> get props => <Object?>[message, ...super.props];
}
