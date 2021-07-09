import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AppBar appBar = AppBar(
    //       title: Text(
    //         'Job Tracker',
    //         style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //     elevation: 2.0,
    //   );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutlinedTextField(
              controller: TextEditingController(),
              textHint: 'Email',
              borderRadius: 32.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomOutlinedTextField(
              controller: TextEditingController(),
              borderRadius: 32.0,
              textHint: 'Password',
            ),
          ],
        ),
      ),
    );
  }
}
