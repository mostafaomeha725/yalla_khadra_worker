import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/my_works/domain/usecases/get_completed_work_details_use_case.dart';
import 'package:yallakhadra/features/my_works/presentation/cubit/my_work_details/my_work_details_state.dart';

class MyWorkDetailsCubit extends Cubit<MyWorkDetailsState> {
  final GetCompletedWorkDetailsUseCase _getCompletedWorkDetailsUseCase;

  MyWorkDetailsCubit(this._getCompletedWorkDetailsUseCase) : super(MyWorkDetailsInitial());

  Future<void> fetchDetails(int id) async {
    emit(MyWorkDetailsLoading());
    final result = await _getCompletedWorkDetailsUseCase(id);
    result.fold(
      (failure) => emit(MyWorkDetailsError(failure.message)),
      (details) => emit(MyWorkDetailsLoaded(details)),
    );
  }
}
