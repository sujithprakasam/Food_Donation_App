import 'dart:math';

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final int maxLines;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.5),
    );
    final fBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.5),
    );
    final eBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: bBorder,
        focusedBorder: fBorder,
        enabledBorder: eBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      minLines: 1,
      maxLines: maxLines,
    );
  }
}
