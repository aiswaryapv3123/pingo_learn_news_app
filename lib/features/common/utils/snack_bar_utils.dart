import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';

void showErrorSnack(BuildContext context, String message,
    {int? durationInSeconds}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.primaryRed,
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    duration: Duration(seconds: durationInSeconds ?? 4),
  ));
}

void showSuccessSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.primaryGreen,
    content: Text(message),
    duration: const Duration(seconds: 1),
  ));
}
