abstract class LoginEvent {}

class LoginUserNameChanged extends LoginEvent {
  final String username;

  LoginUserNameChanged(this.username);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {}
