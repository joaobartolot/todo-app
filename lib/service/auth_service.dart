import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    return Right(result.user);
  }

  Future<Either<Failure, FirebaseUser>> signUp(
      String name, String email, String password, String photoUrl) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return Left(Failure(error: e.code, mensage: e.message));
    }

    UserUpdateInfo profileUpdates = UserUpdateInfo();
    profileUpdates.displayName = name;
    profileUpdates.photoUrl = photoUrl;

    result.user.updateProfile(profileUpdates);

    return Right(result.user);
  }
}
