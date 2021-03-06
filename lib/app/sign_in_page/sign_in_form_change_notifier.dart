import 'dart:developer';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker_flutter/app/models/email_sign_in_change_model.dart';
import 'package:job_tracker_flutter/app/sign_in_page/sign_in_page.dart';
import 'package:job_tracker_flutter/common_widgets/custom_material_button.dart';
import 'package:job_tracker_flutter/common_widgets/custom_text_field.dart';
import 'package:job_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:job_tracker_flutter/services/auth.dart';
import 'package:provider/provider.dart';

class SignInFormChangeNotifier extends StatefulWidget {
  SignInFormChangeNotifier(
      {required this.model, required this.changeLoadingState});
  final EmailSignInChangeModel model;
  final Function(bool) changeLoadingState;

  static Widget create(
      BuildContext context, Function(bool) changeLoadingState) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => SignInFormChangeNotifier(
          model: model,
          changeLoadingState: changeLoadingState,
        ),
      ),
    );
  }

  @override
  _SignInFormChangeNotifierState createState() =>
      _SignInFormChangeNotifierState();
}

class _SignInFormChangeNotifierState extends State<SignInFormChangeNotifier> {
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  var keyboardVisibilityController = KeyboardVisibilityController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submit() async {
    widget.changeLoadingState(true);
    try {
      await model.submit();
      widget.changeLoadingState(false);
    } on Exception catch (e, s) {
      // log(e.toString());
      // log(s.toString());
      widget.changeLoadingState(false);
      showExceptionAlertDialog(
        context: context,
        title: 'Sign In Error',
        exception: e,
      );
    } finally {
      widget.changeLoadingState(false);
    }
  }

  EmailSignInChangeModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomOutlinedTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          enabled: !(model.isLoading || isLoadingGlobal),
          focusNode: _emailFocusNode,
          textHint: 'Email',
          errorText: model.emailErrorText,
          borderRadius: 32.0,
          onChanged: model.updateEmail,
          onEditingComplete: () {
            final newFocus = model.emailValidator.isValid(_email)
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
          enabled: !(model.isLoading || isLoadingGlobal),
          textHint: 'Password',
          errorText: model.passwordErrorText,
          onChanged: model.updatePassword,
          onEditingComplete: _submit,
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomMaterialButton(
          child: Text(model.signButtonText),
          onPressed: (model.canSubmit && !(model.isLoading || isLoadingGlobal))
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
              onPressed:
                  model.isLoading || isLoadingGlobal ? null : _toggleFormType,
              child: Text(model.toggleButtonText),
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
