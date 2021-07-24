// Legacy implementation
//import 'dart:developer';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:flutter/material.dart';
// import 'package:job_tracker_flutter/app/blocs/email_sign_in_bloc.dart';
// import 'package:job_tracker_flutter/app/models/email_sign_in_model.dart';
// import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
// import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';
// import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
// import 'package:job_tracker_flutter/services/auth.dart';
// import 'package:provider/provider.dart';

// class SignInFormBlocBased extends StatefulWidget {
//   SignInFormBlocBased({required this.bloc});
//   final EmailSignInBloc bloc;

//   static Widget create(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context, listen: false);
//     return Provider<EmailSignInBloc>(
//       create: (_) => EmailSignInBloc(auth: auth),
//       dispose: (_, bloc) => bloc.dispose(),
//       child: Consumer<EmailSignInBloc>(
//         builder: (_, bloc, __) => SignInFormBlocBased(
//           bloc: bloc,
//         ),
//       ),
//     );
//   }

//   @override
//   _SignInFormBlocBasedState createState() => _SignInFormBlocBasedState();
// }

// class _SignInFormBlocBasedState extends State<SignInFormBlocBased> {
//   @override
//   void initState() {
//     super.initState();
//     keyboardVisibilityController.onChange.listen((bool visible) {
//       if (!visible) {
//         FocusManager.instance.primaryFocus?.unfocus();
//       }
//       log('Keyboard visibility update. Is visible: $visible');
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//   }

//   var keyboardVisibilityController = KeyboardVisibilityController();
//   var _emailController = TextEditingController();
//   var _passwordController = TextEditingController();
//   var _emailFocusNode = FocusNode();
//   var _passwordFocusNode = FocusNode();

//   String get _email => _emailController.text;
//   String get _password => _passwordController.text;

//   _toggleFormType() {
//     widget.bloc.toggleFormType();
//     _emailController.clear();
//     _passwordController.clear();
//   }

//   Future<void> _submit() async {
//     try {
//       await widget.bloc.submit();
//     } on Exception catch (e, s) {
//       // log(e.toString());
//       // log(s.toString());
//       showExceptionAlertDialog(
//         context: context,
//         title: 'Sign In Error',
//         exception: e,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<EmailSignInModel>(
//         stream: widget.bloc.modelStream,
//         initialData: EmailSignInModel(),
//         builder: (context, snapshot) {
//           final EmailSignInModel? model = snapshot.data;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               CustomOutlinedTextField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 textInputAction: TextInputAction.next,
//                 enabled: !model!.isLoading,
//                 focusNode: _emailFocusNode,
//                 textHint: 'Email',
//                 errorText: model.emailErrorText,
//                 borderRadius: 32.0,
//                 onChanged: widget.bloc.updateEmail,
//                 onEditingComplete: () {
//                   final newFocus = model.emailValidator.isValid(_email)
//                       ? _passwordFocusNode
//                       : _emailFocusNode;
//                   FocusScope.of(context).requestFocus(newFocus);
//                 },
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               CustomOutlinedTextField(
//                 controller: _passwordController,
//                 textInputAction: TextInputAction.done,
//                 focusNode: _passwordFocusNode,
//                 obscureText: true,
//                 borderRadius: 32.0,
//                 enabled: !model.isLoading,
//                 textHint: 'Password',
//                 errorText: model.passwordErrorText,
//                 onChanged: widget.bloc.updatePassword,
//                 onEditingComplete: _submit,
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               model.isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : CustomMaterialButton(
//                       child: Text(model.signButtonText),
//                       onPressed: model.canSubmit ? _submit : null,
//                       circularBorderRadius: 32.0,
//                     ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 children: [
//                   Spacer(),
//                   TextButton(
//                     onPressed: model.isLoading ? null : _toggleFormType,
//                     child: Text(model.toggleButtonText),
//                     style: TextButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   Spacer(),
//                 ],
//               ),
//             ],
//           );
//         });
//   }
// }
