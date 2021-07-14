import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_tracker_flutter/app/landing/landing.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:job_tracker_flutter/services/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Job Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff414042),
          accentColor: Color(0xffDEB321),
          appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            elevation: 0.0,
          ),
        ),
        home: LandingPage(),
      ),
    );
  }
}
