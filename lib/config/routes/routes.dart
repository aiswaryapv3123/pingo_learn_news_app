import 'package:flutter/material.dart';
import 'package:pingo_learn_news/config/routes/route_constants.dart';
import 'package:pingo_learn_news/features/auth/presentation/views/login_screen.dart';
import 'package:pingo_learn_news/features/auth/presentation/views/sign_up_screen.dart';

class AppRoutes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    final pages = switch (settings.name) {
      RouteConstants.loginPage => const LoginScreen(),
      RouteConstants.signUpPage => const SignUpScreen(),
      _ => throw Exception('Invalid Route'),
    };
    return MaterialPageRoute(builder: (context) => pages);
  }
}
