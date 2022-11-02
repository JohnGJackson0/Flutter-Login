import 'package:flutter/foundation.dart';

class AuthRepository {
  Future<void> login() async {
    if (kDebugMode) {
      print('attempting login');
    }
    Future.delayed(const Duration(seconds: 3));
    if (kDebugMode) {
      print('logged in');
    }
  }
}
