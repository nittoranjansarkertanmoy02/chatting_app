import 'dart:async';
import 'package:chatting_app/auth/login_screen.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashFunctions {
  void isLogin(BuildContext context) {
    if (FirebaseConstants.auth.currentUser != null) {
      Timer(const Duration(seconds: 5), () {
        //Navigate to Home Screen(if already login)
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      });
    } else {
      //Navigate to Login Screen(if not already login)
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      });
    }
  }
}
