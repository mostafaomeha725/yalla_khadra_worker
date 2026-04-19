import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/home/domain/usecases/get_home_dashboard_use_case.dart';
import 'package:yallakhadra/features/home/presentation/constants/home_strings.dart';
import 'package:yallakhadra/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDashboardUseCase getHomeDashboardUseCase;

  HomeCubit({required this.getHomeDashboardUseCase})
    : super(const HomeInitial());

  Future<void> loadDashboard() async {
    emit(const HomeLoading());

    try {
      final dashboard = await getHomeDashboardUseCase();
      emit(HomeLoaded(dashboard));
    } catch (_) {
      emit(const HomeError(HomeStrings.loadingError));
    }
  }
}
