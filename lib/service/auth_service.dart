import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_firebase/helper/user_helper.dart';
import 'package:todo_firebase/util/constants.dart';
import 'package:todo_firebase/util/failure.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<Failure, FirebaseUser>> signIn(
      String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return Left(Failure(error: e.code, mensage: e.message));
    }

    UserHelper.setUserUid(result.user.uid);
    return Right(result.user);
  }
}
