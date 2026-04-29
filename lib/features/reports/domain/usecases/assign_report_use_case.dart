import 'package:yallakhadra/features/reports/domain/repositories/reports_repository.dart';

class AssignReportUseCase {
  final ReportsRepository _repository;

  AssignReportUseCase(this._repository);

  Future<String> call(int reportId) => _repository.assignReport(reportId);
}
