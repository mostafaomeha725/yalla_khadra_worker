import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/reports/domain/usecases/assign_report_use_case.dart';

abstract class AssignReportState {
  const AssignReportState();
}

class AssignReportInitial extends AssignReportState {
  const AssignReportInitial();
}

class AssignReportLoading extends AssignReportState {
  const AssignReportLoading();
}

class AssignReportSuccess extends AssignReportState {
  final String message;

  const AssignReportSuccess(this.message);
}

class AssignReportFailure extends AssignReportState {
  final String errorMessage;

  const AssignReportFailure(this.errorMessage);
}

class AssignReportCubit extends Cubit<AssignReportState> {
  final AssignReportUseCase _assignReportUseCase;

  AssignReportCubit(this._assignReportUseCase)
    : super(const AssignReportInitial());

  Future<void> assignReport(int reportId) async {
    emit(const AssignReportLoading());
    try {
      final String message = await _assignReportUseCase(reportId);
      emit(AssignReportSuccess(message));
    } catch (e) {
      emit(AssignReportFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
