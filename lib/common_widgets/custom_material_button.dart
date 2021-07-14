import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final double height;
  final double? width;
  final double circularBorderRadius;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final VoidCallback? onPressed;
  final Widget child;

  CustomMaterialButton({
    this.height = 50.0,
    this.width,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
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
        disabledColor: disabledColor ?? Colors.grey,
        disabledTextColor: disabledTextColor ?? Colors.black,
        textColor: Theme.of(context).accentColor,
        onPressed: onPressed,
        color: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius),
        ),
      ),
    );
  }
}
