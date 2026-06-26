import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yallakhadra/core/cache/preferences_storage.dart';
import 'package:yallakhadra/features/home/domain/usecases/complete_cleanup_task_use_case.dart';
import 'package:yallakhadra/features/home/domain/usecases/get_home_dashboard_use_case.dart';
import 'package:yallakhadra/features/home/domain/usecases/update_user_location_use_case.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDashboardUseCase getHomeDashboardUseCase;
  final CompleteCleanupTaskUseCase completeCleanupTaskUseCase;
  final UpdateUserLocationUseCase updateUserLocationUseCase;
  final PreferencesStorage preferencesStorage;

  HomeCubit({
    required this.getHomeDashboardUseCase,
    required this.completeCleanupTaskUseCase,
    required this.updateUserLocationUseCase,
    required this.preferencesStorage,
  }) : super(const HomeInitial());

  Future<void> loadDashboard() async {
    emit(const HomeLoading());

    try {
      // Step 1: Check permission first
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        final bool hasRequested = preferencesStorage.getHasRequestedLocation();
        if (!hasRequested) {
          // First time → ask the user
          await preferencesStorage.setHasRequestedLocation(true);
          permission = await Geolocator.requestPermission();
        } else {
          // Not first time → show "Enable Location" button
          emit(const HomeLocationPermissionDenied());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Show "Open App Settings" button
        emit(const HomeLocationDeniedForever());
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Step 2: Permission granted → check if GPS service is enabled
        final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (serviceEnabled) {
          // Get location and update backend
          try {
            Position? position = await Geolocator.getLastKnownPosition();
            position ??= await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.low,
                timeLimit: Duration(seconds: 3),
              ),
            );
            await updateUserLocationUseCase(UpdateUserLocationParams(
              latitude: position.latitude,
              longitude: position.longitude,
            ));
          } catch (_) {
            // Ignore location errors, proceed to load dashboard
          }
        } else {
          // GPS off → show "Turn On Location" button
          emit(const HomeLocationServiceDisabled());
        }
      }

      // Always load the dashboard regardless of location outcome
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
