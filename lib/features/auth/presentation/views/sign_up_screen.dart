import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/config/extensions/app_text_styles.dart';
import 'package:pingo_learn_news/config/extensions/size_extensions.dart';
import 'package:pingo_learn_news/config/routes/route_constants.dart';
import 'package:pingo_learn_news/core/utils/validation_utils.dart';
import 'package:pingo_learn_news/config/constants/app_sizes.dart';
import 'package:pingo_learn_news/features/common/widgets/primary_button.dart';
import 'package:pingo_learn_news/features/common/widgets/user_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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
                const Spacer(),
                PrimaryButton(
                  label: AppStrings.login,
                  onPressed: () {},
                ),
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
    Navigator.of(context).pushNamed(RouteConstants.loginPage);
  }

  onTapSignUp() {
    if (formKey.currentState?.validate() ?? false) {
      debugPrint("Form validation success!");
      _register();
    } else {
      debugPrint("Form validation failed!");
      clearFields();
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
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );

      await _fireStore.collection('users').doc(userCredential.user?.uid).set({
        'name': nameTextEditingController.text,
        'email': emailTextEditingController.text,
      });
      clearFields();
    } catch (e) {
      debugPrint("Some error occurred! $e ");
    }
  }
}
