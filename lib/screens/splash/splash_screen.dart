import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_link_admin/model/user_model.dart';
import 'package:health_link_admin/screens/auth/sign_in_screen.dart';
import 'package:health_link_admin/screens/auth/sign_up_screen.dart';
import 'package:health_link_admin/screens/drawer/main_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userJson = prefs.getString('user');

    // Navigate after a short delay (optional, for visual effect)
    await Future.delayed(const Duration(seconds: 2));

    if (token != null && userJson != null) {
      final Map<String, dynamic> userData = jsonDecode(userJson);
      final UserModel user = UserModel.fromJson(userData);
      print(userData);
      print(user);
      print(token);
      // If token exists, navigate to MainApp
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainApp(user: user, token: token)),
      );
    } else {
      // If no token, navigate to SignUpScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Or any loading indicator
      ),
    );
  }
}
