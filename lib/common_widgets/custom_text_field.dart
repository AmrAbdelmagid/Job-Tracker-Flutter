import 'package:flutter/material.dart';

// height of this TextField can be controlled.

class CustomOutlinedTextField extends StatelessWidget {
  CustomOutlinedTextField({
    required this.controller,
    required this.textHint,
    this.key,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    this.height,
    this.width,
    this.textColor,
    this.hintTextColor,
    this.borderColor,
  });
  final TextEditingController controller;
  final String textHint;
  final double borderRadius;
  final double borderWidth;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final Key? key;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? null,
      width: width ?? null,
      child: TextFormField(
        key: key,
        controller: controller,
        style: TextStyle(color: textColor ?? Theme.of(context).primaryColor),
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: borderWidth),
          ),
          hintText: textHint,
          hintStyle:
              TextStyle(color: hintTextColor ?? Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
