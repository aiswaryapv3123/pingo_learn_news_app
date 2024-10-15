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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController cnfPasswordTextEditingController =
      TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
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
    nameTextEditingController.dispose();
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
                  textEditingController: nameTextEditingController,
                  label: AppStrings.name,
                  validator: getNameValidator,
                ),
                const Gap(AppSizes.gap20),
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
                const Gap(AppSizes.gap20),
                UserTextField(
                  textEditingController: cnfPasswordTextEditingController,
                  isPassword: true,
                  label: AppStrings.confirmPassword,
                  validator: (confirmPassword) {
                    return confirmPasswordValidator(
                        passwordTextEditingController.text, confirmPassword);
                  },
                ),
                const Spacer(),
                Consumer<AuthRepoProvider>(builder: (context, data, child) {
                  return PrimaryButton(
                    isLoading: data.signUpLoading,
                    label: AppStrings.signUp,
                    onPressed: onTapSignUp,
                  );
                }),
                const Gap(AppSizes.gap10),
                RichText(
                  text: TextSpan(
                    text: AppStrings.alreadyHaveAnAccount,
                    style: context.mediumBlack14,
                    children: <TextSpan>[
                      TextSpan(
                        text: AppStrings.login,
                        style: context.semiBoldBlue15,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => onTapLogin(),
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

  onTapLogin() {
    Navigator.of(context).pushReplacementNamed(RouteConstants.loginPage);
  }

  onTapSignUp() {
    if (formKey.currentState?.validate() ?? false) {
      debugPrint("Form validation success!");
      _register();
    }
  }

  clearFields() {
    setState(() {
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
      nameTextEditingController.clear();
    });
  }

  Future<void> _register() async {
    var response = await authProvider.signUp(nameTextEditingController.text,
        emailTextEditingController.text, passwordTextEditingController.text);
    response.fold((l) {
      showErrorSnack(context, "${l.message}");
    }, (r) {
      showSuccessSnack(context, "Successfully Registered User !");
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteConstants.newsFeedPage, (Route<dynamic> route) => false);
    });
    clearFields();
  }
}
