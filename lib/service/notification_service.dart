

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static const key = "AAAA4o3jilY:APA91bH5M7HA7vnbKRB8iechFZxtlgKd3xTjZlW1_opvEXD7Iti3okDsXSifkDoiui5hurPzztFqIEL6UvsIP6iItiPEG1En1KBm3QMPPunG7emDctOPChHOfLw5wH5DC_HOg0IywD_E";
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  void _initLocalNotification(){
   const androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
   const iOSSettings = DarwinInitializationSettings(
     requestAlertPermission: true,
     requestBadgePermission: true,
     requestCriticalPermission: true,
     requestProvisionalPermission: true,
     requestSoundPermission: true,
   );
   const initializationSettings = InitializationSettings(
     android: androidSettings,
     iOS: iOSSettings,
   );
   flutterLocalNotificationPlugin.initialize(
     initializationSettings,
     onDidReceiveNotificationResponse: (response){
       print(response.payload.toString());
     }
   );
  }

  Future<void> _showLocalNotification(RemoteMessage message)async{
    final StyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      "com.example.chats_app",
      "mychannelid",
      importance: Importance.max,
      styleInformation: StyleInformation,
      priority: Priority.max,
    );

    final iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );
    await flutterLocalNotificationPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      payload: message.data['body'],
    );
  }

  Future<void> requestPermission()async{
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User granted provisional");
    }
  }
}