import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/sign_in_page/string_validator.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';
import 'package:job_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth_provider.dart';

enum EmailSignInFormType {
  SignIn,
  SignUp,
}

class SignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      log('Keyboard visibility update. Is visible: $visible');
    });
  }

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formType = EmailSignInFormType.SignIn;
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  bool _isSubmitted = false;
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  _toggleFormType() {
    setState(() {
      _isSubmitted = false;
      _formType == EmailSignInFormType.SignIn
          ? _formType = EmailSignInFormType.SignUp
          : _formType = EmailSignInFormType.SignIn;
    });

    _emailController.clear();
    _passwordController.clear();
  }
  // bool isButtonDisabled = _email.isNotEmpty && _password.isNotEmpty;

  void _submit() async {
    setState(() {
      _isSubmitted = true;
      _isLoading = true;
    });
    try {
      final auth = AuthProvider.of(context);
      if (_formType == EmailSignInFormType.SignIn) {
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        await auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      showAlertDialog(
          context: context, error: e.toString(), title: 'Authentication Error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomOutlinedTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          enabled: !_isLoading,
          focusNode: _emailFocusNode,
          textHint: 'Email',
          errorText: _isSubmitted && !widget.emailValidator.isValid(_email)
              ? widget.emailTextError
              : null,
          borderRadius: 32.0,
          onChanged: (_) {
            setState(() {});
          },
          onEditingComplete: () {
            final newFocus = widget.emailValidator.isValid(_email)
                ? _passwordFocusNode
                : _emailFocusNode;
            FocusScope.of(context).requestFocus(newFocus);
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomOutlinedTextField(
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          focusNode: _passwordFocusNode,
          obscureText: true,
          borderRadius: 32.0,
          enabled: !_isLoading,
          textHint: 'Password',
          errorText:
              _isSubmitted && !widget.passwordValidator.isValid(_password)
                  ? widget.passwordTextError
                  : null,
          onChanged: (_) {
            setState(() {});
          },
          onEditingComplete: _submit,
        ),
        SizedBox(
          height: 20.0,
        ),
        _isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomMaterialButton(
                child: Text(_formType == EmailSignInFormType.SignIn
                    ? 'Sign In'
                    : 'Sign Up'),
                onPressed: (widget.emailValidator.isValid(_email) &&
                        widget.passwordValidator.isValid(_password) &&
                        !_isLoading)
                    ? _submit
                    : null,
                circularBorderRadius: 32.0,
              ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Spacer(),
            TextButton(
              onPressed: _toggleFormType,
              child: Text(_formType == EmailSignInFormType.SignIn
                  ? 'Don\'t have an account? Sign Up'
                  : 'Have an account? Sign In'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
