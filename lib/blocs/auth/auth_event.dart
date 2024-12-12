abstract class AuthEvent {}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged(this.email);
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged(this.password);
}

class AuthLoginRequested extends AuthEvent {}

class AuthLogouRequested extends AuthEvent {}
