import 'package:chatting_app/auth/login_screen.dart';
import 'package:chatting_app/widgets/click_button.dart';
import 'package:chatting_app/widgets/textform_button.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios_new),
              10.widthBox,
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/chat.png',
              height: 90,
            ),
            const SizedBox(
              height: 35,
            ),
            TextFormButton(
              controller: emailController,
              textt: 'Enter Email',
              iconn: const Icon(Icons.email),
            ),
            15.heightBox,
            ClickButton(
              textt: 'Confirm',
              onTapp: () {},
            )
          ],
        ),
      ),
    );
  }
}
