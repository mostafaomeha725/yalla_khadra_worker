import 'package:dartz/dartz.dart';
import 'package:yallakhadra/core/error/failure.dart';
import 'package:yallakhadra/core/usecase/base_usecase.dart';
import 'package:yallakhadra/features/home/domain/repositories/home_repository.dart';

class UpdateUserLocationUseCase
    implements UseCase<void, UpdateUserLocationParams> {
  final HomeRepository repository;

  UpdateUserLocationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserLocationParams params) async {
    try {
      await repository.updateUserLocation(
        latitude: params.latitude,
        longitude: params.longitude,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class UpdateUserLocationParams {
  final double latitude;
  final double longitude;

  UpdateUserLocationParams({
    required this.latitude,
    required this.longitude,
  });
}
