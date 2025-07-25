import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String gender,
    required bool isAdmin,
    required DateTime createdAt,
  }) async {
    try {
      emit(AuthLoading());

      await FirebaseServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseServices.createUserInFirestore(
        UserModel(
          uid: _firebaseAuth.currentUser!.uid,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          address: address,
          password: password,
          gender: gender,
          isAdmin: isAdmin,
          createdAt: createdAt,
        ),
      );

      emit(AuthSuccess('The user has been created successfully'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      await FirebaseServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (await FirebaseServices.isEmailVerified()) {
        emit(AuthSuccess('The user has been logged in successfully'));
      } else {
        emit(AuthError('Email is not verified'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(AuthLoading());
      await FirebaseServices.signInWithGoogle();
      final userExists = await FirebaseServices.checkUserExists(
        _firebaseAuth.currentUser!.email!,
      );
      if (!userExists) {
        await FirebaseServices.createUserInFirestore(
          UserModel(
            uid: _firebaseAuth.currentUser!.uid,
            fullName: _firebaseAuth.currentUser!.displayName!,
            email: _firebaseAuth.currentUser!.email!,
            phoneNumber: _firebaseAuth.currentUser?.phoneNumber ?? '',
            address: '',
            password: '',
            gender: '',
            isAdmin: false,
            createdAt: DateTime.now(),
          ),
        );
      }
      emit(AuthSuccess('Login with Google successful'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logoutUser() async {
    try {
      emit(AuthLoading());
      await FirebaseServices.signOut();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError('Error logging out'));
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      emit(AuthLoading());
      await FirebaseServices.resetPassword(email);
      emit(AuthSuccess('The password has been reset successfully'));
    } catch (e) {
      emit(AuthError('Error resetting password'));
    }
  }

  void checkAuthState() {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthLoggedIn(userId: user.uid, email: user.email!));
    } else {
      emit(AuthLoggedOut());
    }
  }
}
