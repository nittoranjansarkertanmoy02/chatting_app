// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, must_be_immutable
import 'package:flutter/material.dart';

class ClickButton extends StatefulWidget {
  final String textt;
  void Function()? onTapp;
  ClickButton({
    Key? key,
    required this.textt,
    required this.onTapp,
  }) : super(key: key);

  @override
  State<ClickButton> createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapp,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            widget.textt,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}
