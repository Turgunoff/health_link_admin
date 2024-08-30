part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  // ... boshqa kerakli ma'lumotlar

  RegisterUserEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    // ... boshqa ma'lumotlar
  });
}
