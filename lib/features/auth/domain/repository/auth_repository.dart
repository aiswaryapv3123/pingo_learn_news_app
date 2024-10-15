import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';

abstract class AuthRepository {
  Future<Either<ApiFailure, UserCredential>> login(String email, String password);
  Future<Either<ApiFailure, void>> logout();
  Future<Either<ApiFailure, UserCredential>> signUp(String userName,String email, String password);
}
