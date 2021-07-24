// Legacy implementation 
//import 'dart:async';
// import 'package:job_tracker_flutter/app/models/email_sign_in_model.dart';
// import 'package:job_tracker_flutter/services/auth.dart';

// class EmailSignInBloc {
//   EmailSignInBloc({required this.auth});
//   final AuthBase auth;
//   StreamController<EmailSignInModel> _modelController =
//       StreamController<EmailSignInModel>();

//   Stream<EmailSignInModel> get modelStream => _modelController.stream;
//   EmailSignInModel _model = EmailSignInModel();

//   void dispose() {
//     _modelController.close();
//   }

//   void updateWith({
//     String? email,
//     String? password,
//     EmailSignInFormType? formType,
//     bool? isLoading,
//     bool? isSubmitted,
//   }) {
//     // update model
//     _model = _model.copyWith(
//       email: email,
//       password: password,
//       formType: formType,
//       isLoading: isLoading,
//       isSubmitted: isSubmitted,
//     );
//     // add model to _modelController
//     _modelController.add(_model);
//   }

//   updateEmail(String email) => updateWith(email: email);

//   updatePassword(String password) => updateWith(password: password);

//   toggleFormType() {
//     final formType = _model.formType == EmailSignInFormType.SignIn
//         ? EmailSignInFormType.SignUp
//         : EmailSignInFormType.SignIn;
//     updateWith(
//       email: '',
//       password: '',
//       isSubmitted: false,
//       formType: formType,
//     );
//   }

//   Future<void> submit() async {
//     updateWith(isLoading: true, isSubmitted: true);
//     try {
//       if (_model.formType == EmailSignInFormType.SignIn) {
//         await auth.signInWithEmailAndPassword(
//             email: _model.email, password: _model.password);
//       } else {
//         await auth.createUserWithEmailAndPassword(
//             email: _model.email, password: _model.password);
//       }
//       updateWith(isLoading: false);
//     } catch (e, s) {
//       // log(e.toString());
//       // log(s.toString());
//       updateWith(isLoading: false);
//       rethrow;
//     }
//   }
// }
