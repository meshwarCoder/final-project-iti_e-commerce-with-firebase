class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadingUpdate extends ProfileState {}

class ProfileSuccessUpdate extends ProfileState {}

class ProfileErrorUpdate extends ProfileState {
  final String message;
  ProfileErrorUpdate(this.message);
}
