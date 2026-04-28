import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/home/domain/usecases/complete_cleanup_task_use_case.dart';
import 'package:yallakhadra/features/home/domain/usecases/get_home_dashboard_use_case.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDashboardUseCase getHomeDashboardUseCase;
  final CompleteCleanupTaskUseCase completeCleanupTaskUseCase;

  HomeCubit({
    required this.getHomeDashboardUseCase,
    required this.completeCleanupTaskUseCase,
  }) : super(const HomeInitial());

  Future<void> loadDashboard() async {
    emit(const HomeLoading());

    try {
      final dashboard = await getHomeDashboardUseCase();
      emit(HomeLoaded(dashboard));
    } catch (_) {
      emit(const HomeError(HomeStrings.loadingError));
    }
  }

  Future<void> completeCleanupTask({
    required int taskId,
    required int finalWasteType,
    required String finalWeightInKg,
    required List<String> imagePaths,
  }) async {
    emit(const HomeCleanupTaskCompleting());

    final result = await completeCleanupTaskUseCase(
      CompleteCleanupTaskParams(
        taskId: taskId,
        finalWasteType: finalWasteType,
        finalWeightInKg: finalWeightInKg,
        imagePaths: imagePaths,
      ),
    );

    result.fold(
      (failure) => emit(HomeCleanupTaskCompleteError(failure.message)),
      (_) => emit(
        const HomeCleanupTaskCompleted('Cleanup task completed successfully.'),
      ),
    );
  }
}
