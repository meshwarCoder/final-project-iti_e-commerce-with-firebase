part of 'get_profile_data_cubit_cubit.dart';

sealed class GetProfileDataCubitState {}

final class GetProfileDataCubitInitial extends GetProfileDataCubitState {}

class ProfileLoadingData extends GetProfileDataCubitState {}

class ProfileLoadedData extends GetProfileDataCubitState {
  final UserModel user;
  ProfileLoadedData(this.user);
}

class ProfileErrorLoadingData extends GetProfileDataCubitState {
  final String message;
  ProfileErrorLoadingData(this.message);
}
