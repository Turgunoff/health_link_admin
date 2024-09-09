part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  final String token; // Include token here

  AuthSuccess({required this.user, required this.token});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
