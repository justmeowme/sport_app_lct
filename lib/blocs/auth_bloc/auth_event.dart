import '../../models/user.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String login;
  final String password;

  SignInEvent({required this.login, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String login;
  final String password;
  final String name;

  SignUpEvent({required this.login, required this.password, this.name = "Без Имени"});
}

class SignOutEvent extends AuthEvent {}

class CompleteOnboardingEvent extends AuthEvent {
  final User user;

  CompleteOnboardingEvent({required this.user});
}
