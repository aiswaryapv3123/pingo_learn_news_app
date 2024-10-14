import 'package:flutter/material.dart';
import 'package:pingo_learn_news/features/auth/domain/repository/auth_repository.dart';
import 'package:pingo_learn_news/features/auth/domain/repository/auth_repository_impl.dart';

class RepositoryProvider {
  static AuthRepository getAuthRepository() {
    return AuthRepositoryImpl();
  }
}
