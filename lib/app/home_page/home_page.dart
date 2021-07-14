import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth_provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(context) async {
    final auth = AuthProvider.of(context);
    try {
      await auth.signOut();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  Future<void> _confirmSignOut(context) async {
    final bool isConfirmed = await showAlertDialog(
        context: context,
        error: 'Are you sure that you want to sign out?',
        title: 'Sign Out',
        cancelActionText: 'Cancel');
    if (isConfirmed) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Sign Out',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
