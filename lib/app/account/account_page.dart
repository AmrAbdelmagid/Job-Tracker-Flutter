import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _signOut(context) async {
      final auth = Provider.of<AuthBase>(context, listen: false);
      try {
        await auth.signOut();
      } catch (e, s) {}
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

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
