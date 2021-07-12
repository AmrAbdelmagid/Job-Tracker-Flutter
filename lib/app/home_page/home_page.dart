import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_tracker_flutter/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth, required this.onSignOut})
      : super(key: key);
  final AuthBase auth;

  final void Function() onSignOut;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
