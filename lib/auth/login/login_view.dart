import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/auth/auth_repository.dart';
import 'package:flutter_login/auth/form_submission_status.dart';
import 'package:flutter_login/auth/login/login_bloc.dart';
import 'package:flutter_login/auth/login/login_event.dart';

import 'login_state.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      child: _loginForm(),
      create: (context) => LoginBloc(context.read<AuthRepository>()),
    ));
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _userNameField(),
                      _passwordField(),
                      _loginButton()
                    ]))));
  }

  Widget _userNameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginUserNameChanged(value)),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.security),
            hintText: 'Password',
          ),
          validator: (value) =>
              state.isValidPassword ? null : 'Password is too short',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value))),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Text('Login')));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
