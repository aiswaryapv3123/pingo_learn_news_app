import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';
import 'package:pingo_learn_news/config/themes/app_fonts.dart';

extension AppTextStyles on BuildContext {
  TextStyle? get mediumGrey14 => Theme.of(this).textTheme.titleMedium?.copyWith(
      fontSize: 14, color: AppColors.grey, fontWeight: AppFontWeights.medium);
  TextStyle? get mediumBlack14 =>
      Theme.of(this).textTheme.titleMedium?.copyWith(
          fontSize: 14,
          color: AppColors.primaryBlack,
          fontWeight: AppFontWeights.medium);
  TextStyle? get semiBoldWhite15 =>
      Theme.of(this).textTheme.titleMedium?.copyWith(
          fontSize: 15,
          color: AppColors.primaryWhite,
          fontWeight: AppFontWeights.semiBold);
  TextStyle? get semiBoldBlue15 =>
      Theme.of(this).textTheme.titleMedium?.copyWith(
          fontSize: 15,
          color: AppColors.primaryBlueDark,
          fontWeight: AppFontWeights.semiBold);
  TextStyle? get boldBlue22 =>
      Theme.of(this).textTheme.titleMedium?.copyWith(
          fontSize: 22,
          color: AppColors.primaryBlueDark,
          fontWeight: AppFontWeights.bold);
}
