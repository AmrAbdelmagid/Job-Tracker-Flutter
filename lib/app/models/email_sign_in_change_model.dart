import 'package:flutter/cupertino.dart';
import 'package:job_tracker_flutter/app/sign_in_page/string_validator.dart';
import 'package:job_tracker_flutter/services/auth.dart';

import 'email_sign_in_model.dart' show EmailSignInFormType;

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.SignIn,
    this.isLoading = false,
    this.isSubmitted = false,
  });
  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool isSubmitted;

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.isSubmitted = isSubmitted ?? this.isSubmitted;
    notifyListeners();
  }

  updateEmail(String email) => updateWith(email: email);

  updatePassword(String password) => updateWith(password: password);

  toggleFormType() {
    final formType = this.formType == EmailSignInFormType.SignIn
        ? EmailSignInFormType.SignUp
        : EmailSignInFormType.SignIn;
    updateWith(
      email: '',
      password: '',
      isSubmitted: false,
      formType: formType,
    );
  }

  Future<void> submit() async {
    updateWith(isLoading: true, isSubmitted: true);
    try {
      if (formType == EmailSignInFormType.SignIn) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      updateWith(isLoading: false);
    } catch (e, s) {
      // log(e.toString());
      // log(s.toString());
      updateWith(isLoading: false);
      rethrow;
    }
  }

  // Computed Values

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get signButtonText {
    return formType == EmailSignInFormType.SignIn ? 'Sign In' : 'Sign Up';
  }

  String get toggleButtonText {
    return formType == EmailSignInFormType.SignIn
        ? 'Don\'t have an account? Sign Up'
        : 'Have an account? Sign In';
  }

  String? get emailErrorText {
    return isSubmitted && !emailValidator.isValid(email)
        ? emailTextError
        : null;
  }

  String? get passwordErrorText {
    return isSubmitted && !emailValidator.isValid(password)
        ? passwordTextError
        : null;
  }
}
