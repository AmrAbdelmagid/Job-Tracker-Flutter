import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/common_widgets/avatar.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
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

  _buildUserInfo(User? user) {
    return Column(
      children: [
        Avatar(
          radius: 50.0,
          url: user!.photoURL,
        ),
        SizedBox(
          height: 8.0,
        ),
        if (user.displayName != null)
          Text(
            user.displayName!,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: _buildUserInfo(auth.currentUser),
          preferredSize: Size.fromHeight(130),
        ),
      ),
    );
  }
}
