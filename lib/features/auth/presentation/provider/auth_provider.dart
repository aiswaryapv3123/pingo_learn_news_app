import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pingo_learn_news/core/error/api_failure.dart';
import 'package:pingo_learn_news/features/auth/domain/repository/auth_repository.dart';
import 'package:pingo_learn_news/features/common/utils/snack_bar_utils.dart';

class AuthRepoProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  bool loginLoading = false;
  UserCredential? userLoginCredential;
  String? loginErrorMessage;
  bool signUpLoading = false;
  UserCredential? userSignUpCredential;
  String? signUpErrorMessage;
  bool logOutLoading = false;
  AuthRepoProvider({required this.authRepository});

  Future<Either<ApiFailure, UserCredential>> login(
      String email, String password) async {
    updateLoginLoading(true);
    Either<ApiFailure, UserCredential> response =
        await authRepository.login(email, password);
    updateLoginLoading(false);
    notifyListeners();
    return response;
  }

  Future<Either<ApiFailure, UserCredential>> signUp(
      String userName, String email, String password) async {
    updateSignUpLoading(true);
    Either<ApiFailure, UserCredential> response =
        await authRepository.signUp(userName, email, password);

    updateSignUpLoading(false);
    notifyListeners();
    return response;
  }

  logOut(BuildContext context) async {
    updateLogOutLoading(true);
    Either<ApiFailure, void> response = await authRepository.logout();
    response.fold((l) {
      updateLogOutLoading(false);
      showSuccessSnack(context, "Successfully logged out..!");
    }, (r) {
      updateLogOutLoading(false);
      showSuccessSnack(context, "Failed to logout..!");
    });
    notifyListeners();
  }

  updateLoginLoading(bool value) {
    loginLoading = value;
    notifyListeners();
  }

  updateSignUpLoading(bool value) {
    signUpLoading = value;
    notifyListeners();
  }

  updateLogOutLoading(bool value) {
    logOutLoading = value;
    notifyListeners();
  }
}
