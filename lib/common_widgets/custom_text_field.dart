import 'package:flutter/material.dart';

// height of this TextField can be controlled.

class CustomOutlinedTextField extends StatelessWidget {
  CustomOutlinedTextField({
    required this.controller,
    required this.textHint,
    this.key,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    this.obscureText = false,
    this.errorText,
    this.height,
    this.width,
    this.textColor,
    this.hintTextColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.enabled,
    this.onEditingComplete,
    this.onChanged,
  });
  final TextEditingController controller;
  final String textHint;
  final double borderRadius;
  final double borderWidth;
  final bool obscureText;
  final double? height;
  final double? width;
  final String? errorText;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Key? key;
  final bool? enabled;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? null,
      width: width ?? null,
      child: TextFormField(
        key: key,
        onEditingComplete: onEditingComplete,
        enabled: enabled,
        onChanged: onChanged,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(color: textColor ?? Theme.of(context).primaryColor),
        cursorColor: cursorColor ?? Theme.of(context).primaryColor,
        decoration: InputDecoration(
          errorText: errorText,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: focusedBorderColor ?? Theme.of(context).primaryColor,
                width: borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: Theme.of(context).errorColor, width: borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
                color: Theme.of(context).errorColor, width: borderWidth),
          ),
          hintText: textHint,
          hintStyle:
              TextStyle(color: hintTextColor ?? Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
