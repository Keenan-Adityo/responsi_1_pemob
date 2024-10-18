import 'package:flutter/material.dart';
import 'package:responsi1/styles/test_styles.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController _textboxController;
  final String labelText;
  final bool isObscure;
  final TextInputType inputType;

  const CustomFormField({
    super.key,
    required TextEditingController textboxController,
    required String this.labelText,
    this.isObscure = false,
    this.inputType = TextInputType.text,
  }) : _textboxController = textboxController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: normal,
      ),
      keyboardType: TextInputType.text,
      obscureText: isObscure,
      controller: _textboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "${labelText} harus diisi";
        }
        return null;
      },
    );
  }
}
