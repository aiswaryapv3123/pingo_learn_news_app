import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/config/extensions/app_text_styles.dart';
import 'package:pingo_learn_news/config/extensions/size_extensions.dart';
import 'package:pingo_learn_news/config/routes/route_constants.dart';
import 'package:pingo_learn_news/features/auth/presentation/provider/auth_provider.dart';
import 'package:pingo_learn_news/features/common/utils/snack_bar_utils.dart';
import 'package:pingo_learn_news/features/common/utils/validation_utils.dart';
import 'package:pingo_learn_news/config/constants/app_sizes.dart';
import 'package:pingo_learn_news/features/common/widgets/primary_button.dart';
import 'package:pingo_learn_news/features/common/widgets/user_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late AuthRepoProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AuthRepoProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.widthFct(0.07)),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(context.heightFct(0.05)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.myNews,
                      style: context.boldBlue22,
                    )),
                const Spacer(),
                UserTextField(
                  textEditingController: emailTextEditingController,
                  label: AppStrings.email,
                  validator: getEmailValidator,
                ),
                const Gap(AppSizes.gap20),
                UserTextField(
                  textEditingController: passwordTextEditingController,
                  isPassword: true,
                  label: AppStrings.password,
                  validator: passwordValidator,
                ),
                const Spacer(),
                Consumer<AuthRepoProvider>(builder: (context, data, child) {
                  return PrimaryButton(
                    isLoading: data.loginLoading,
                    label: AppStrings.login,
                    onPressed: onTapLogin,
                  );
                }),
                const Gap(AppSizes.gap10),
                RichText(
                  text: TextSpan(
                    text: AppStrings.newHere,
                    style: context.mediumBlack14,
                    children: <TextSpan>[
                      TextSpan(
                        text: AppStrings.signUp,
                        style: context.semiBoldBlue15,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => onTapSignUp(),
                      ),
                    ],
                  ),
                ),
                const Gap(AppSizes.gap20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapSignUp() {
    Navigator.of(context).pushNamed(RouteConstants.signUpPage);
  }

  onTapLogin() async {
    if (formKey.currentState?.validate() ?? false) {
      debugPrint("Form validation success!");
      var response = await authProvider.login(
          emailTextEditingController.text, passwordTextEditingController.text);
      response.fold((l) {
        showErrorSnack(context, "${l.message}");
      }, (r) {
        showSuccessSnack(context, "Successfully Logged in !");
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteConstants.newsFeedPage, (Route<dynamic> route) => false);
      });
      clearFields();
    } else {
      debugPrint("Form validation failed!");
      clearFields();
    }
  }

  clearFields() {
    setState(() {
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
    });
  }
}
