// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:chatting_app/auth/forget_password.dart';
import 'package:chatting_app/auth/signup_screen.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/chat.png',
              height: 90,
            ),
            SizedBox(
              height: 25,
            ),
            Form(
                child: Column(
              children: [
                TextFormButton(
                  controller: emailController,
                  textt: 'Email',
                  iconn: Icon(CupertinoIcons.mail),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormButton(
                  controller: passwordController,
                  iconn: Icon(CupertinoIcons.lock_open),
                  textt: 'Password',
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ));
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 25,
            ),
            ClickButton(
              textt: 'Login',
              onTapp: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'or-',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ClickButton(
              textt: 'Sign Up',
              onTapp: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
