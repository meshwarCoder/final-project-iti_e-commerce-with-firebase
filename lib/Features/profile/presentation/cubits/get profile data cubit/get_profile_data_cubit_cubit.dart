import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_profile_data_cubit_state.dart';

class GetProfileDataCubitCubit extends Cubit<GetProfileDataCubitState> {
  GetProfileDataCubitCubit() : super(GetProfileDataCubitInitial());

  Future<void> getProfileData() async {
    try {
      emit(ProfileLoadingData());
      final user = await ProfileRepoImpl().getUserData();
      emit(ProfileLoadedData(user));
    } catch (e) {
      emit(ProfileErrorLoadingData(e.toString()));
    }
  }
}
