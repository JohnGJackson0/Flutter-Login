import 'package:flutter_login/auth/form_submission_status.dart';

// do validation here

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidUsername => username.length > 3;
  bool get isValidPassword => password.length > 6;

  LoginState(
      {this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
