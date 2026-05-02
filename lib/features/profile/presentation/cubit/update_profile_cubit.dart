import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yallakhadra/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:yallakhadra/features/profile/presentation/cubit/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileCubit(this._updateProfileUseCase)
    : super(const UpdateProfileInitial());

  Future<void> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    String? profileImagePath,
  }) async {
    emit(const UpdateProfileLoading());

    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phoneNumber: phoneNumber,
        profileImagePath: profileImagePath,
      ),
    );

    result.fold((failure) => emit(UpdateProfileError(failure.message)), (
      response,
    ) {
      emit(
        UpdateProfileSuccess(
          response.message.trim().isEmpty
              ? 'Updated Successfully'
              : response.message,
        ),
      );
    });
  }
}
