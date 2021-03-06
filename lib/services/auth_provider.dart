// Legacy implementation -- How to make an inherited widget.
// import 'package:flutter/material.dart';
// import 'package:job_tracker_flutter/services/auth.dart';

// class AuthProvider extends InheritedWidget {
//   AuthProvider({required this.auth, required this.child}) : super(child: child);
//   final AuthBase auth;
//   final Widget child;

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

//   static AuthBase of(BuildContext context) {
//     AuthProvider? provider =
//         context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//     return provider!.auth;
//   }
// }


// 1- implement updateShouldNotify
// 2- provide access to object (Auth in this case)
// 3- implement .of(context) method
// 4- add a child widget
// 5- use it in the widget tree

// BloCs (traditional definition)
// 1- BloCs only expose sinks and sources
// 2- BloCs have no UI Code
// 3- BloCs talk to the outside world via services