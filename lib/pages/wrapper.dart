import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_ex1/pages/authenticate.dart';
import 'package:state_management_ex1/pages/home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // access user data via user stream
    // return Home or Authenticate widget
    if (user?.displayName == null) {
      return Authenticate();
    } else {
      return HomePageCalendar();
    }
  }
}
