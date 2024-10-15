import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/core/error/api_errors.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';
import 'package:pingo_learn_news/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<Either<ApiFailure, UserCredential>> login(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = userCredential.user?.uid;
      DocumentSnapshot userDoc =
          await _fireStore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        return Left(ClientError(
          message: "No user found for that email.",
          errorCode: 404,
          validationMessage: "No user found for that email.",
        ));
      }
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerError(
        message: "${e.message}",
        errorCode: 404,
        validationMessage: "${e.message}",
      ));
    } catch (e) {
      return Left(ServerError(
        message: AppStrings.failedToConnect,
        errorCode: 500,
        validationMessage: AppStrings.internalServerError,
      ));
    }
  }

  @override
  Future<Either<ApiFailure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerError(
        message: AppStrings.failedToConnect,
        errorCode: 500,
        validationMessage: AppStrings.internalServerError,
      ));
    }
  }

  @override
  Future<Either<ApiFailure, UserCredential>> signUp(String userName,
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _fireStore.collection('users').doc(userCredential.user?.uid).set({
        'name': userName,
        'email': email,
      });
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerError(
        message: "${e.message}",
        errorCode: 404,
        validationMessage: "${e.message}",
      ));
    } catch (e) {
      return Left(ServerError(
        message: AppStrings.failedToConnect,
        errorCode: 500,
        validationMessage: AppStrings.internalServerError,
      ));
    }
  }
}
