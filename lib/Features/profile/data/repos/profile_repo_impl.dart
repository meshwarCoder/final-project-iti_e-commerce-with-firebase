import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/Features/profile/data/repos/profile_repo.dart';
import 'package:e_commerce/Features/profile/data/firebase/editprofile_services.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<UserModel> getUserData() {
    return FirebaseEditProfileServices.getCurrentUserData();
  }

  @override
  Future<void> updateUserData({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String password,
  }) {
    return FirebaseEditProfileServices.updateUserData(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      password: password,
    );
  }
}
