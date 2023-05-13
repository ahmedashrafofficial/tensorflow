import 'package:flutter/material.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/add_patient.dart';
import 'package:tensor_flow_app/details.dart';
import 'package:tensor_flow_app/home.dart';
import 'package:tensor_flow_app/patient.dart';
import 'package:tensor_flow_app/upload.dart';

class Routes {
  static const String initialRoute = '/';
  static const String nextPageRoute = '/nextPageRoute';
  static const String homeRoute = '/homeRoute';
  static const String detailsRoute = '/detailsRoute';
  static const String uploadRoute = '/uploadRoute';
  static const String addPatientRoute = '/addPatientRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
      case Routes.nextPageRoute:
        return MaterialPageRoute(builder: (context) {
          return const NextPageScreen();
        });
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen(doctorId: routeSettings.arguments as String);
        });
      case Routes.detailsRoute:
        return MaterialPageRoute(builder: (context) {
          return DetailsScreen(patient: routeSettings.arguments as Patient);
        });
      case Routes.uploadRoute:
        return MaterialPageRoute(builder: (context) {
          return UploadScreen(patient: routeSettings.arguments as Patient);
        });
      case Routes.addPatientRoute:
        return MaterialPageRoute(builder: (context) {
          return AddPatientPage(doctorId: routeSettings.arguments as String);
        });
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(''),
              ),
            )));
  }
}
