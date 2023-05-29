import 'package:flutter/material.dart';

class DialogsIndicator {
  static void showIndicator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
