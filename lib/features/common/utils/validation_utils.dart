import 'package:email_validator/email_validator.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';

bool isNullOrEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return true;
  }
  return false;
}

String? getEmailValidator(String? value) {
  if (isNullOrEmpty(value)) {
    return AppStrings.emptyEmailValidationMessage;
  }
  return EmailValidator.validate(value!)
      ? null
      : AppStrings.invalidEmailValidationMessage;
}

String? getNameValidator(String? value) {
  if (isNullOrEmpty(value)) {
    return AppStrings.emptyStringValidationMessage;
  }
  return null;
}

String? passwordValidator(String? value) {
  if (isNullOrEmpty(value)) {
    return AppStrings.emptyPasswordValidationMessage;
  }
  return null;
}

String? confirmPasswordValidator(String password, String? confirmPassword) {
  if (isNullOrEmpty(confirmPassword)) {
    return AppStrings.emptyPasswordValidationMessage;
  } else if (password.isEmpty || password != confirmPassword) {
    return AppStrings.passwordMatchValidationMessage;
  }
  return null;
}
