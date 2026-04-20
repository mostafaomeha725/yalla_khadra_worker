import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/my_works/data/models/my_work_overview_model.dart';

abstract class MyWorksRemoteDataSource {
  Future<Either<Failure, MyWorkOverviewModel>> getMyWorkOverview();
}
