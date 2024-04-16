import 'package:flutter/material.dart';

import '../constant/my_colors.dart';

class DefaultTextFormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool ? secure;
  final IconData? suffixIcon; // Optional suffix icon
  final String? Function(String?)? validator; // Validator function is now nullable
  final TextEditingController controller;
  final Function () ? suffixIconTap ;

  const DefaultTextFormField({
    super.key,
    required this.label,
    required this.icon,
    this.suffixIcon, // Optional suffix icon
    this.validator, // Validator function is now nullable
    this.secure,
    this.suffixIconTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            offset: Offset(8, 8),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon != null ? GestureDetector(
            onTap: suffixIconTap ?? (){},
              child: Icon(suffixIcon),
          ) : null, // Use suffix icon if provided
          focusColor: MyColors.myBlue,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        validator: validator, // Validator function is now nullable
        controller: controller,
        obscureText: secure?? false,
      ),
    );
  }
}
