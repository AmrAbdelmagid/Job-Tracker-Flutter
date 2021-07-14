import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: _signOut,
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