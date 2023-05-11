// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/sizes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo-removebg-preview-1-1.png",
                  fit: BoxFit.fill,
                  color: backgroundColor,
                  height: getSize(context, 200),
                  width: getSize(context, 200),
                ),
                Text('Let’s get started!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context, 22))),
                const GapHeight(height: 10),
                Text(
                    'Login to enjoy the features we’ve provided, and take control of your lung!',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: getSize(context, 16))),
                const GapHeight(height: 30),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pinController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your PIN',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your PIN';
                    } else if (value.length != 4 ||
                        int.tryParse(value) == null) {
                      return 'Please enter a valid 4-digit PIN';
                    }
                    return null;
                  },
                ),
                const GapHeight(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot PIN?',
                      style: TextStyle(
                          color: backgroundColor, fontWeight: FontWeight.bold)),
                ),
                const GapHeight(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Container(
                    width: getSize(context, 200),
                    height: getSize(context, 40),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const GapHeight(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String id = _idController.text;
    String password = _pinController.text;

    var sharedPreferences = await SharedPreferences.getInstance();
    var user1 = sharedPreferences.getString("user1");
    var user2 = sharedPreferences.getString("user2");
    var user3 = sharedPreferences.getString("user3");
    var user4 = sharedPreferences.getString("user4");
    var pass1 = sharedPreferences.getString("pass1");
    var pass2 = sharedPreferences.getString("pass2");
    var pass3 = sharedPreferences.getString("pass3");
    var pass4 = sharedPreferences.getString("pass4");
    if (id == user1) {
      if (password == pass1) {
        Navigator.pushNamed(context, Routes.homeRoute, arguments: id);
      }
    } else if (id == user2) {
      if (password == pass2) {
        Navigator.pushNamed(context, Routes.homeRoute, arguments: id);
      }
    } else if (id == user3) {
      if (password == pass3) {
        Navigator.pushNamed(context, Routes.homeRoute, arguments: id);
      }
    } else if (id == user4) {
      if (password == pass4) {
        Navigator.pushNamed(context, Routes.homeRoute, arguments: id);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong. Please check again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
