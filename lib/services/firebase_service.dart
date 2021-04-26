import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

import '../dto/notification_dto.dart';
import '../main.dart';

class FirebaseService {
  var key;
  var navigatorKey;
  Function func;
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  factory FirebaseService({key, navigatorKey, func}) {
    _instance.key = key;
    _instance.navigatorKey = navigatorKey;
    _instance.func = func;
    return _instance;
  }
  bool _initialized = false;

  static final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future init(BuildContext context) async {
    if (!_initialized) {
      await Firebase.initializeApp();
      // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        Map<String, dynamic> msg = message.data;
        final notifObj = NotificationDTO.fromNewFirebase(message);
        showOverlayNotification((context) {
          return SlideDismissible(
            enable: true,
            key: ValueKey(key),
            child: Material(
              color: Colors.transparent,
              child: SafeArea(
                  bottom: false,
                  top: true,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[400],
                        )),
                    child: ListTile(
                      title: Text(notifObj.content),
                      onTap: () {
                        OverlaySupportEntry.of(context).dismiss();
                        _navigate(notifObj);
                      },
                      trailing: Builder(builder: (context) {
                        return IconButton(
                            onPressed: () {
                              OverlaySupportEntry.of(context).dismiss();
                            },
                            icon: Icon(Icons.close));
                      }),
                    ),
                  )),
            ),
          );
        }, duration: Duration.zero);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("onLaunch: $message");
        final notifObj = NotificationDTO.fromNewFirebase(message);
        _navigate(notifObj);
      });

      

      //     func();
      //     // setState(() {
      //     //   newNotification = true;
      //     // });
      //   },
      //   onLaunch: (Map<String, dynamic> message) async {
      //     print("onLaunch: $message");
      //     final notifObj = NotificationDTO.fromFireBase(message);
      //     _navigate(notifObj);
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     print("onResume: $message");
      //     final notifObj = NotificationDTO.fromFireBase(message);
      //     _navigate(notifObj);
      //   },
      // );

      _firebaseMessaging.getToken().then((String token) {
        assert(token != null);
        print("notif token: $token");
        notifToken = token;
      });
      _initialized = true;
    }
  }

  void _navigate(NotificationDTO notifObj) {
    if (notifObj.route != null) {
      navigatorKey.currentState.pushNamed(notifObj.route, arguments: notifObj.extraContent ?? null);
    }
  }
}
