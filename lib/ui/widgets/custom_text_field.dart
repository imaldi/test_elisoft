import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final bool obscureText;
  final String? labelText;
  final TextEditingController? controller;

  const CustomTextField(
      {this.labelText,
      this.suffixIcon,
      this.obscureText = false,
      this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
          color: Colors.grey[400],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: labelText,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: suffixIcon,
          ),
        ));
  }
}
