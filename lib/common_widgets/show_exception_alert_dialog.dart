import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(
        context: context,
        error: _message(exception),
        title: title,
        defaultActionText: 'OK');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message.toString();
  } else {
    return exception.toString();
  }
}
