import 'package:flutter/material.dart';
import 'package:riders_cafe/controllers/productcontroller.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.controllerText,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixText,
  });

  final ProductController controller;
  final String title;
  final TextEditingController controllerText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerText,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
        prefixText: prefixText,
      ),
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }
}