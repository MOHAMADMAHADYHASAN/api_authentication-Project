import 'package:flutter/material.dart';

class CustomisedTextFeild extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;

  final String hint;
  final IconData prefixIcon;
  final bool obscureText;

  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  final int maxLines;

  const CustomisedTextFeild({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      obscuringCharacter: "*",
      keyboardType: keyboardType,
      style: TextStyle(color:Colors.white70),
      decoration: InputDecoration(
        labelText: label ,
        hintText: hint,
        prefixIcon: Icon(prefixIcon,color:

        Colors.white70,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.lightBlueAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
