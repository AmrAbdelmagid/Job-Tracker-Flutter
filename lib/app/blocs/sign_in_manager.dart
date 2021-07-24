import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:job_tracker_flutter/app/sign_in_page/sign_in_page.dart';
import 'package:job_tracker_flutter/services/auth.dart';

// Renamed from SignInBloc as now it's not containing streams
class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  // final StreamController<bool> _isLoadingController = StreamController<bool>();

  // void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
  // Stream<bool> get isLoadingStream => _isLoadingController.stream;

  // void dispose() {
  //   _isLoadingController.close();
  // }

  Future<User?> _signIn(Future<User?> Function() signInMethod) async {
    try {
      isLoadingGlobal = true;
      isLoading.value = isLoadingGlobal;

      return await signInMethod();
    } catch (e) {
      isLoadingGlobal = false;
      isLoading.value = isLoadingGlobal;

      rethrow;
    }
  }

  Future<User?> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User?> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);
}
