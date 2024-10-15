import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: AppColors.primaryBlueDark,
      ),
    );
  }
}
