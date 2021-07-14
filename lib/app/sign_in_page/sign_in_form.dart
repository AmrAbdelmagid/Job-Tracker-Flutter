import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/sign_in_page/string_validator.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';
import 'package:job_tracker_flutter/services/auth.dart';

enum EmailSignInFormType {
  SignIn,
  SignUp,
}

class SignInForm extends StatefulWidget with EmailAndPasswordValidators {
  SignInForm({required this.auth});
  final AuthBase auth;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formType = EmailSignInFormType.SignIn;
  var _passwordFocusNode = FocusNode();
  bool _isSubmitted = false;

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
    log('message');
    setState(() {
      _isSubmitted = true;
    });
    try {
      await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.SignIn) {
        await widget.auth
            .signInWithEmailAndPassword(email: _email, password: _password);
      } else {
        await widget.auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
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
          textHint: 'Email',
          errorText: _isSubmitted && !widget.emailValidator.isValid(_email)
              ? widget.emailTextError
              : null,
          borderRadius: 32.0,
          onChanged: (_) {
            setState(() {});
          },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
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
        CustomMaterialButton(
          child: Text(
              _formType == EmailSignInFormType.SignIn ? 'Sign In' : 'Sign Up'),
          onPressed: (widget.emailValidator.isValid(_email) &&
                  widget.passwordValidator.isValid(_password))
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
