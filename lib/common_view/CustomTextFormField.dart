import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final double borderRadius;
  final double borderWidth;
  final Color outlineBorderColor;
  final double? height;
  final double? width;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.borderWidth = 2.0,
    this.outlineBorderColor = const Color(0xFFE5E5E5),
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: outlineBorderColor,
        width: borderWidth,
      ),
    );

    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF000000),
            fontFamily: "Poppins",
            fontSize: 16,
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          enabledBorder: border,
          focusedBorder: border,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
