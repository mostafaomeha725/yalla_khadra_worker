import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_reports_use_case.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_my_work_overview_use_case.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_overview/my_work_overview_state.dart';

class MyWorkOverviewCubit extends Cubit<MyWorkOverviewState> {
  final GetMyWorkOverviewUseCase _getMyWorkOverviewUseCase;
  final GetMyWorkReportsUseCase _getMyWorkReportsUseCase;

  MyWorkOverviewCubit(
    this._getMyWorkOverviewUseCase,
    this._getMyWorkReportsUseCase,
  ) : super(const MyWorkOverviewInitial());

  int _currentPage = 1;
  static const int _pageSize = 10;

  Future<void> loadOverview({int pageNumber = 1}) async {
    emit(const MyWorkOverviewLoading());

    final overviewResult = await _getMyWorkOverviewUseCase(NoParams());
    final reportsResult = await _getMyWorkReportsUseCase(
      MyWorkReportsParams(pageNumber: pageNumber, pageSize: _pageSize),
    );

    overviewResult.fold(
      (failure) => emit(MyWorkOverviewError(failure.message)),
      (overview) {
        reportsResult.fold(
          (failure) => emit(MyWorkOverviewError(failure.message)),
          (reportsPage) {
            _currentPage = reportsPage.currentPage;
            emit(MyWorkOverviewLoaded(overview, reportsPage));
          },
        );
      },
    );
  }

  Future<void> loadNextPage() async {
    final currentState = state;
    if (currentState is! MyWorkOverviewLoaded ||
        !currentState.reportsPage.hasNextPage) {
      return;
    }

    await loadOverview(pageNumber: _currentPage + 1);
  }

  Future<void> loadPreviousPage() async {
    final currentState = state;
    if (currentState is! MyWorkOverviewLoaded ||
        !currentState.reportsPage.hasPreviousPage) {
      return;
    }

    await loadOverview(pageNumber: _currentPage - 1);
  }
}
