import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_overview_use_case.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_state.dart';

class MyWorkOverviewCubit extends Cubit<MyWorkOverviewState> {
  final GetMyWorkOverviewUseCase _getMyWorkOverviewUseCase;

  MyWorkOverviewCubit(this._getMyWorkOverviewUseCase)
    : super(const MyWorkOverviewInitial());

  Future<void> loadOverview() async {
    emit(const MyWorkOverviewLoading());

    final result = await _getMyWorkOverviewUseCase(NoParams());

    result.fold(
      (failure) => emit(MyWorkOverviewError(failure.message)),
      (overview) => emit(MyWorkOverviewLoaded(overview)),
    );
  }
}
