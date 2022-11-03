import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/auth/auth_repository.dart';
import 'package:flutter_login/auth/form_submission_status.dart';
import 'package:flutter_login/auth/login/login_event.dart';

import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginState()) {
    on<LoginUserNameChanged>(_onUserNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onUserNameChanged(
      LoginUserNameChanged event, Emitter<LoginState> emit) {
    final state = this.state;
    emit(LoginState(username: event.username, password: state.password));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final state = this.state;
    emit(LoginState(username: state.username, password: event.password));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginState(
        username: state.username,
        password: state.password,
        formStatus: FormSubmitting()));

    try {
      await authRepository.login(false);
      emit(LoginState(
          username: state.username,
          password: state.password,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(LoginState(
          username: state.username,
          password: state.password,
          formStatus: SubmissionFailed(e)));
    }
  }

  // before v 8 bloc
  /*
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserNameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
  }
  */
}
