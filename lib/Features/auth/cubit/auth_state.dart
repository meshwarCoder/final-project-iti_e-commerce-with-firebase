part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthLoggedIn extends AuthState {
  final String userId;
  final String email;
  AuthLoggedIn({required this.userId, required this.email});
}

class AuthLoggedOut extends AuthState {}
