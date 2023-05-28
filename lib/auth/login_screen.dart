// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatting_app/widgets/click_button.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool animation = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4));
    setState(() {
      animation = true;
    });
  }

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
            TextFormButton(
              textt: 'Email',
              iconn: Icon(CupertinoIcons.mail),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormButton(
              iconn: Icon(CupertinoIcons.lock_open),
              textt: 'Password',
            ),
            SizedBox(
              height: 15,
            ),
            ClickButton(
              textt: 'Login',
              onTapp: () {},
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
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signin with Google',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.8,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'images/google.png',
                      height: 25,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
