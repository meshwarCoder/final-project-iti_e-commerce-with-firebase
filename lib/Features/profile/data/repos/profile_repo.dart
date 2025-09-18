import 'package:e_commerce/Features/auth/models/user_model.dart';

abstract class ProfileRepo {
  Future<UserModel> getUserData();
  Future<void> updateUserData({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String password,
  });
}
