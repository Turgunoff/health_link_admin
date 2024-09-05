part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterUserEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent({required this.email, required this.password});
}
