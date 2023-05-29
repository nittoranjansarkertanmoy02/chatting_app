// ignore_for_file: avoid_returning_null_for_void
import 'dart:io';
import 'package:chatting_app/constants/firebases_constants.dart';
import 'package:chatting_app/helpers/dialogs.dart';
import 'package:chatting_app/helpers/indicator.dart';
import 'package:chatting_app/screens/home_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  _withGoogle() {
    _signInWithGoogle().then((user) {
      DialogsIndicator.showIndicator(
        context,
      );
      if (user != null) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // log('Error $e' as num);
      Dialogs.showDialogs(context, 'Check your internet connection');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            const Text(
              'Chatting App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1.8,
              ),
            ),
            15.heightBox,
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormButton(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Username';
                        } else {
                          return null;
                        }
                      },
                      controller: usernameController,
                      textt: 'Username',
                      iconn: const Icon(CupertinoIcons.mail),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormButton(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        } else {
                          return null;
                        }
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
                          return 'Please Enter Password';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      iconn: const Icon(CupertinoIcons.lock_open),
                      textt: 'Password',
                    ),
                    15.heightBox,
                    TextFormButton(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Confirm Password';
                        } else {
                          return null;
                        }
                      },
                      controller: confirmPassword,
                      iconn: const Icon(CupertinoIcons.lock_open),
                      textt: 'Confirm Password',
                    ),
                  ],
                )),
            const SizedBox(
              height: 25,
            ),
            ClickButton(
              textt: 'Sign Up',
              onTapp: () {
                if (_formKey.currentState!.validate()) {
                  FirebaseConstants.auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              '-or-',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _withGoogle();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Signin with Google',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'images/google.png',
                      height: 25,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
