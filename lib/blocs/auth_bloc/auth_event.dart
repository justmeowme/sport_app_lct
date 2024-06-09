abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String login;
  final String password;

  SignInEvent({required this.login, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String login;
  final String password;

  SignUpEvent({required this.login, required this.password});
}
