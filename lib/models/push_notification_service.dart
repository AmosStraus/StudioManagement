import 'dart:io';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future initialize() async {
    if (Platform.isIOS) {
      await _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMesage $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume $message");
    });
  }
}
