import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingo_learn_news/config/routes/route_constants.dart';
import 'package:pingo_learn_news/config/routes/routes.dart';
import 'package:pingo_learn_news/config/routes/routes_utils.dart';
import 'package:pingo_learn_news/config/themes/theme_data.dart';
import 'package:pingo_learn_news/features/auth/presentation/views/login_screen.dart';
import 'package:pingo_learn_news/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pingo Learn News',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.getAppThemeData(context),
      navigatorKey: RouteUtils.navKey,
      onGenerateRoute: AppRoutes.generatedRoute,
      initialRoute: RouteConstants.loginPage,
    );
  }
}
