import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/home_page/home_page.dart';
import 'package:job_tracker_flutter/app/sign_in_page/sign_in_page.dart';
import 'package:job_tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
  final AuthBase auth;
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
