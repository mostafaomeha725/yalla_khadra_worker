import 'package:equatable/equatable.dart';
import 'package:yallakhadra/features/my_works/domain/entities/my_work_details_entity.dart';

abstract class MyWorkDetailsState extends Equatable {
  const MyWorkDetailsState();

  @override
  List<Object?> get props => [];
}

class MyWorkDetailsInitial extends MyWorkDetailsState {}

class MyWorkDetailsLoading extends MyWorkDetailsState {}

class MyWorkDetailsLoaded extends MyWorkDetailsState {
  final MyWorkDetailsEntity details;

  const MyWorkDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class MyWorkDetailsError extends MyWorkDetailsState {
  final String message;

  const MyWorkDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
