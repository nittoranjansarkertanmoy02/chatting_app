import 'dart:async';
import 'package:chatting_app/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashFunctions {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
  }
}
