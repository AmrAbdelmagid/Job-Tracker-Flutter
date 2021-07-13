import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';
import 'package:job_tracker_flutter/helpers/responsive_helper.dart';
import 'package:job_tracker_flutter/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);

  // GlobalKey _paddingKey = GlobalKey();
  // _getPaddingSize() {
  //   final RenderBox renderBox =
  //       _paddingKey.currentContext!.findRenderObject() as RenderBox;
  //   final size = renderBox.size;
  //   log('here');
  //   log(size.toString());
  // }

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
    AppBar appBar = AppBar(
      backwardsCompatibility: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Job Tracker',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0.0,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: getInnerHeight(context, appBar),
          width: getDeviceWidth(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: (constraints.maxHeight * .036) * 2,
                  ),
                  CustomOutlinedTextField(
                    controller: TextEditingController(),
                    height: constraints.maxHeight * .09,
                    textHint: 'Email',
                    borderRadius: 32.0,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .036,
                  ),
                  CustomOutlinedTextField(
                    controller: TextEditingController(),
                    height: constraints.maxHeight * .09,
                    borderRadius: 32.0,
                    textHint: 'Password',
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .036,
                  ),
                  CustomMaterialButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                    circularBorderRadius: 32.0,
                    height: constraints.maxHeight * .09,
                  ),
                  SizedBox(
                    height: (constraints.maxHeight * .036) * 0.5,
                  ),
                  TextButton(
                    onPressed: () {
                      log(constraints.maxWidth.toString());
                      log(constraints.maxHeight.toString());
                      log((constraints.maxHeight * .09).toString());
                    },
                    child: Text('Don\'t have an account? Sign Up'),
                  ),
                  SizedBox(
                    height: (constraints.maxHeight * .036) * 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 1,
                        width: (constraints.maxWidth * .11) * 3,
                        color: Colors.grey,
                      ),
                      Text('Or Connect With'),
                      Container(
                        height: 1,
                        width: (constraints.maxWidth * .11) * 3,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .036,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomMaterialButton(
                        color: Color(0xff4367B2),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image(
                                  image:
                                      AssetImage('images/facebook-logo.png')),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 100) * 3,
                            ),
                            Text(
                              'Facebook',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 100) * 3,
                            ),
                          ],
                        ),
                        onPressed: () {},
                        circularBorderRadius: 32.0,
                        height: constraints.maxHeight * .09,
                        width: (constraints.maxWidth * .11) * 4,
                      ),
                      CustomMaterialButton(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image(
                                  image: AssetImage('images/google-logo.png')),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 100) * 3,
                            ),
                            Text(
                              'Google',
                              style: TextStyle(color: Color(0xffDC4234)),
                            ),
                            SizedBox(
                              width: (constraints.maxWidth / 100) * 6,
                            ),
                          ],
                        ),
                        onPressed: _signInWithGoogle,
                        circularBorderRadius: 32.0,
                        height: constraints.maxHeight * .09,
                        width: (constraints.maxWidth * .11) * 4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .036,
                  ),
                  Align(alignment: Alignment.center, child: Text('Or')),
                  SizedBox(
                    height: constraints.maxHeight * .036,
                  ),
                  CustomMaterialButton(
                    child: Text(
                      'Go Anonymously',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _signInAnonymously,
                    circularBorderRadius: 32.0,
                    height: constraints.maxHeight * .09,
                  ),
                  SizedBox(
                    height: (constraints.maxHeight * .036) * 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
