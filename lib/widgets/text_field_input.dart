import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Color fillColor;
  final BorderRadius borderRadius;
  final void Function(String)? onChanged;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    required this.fillColor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        10,
      ),
    ),
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(width: 1.0),
    );
    return TextField(
      style: const TextStyle(color: Colors.black),
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
