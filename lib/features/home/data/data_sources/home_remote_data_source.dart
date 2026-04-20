import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/features/home/data/models/home_main_overview_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, HomeMainOverviewModel>> getMainOverview();
}
