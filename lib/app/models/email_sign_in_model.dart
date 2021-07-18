import 'package:job_tracker_flutter/app/sign_in_page/string_validator.dart';

enum EmailSignInFormType {
  SignIn,
  SignUp,
}

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.SignIn,
    this.isLoading = false,
    this.isSubmitted = false,
  });
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool isSubmitted;

  EmailSignInModel copyWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
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
