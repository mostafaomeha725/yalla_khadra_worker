import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_details_model.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_overview_model.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_reports_page_model.dart';

abstract class MyWorksRemoteDataSource {
  Future<Either<Failure, MyWorkOverviewModel>> getMyWorkOverview();
  Future<Either<Failure, MyWorkReportsPageModel>> getMyWorkReports({
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, MyWorkDetailsModel>> getCompletedWorkDetails(int id);
}
