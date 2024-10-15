import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/constants/app_sizes.dart';
import 'package:pingo_learn_news/config/extensions/app_text_styles.dart';
import 'package:pingo_learn_news/config/extensions/size_extensions.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final void Function()? onPressed;
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.widthFct(0.18), vertical: AppSizes.gap12),
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: AppColors.primaryWhite,
                ),
              )
            : Text(
                label,
                style: context.semiBoldWhite15,
              ),
      ),
    );
  }
}
