// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormButton extends StatefulWidget {
  final String textt;
  final Icon iconn;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  const TextFormButton({
    Key? key,
    required this.textt,
    required this.iconn,
    required this.controller,
    this.validator,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  State<TextFormButton> createState() => _TextFormButtonState();
}

class _TextFormButtonState extends State<TextFormButton> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.iconn,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: widget.textt,
      ),
      onSaved: widget.onSaved,
    );
  }
}
