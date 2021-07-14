import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/sign_in_page/sign_in_form.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Tracker',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.0,
              ),
              SignInForm(
                auth: auth,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 1,
                    width: 100.0,
                    color: Colors.grey,
                  ),
                  Text('Or'),
                  Container(
                    height: 1,
                    width: 100.0,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomMaterialButton(
                color: Theme.of(context).primaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/google-logo.png')),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Connect With Google',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                onPressed: _signInWithGoogle,
                circularBorderRadius: 32.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(alignment: Alignment.center, child: Text('Or')),
              SizedBox(
                height: 20.0,
              ),
              CustomMaterialButton(
                child: Text(
                  'Go Anonymously',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: _signInAnonymously,
                circularBorderRadius: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}