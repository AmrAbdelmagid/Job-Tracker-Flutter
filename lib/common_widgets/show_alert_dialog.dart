import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog({
  required BuildContext context,
  required String error,
  required String title,
  String? cancelActionText,
  String defaultActionText = 'Ok',
  List<Widget>? actions,
}) async {
  if (Platform.isIOS) {
    return await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(error.toString()),
            title: Text(title),
            actions: actions ??
                [
                  if (cancelActionText != null)
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(cancelActionText)),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(defaultActionText)),
                ],
          );
        });
  } else {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(error.toString()),
            title: Text(title),
            actions: actions ??
                [
                  if (cancelActionText != null)
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(cancelActionText)),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(defaultActionText)),
                ],
          );
        });
  }
}
