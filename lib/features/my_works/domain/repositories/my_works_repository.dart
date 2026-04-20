import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_overview_entity.dart';

abstract class MyWorksRepository {
  Future<Either<Failure, MyWorkOverviewEntity>> getMyWorkOverview();
}
