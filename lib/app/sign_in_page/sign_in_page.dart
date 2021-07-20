import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_tracker_flutter/app/blocs/sign_in_manager.dart';
import 'package:job_tracker_flutter/app/sign_in_page/sign_in_form_change_notifier.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;

  const SignInPage({Key? key, required this.manager, required this.isLoading})
      : super(key: key);
  // Top Tip
  // Use a static create(context) method when creating widgets that require
  // a bloc / manager as:
  // 1- more maintainable code
  // 2- better separation of concerns
  // 3- better APIs
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          // dispose: (_, bloc) => bloc.dispose(),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  // These methods are still here as they are responsible for showing alert
  // dialogs errors which is a part of the UI layer (requires the context)

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
        context: context, title: 'Sign In Error', exception: exception);
  }

  Future<void> _signInAnonymously(context) async {
    try {
      await manager.signInAnonymously();
    } on Exception catch (e, s) {
      // log(e.toString());
      // log(s.toString());
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e, s) {
      // log(e.toString());
      // log(s.toString());
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // backwardsCompatibility: false,
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // centerTitle: true,
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          //   statusBarIconBrightness: Brightness.dark,
          // ),
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
                SignInFormChangeNotifier.create(context),
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
                  onPressed:
                      (isLoading) ? null : () => _signInWithGoogle(context),
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
                  onPressed:
                      (isLoading) ? null : () => _signInAnonymously(context),
                  circularBorderRadius: 32.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
