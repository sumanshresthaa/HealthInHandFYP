// import 'package:flutter/material.dart';
// import 'package:hatai_ma_swastha/UI/Login/login.dart';
// import 'package:hatai_ma_swastha/UI/Signup/signup.dart';
//
// //Switch between screens. For this project this is not actually required but can be used in future projects
// class Authenticate extends StatefulWidget {
//   const Authenticate({Key? key}) : super(key: key);
//
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }
//
// class _AuthenticateState extends State<Authenticate> {
//   bool showSignIn = true;
//
//   void toggleView() {
//     setState(() {
//       showSignIn = !showSignIn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return showSignIn
//         ? LoginPage(
//             toggle: toggleView,
//           )
//         : SignupPage(toggle: toggleView);
//   }
// }
