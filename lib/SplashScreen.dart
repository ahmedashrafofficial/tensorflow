import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/login.dart';
import '../utils.dart';

const backgroundColor = Color(0xFF199A8E);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true; // add new variable for visibility state

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _init();
      setState(() {
        _visible = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.nextPageRoute, (route) => false);
    });
  }

  Future<void> _init() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey("user1")) {
      sharedPreferences.setString("user1", "1231");
    }
    if (!sharedPreferences.containsKey("user2")) {
      sharedPreferences.setString("user2", "1232");
    }
    if (!sharedPreferences.containsKey("user3")) {
      sharedPreferences.setString("user3", "1233");
    }
    if (!sharedPreferences.containsKey("user4")) {
      sharedPreferences.setString("user4", "1234");
    }
    if (!sharedPreferences.containsKey("pass1")) {
      sharedPreferences.setString("pass1", "1231");
    }
    if (!sharedPreferences.containsKey("pass2")) {
      sharedPreferences.setString("pass2", "1232");
    }
    if (!sharedPreferences.containsKey("pass3")) {
      sharedPreferences.setString("pass3", "1233");
    }
    if (!sharedPreferences.containsKey("pass4")) {
      sharedPreferences.setString("pass4", "1234");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Image.asset('assets/images/logo-removebg-preview-1-1.png'),
        ),
      ),
    );
  }
}

class NextPageScreen extends StatelessWidget {
  const NextPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double size = getSize(context, 1);
    double fontSize = size * 0.95;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/xm-1.png',
              fit: BoxFit.fill,
              height: getSize(context, 500),
            ),
            const GapHeight(height: 10),
            Text(
              'Discover the power of AI in lung disease diagnosis.',
              style: SafeGoogleFont(
                'Inter',
                fontSize: 18 * fontSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xff101522),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/slider-vKu.png',
                  width: 43.89 * size,
                  height: 4 * size,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => const Page3(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            }));
                  },
                  child: CircleAvatar(
                    backgroundColor: backgroundColor,
                    child: Image.asset(
                      'assets/images/icon-arrow-right-Dq5.png',
                      width: 24 * size,
                      height: 24 * size,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    double size = getSize(context, 1);
    double fontSize = size * 0.95;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/xm-22.png',
              fit: BoxFit.fill,
              height: getSize(context, 500),
            ),
            const GapHeight(height: 10),
            Text(
              'Simply upload an image and receive a confident diagnosis.',
              style: SafeGoogleFont(
                'Inter',
                fontSize: 18 * fontSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xff101522),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/slider.png',
                  width: 43.89 * size,
                  height: 4 * size,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => const LoginPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            }));
                  },
                  child: CircleAvatar(
                    backgroundColor: backgroundColor,
                    child: Image.asset(
                      'assets/images/icon-arrow-right-Dq5.png',
                      width: 24 * size,
                      height: 24 * size,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
