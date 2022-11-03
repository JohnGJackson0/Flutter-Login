import 'package:flutter/foundation.dart';

class AuthRepository {
  Future<void> login(bool fail) async {
    if (kDebugMode) {
      print('attempting login');
    }
    await Future.delayed(const Duration(seconds: 3));
    if (kDebugMode) {
      print('logged in');
    }
    if (fail) {
      throw Exception('Failed login Message');
    }
  }
}
