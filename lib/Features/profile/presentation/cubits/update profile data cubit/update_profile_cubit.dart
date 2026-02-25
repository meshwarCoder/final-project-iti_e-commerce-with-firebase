import 'package:e_commerce/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:e_commerce/Features/profile/presentation/cubits/update%20profile%20data%20cubit/update_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    try {
      await ProfileRepoImpl().updateUserData(
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
        password: password,
      );
    } catch (e) {
      emit(ProfileErrorUpdate(e.toString()));
    }
  }
}
