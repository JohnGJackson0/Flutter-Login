import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loginForm());
  }

  Widget _loginForm() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_userNameField(), _passwordField(), _loginButton()]));
  }

  Widget _userNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Username',
      ),
      validator: (value) => null
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        hintText: 'Password',
      ),
      validator: (value) => null
    );
  }

  Widget _loginButton() {
    return ElevatedButton(onPressed: () {}, child: const Text('Login'));
  }
}
