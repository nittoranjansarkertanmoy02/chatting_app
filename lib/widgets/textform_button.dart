// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormButton extends StatefulWidget {
  final String textt;
  final Icon iconn;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFormButton({
    Key? key,
    required this.textt,
    required this.iconn,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<TextFormButton> createState() => _TextFormButtonState();
}

class _TextFormButtonState extends State<TextFormButton> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.iconn,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: widget.textt,
      ),
    );
  }
}
