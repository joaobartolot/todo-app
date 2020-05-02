import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_firebase/service/auth_service.dart';
import 'package:todo_firebase/util/failure.dart';

class SignUpProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  Future<Either<Failure, FirebaseUser>> createUser(
      {String name, String email, String password, String photoUrl}) async {
    return await _authService.signUp(name, email, password, photoUrl);
  }
}
