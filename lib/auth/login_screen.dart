// ignore_for_file: use_build_context_synchronously

import 'package:chatting_app/auth/forget_password.dart';
import 'package:chatting_app/auth/signup_screen.dart';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      // Authentication successful, do something here if needed
      // For example, you can access the user using `userCredential.user`
      print('User logged in: ${userCredential.user?.email}');
    } catch (e) {
      // Authentication failed, handle the error
      print('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/chat.png',
              height: 90,
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _keyForm,
              child: Column(
                children: [
                  TextFormButton(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    textt: 'Email',
                    iconn: const Icon(CupertinoIcons.mail),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormButton(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    iconn: const Icon(CupertinoIcons.lock_open),
                    textt: 'Password',
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        if (_keyForm.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPassword(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ClickButton(
              textt: 'Login',
              onTapp: () async {
                if (_keyForm.currentState!.validate()) {
                  await signInWithEmailAndPassword();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'or-',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ClickButton(
              textt: 'Sign Up',
              onTapp: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
