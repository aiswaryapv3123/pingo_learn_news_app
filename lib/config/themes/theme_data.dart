import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';
import 'package:pingo_learn_news/config/themes/app_fonts.dart';

class AppThemeData {
  static ThemeData getAppThemeData(BuildContext context) => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.primaryBlueLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryBlueLight
        ),
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.primaryBlack,
            fontFamily: AppFonts.fontPoppins),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.primaryWhite),
            backgroundColor: WidgetStateProperty.all(AppColors.primaryBlueDark),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      );
}
