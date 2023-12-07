// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final prefixIcon;
  final String labelText;
  final keyboardType;
  final bool obscureText;
  final controller;
  final validator;

  const MyTextField({
    super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.keyboardType,
    required this.obscureText,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //   child:
        TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey[500],
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      // controller: controller.passwordEditingController,
      // ),
    );
  }
}
