import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotifManager {
  PushNotifManager._();
  // final GlobalKey<NavigatorState> navigatorKey =
  //     new GlobalKey<NavigatorState>(); 

  factory PushNotifManager() => _instance;
  static final PushNotifManager _instance = PushNotifManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  // String token;

  Future init(BuildContext context) async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage $message");
          if (message.containsKey('data')) {
           var data = message['data'];
            if (data.containsKey('screen')) {
              Navigator.of(context).pushNamed(data['screen']);
            }
          }
        },
        onLaunch: (message) async {
          print("onLaunch $message");
          if (message.containsKey('data')) {
            var data = message['data'];
            if (data.containsKey('screen')) {
              Navigator.of(context).pushNamed(data['screen']);
            }
          }
        },
        onResume: (message) async {
          print("onResum $message");
          if (message.containsKey('data')) {
            var data = message['data'];
            if (data.containsKey('screen')) {
              print(data['screen']);
              print(context);
              Navigator.of(context).pushNamed(data['screen']);
            }
          }
        }
      );

      // For testing purposes print the Firebase Messaging token
      _firebaseMessaging.getToken().then((token) {
        print("FirebaseMessaging token: $token");
      });

      _initialized = true;
    }
  }
}
