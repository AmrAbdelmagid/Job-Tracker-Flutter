import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final double height;
  final double? width;
  final double circularBorderRadius;
  final Color? color;
  final VoidCallback onPressed;
  final Widget child;

  CustomMaterialButton({
    this.height = 50.0,
    this.width,
    this.color,
    this.circularBorderRadius = 4.0,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        child: child,
        onPressed: onPressed,
        color: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
        ),
      ),
    );
  }
}
