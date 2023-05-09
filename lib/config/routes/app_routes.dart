import 'package:flutter/material.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/home.dart';

class Routes {
  static const String initialRoute = '/';
  static const String nextPageRoute = '/nextPageRoute';
  static const String homeRoute = '/homeRoute';
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
          return HomeScreen(id: routeSettings.arguments as String);
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
