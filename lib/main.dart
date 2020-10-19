import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/pages/wrapper.dart';
import 'models/data_from_server.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await DataFromServerInit.pushScheduler();
  await DataFromServerInit.loadDB();
  // PushNotificationService _pns = PushNotificationService();
  // await _pns.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
