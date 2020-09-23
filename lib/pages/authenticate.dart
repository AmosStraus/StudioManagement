import 'package:flutter/material.dart';
import 'package:state_management_ex1/pages/register_page.dart';
import 'login_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn; // flip it
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleFunc: toggleView);
    } else {
      return Register(toggleFunc: toggleView);
    }
  }
}
