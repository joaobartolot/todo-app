import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_firebase/service/auth_service.dart';
import 'package:todo_firebase/util/failure.dart';

class LoginProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  Future<Either<Failure, FirebaseUser>> authenticateUser(
      String email, String password) async {
    return await _authService.signIn(email, password);
  }

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}
