import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/extensions/app_text_styles.dart';
import 'package:pingo_learn_news/config/extensions/size_extensions.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';

class UserTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? label;
  final bool isPassword;
  final String? Function(String?)? validator;
  const UserTextField(
      {super.key,
      required this.textEditingController,
      required this.validator,
      this.label,
      this.isPassword = false});

  @override
  State<UserTextField> createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.heightFct(0.06),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextFormField(
          controller: widget.textEditingController,
          obscureText: showPassword,
          style: context.mediumBlack14,
          validator: widget.validator,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                        color: AppColors.greyLight,
                        showPassword ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            label: Text(widget.label ?? ''),
            labelStyle: context.mediumBlack14,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
