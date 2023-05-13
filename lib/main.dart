// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/themes/app_theme.dart';
import 'package:tensor_flow_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
