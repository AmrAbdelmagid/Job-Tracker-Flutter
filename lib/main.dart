import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/landing/landing.dart';
import 'package:job_tracker_flutter/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1C2C60),
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
