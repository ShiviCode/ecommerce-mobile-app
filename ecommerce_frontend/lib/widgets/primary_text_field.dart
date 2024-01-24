import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final String? initialValue;
  final Function(String)? onChanged;

  const PrimaryTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.suffix,
    this.initialValue, 
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: suffix,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
