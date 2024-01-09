// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:async';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/notification/selected_notification/selected_notification_cubit.dart';
import 'package:bakery_shop_flutter/main.dart';
import 'package:bakery_shop_flutter/utils/analytics_service.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
var initSetttings;

SelectedNotificationCubit notificationCubit = getItInstance<SelectedNotificationCubit>();

bool isOpenFromNotification = false;
RemoteMessage? remoteMessage;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

initialMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  // RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if ((notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) &&
      notificationAppLaunchDetails?.notificationResponse?.payload != null) {
    isOpenFromNotification = true;

    remoteMessage = RemoteMessage(
      data: Map<String, dynamic>.from(jsonDecode(notificationAppLaunchDetails!.notificationResponse!.payload!)),
    );
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) => PushNotificationService().handleDirectNotification(message: event),
  );
}

class PushNotificationService {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  Future<void> setupInteractedMessage() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      // print('User granted provisional permission');
    } else {
      // print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey("af-uinstall-tracking")) {
        return;
      } else {
        handleDirectNotification(message: message);
      }
    });

    // print('Handle Message in foreground!');
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message?.data.containsKey("af-uinstall-tracking") ?? false) {
        return;
      } else {
        sendLocalNotification(message: message);
      }
    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) => {
        if (payload != null)
          {
            notificationCubit.updateSelectedMessage(
                payloadModel: NotificationPayloadModel.fromJson(jsonDecode(payload)))
          }
      },
    );
    initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        // Get.toNamed(NOTIFICATIOINS_ROUTE);

        if (payload.payload != null) {
          try {
            NotificationPayloadModel payloadModel = NotificationPayloadModel.fromJson(jsonDecode(payload.payload!));
            notificationCubit.updateSelectedMessage(payloadModel: payloadModel);
          } on Exception {
            notificationCubit.updateSelectedMessage(payloadModel: null);
          }
        }
      },
    );
    // onMessage is called when the app is in foreground and a notification is received
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  Future<void> handleDirectNotification({required RemoteMessage message}) async {
    AnalyticsService().appOpenFromNotification();
    try {
      NotificationPayloadModel payloadModel = NotificationPayloadModel.fromJson(message.data);
      notificationCubit.updateSelectedMessage(payloadModel: payloadModel);
    } on Exception {
      notificationCubit.updateSelectedMessage(payloadModel: null);
    }
  }

  Future<void> sendLocalNotification({RemoteMessage? message}) async {
    if (message?.data.containsKey("af-uinstall-tracking") ?? false) {
      return;
    }

    RemoteNotification? notification = message?.notification;
    AndroidNotification? android = message?.notification?.android;
    AppleNotification? ios = message?.notification?.apple;

    Future<String> _base64encodedImage(String url) async {
      final http.Response response = await http.get(Uri.parse(url));
      final String base64Data = base64Encode(response.bodyBytes);
      return base64Data;
    }

    AppFunctions().incrementNotificationCount();

    commonPrint("Datata : ${message?.data ?? ''}");
    commonPrint("notificationDatata : $notification");

    if (notification != null && android != null) {
      Map<String, dynamic>? data = message?.data;

      //  if (message.containsKey('data')) {
      //   // Handle data message
      //   final dynamic data = message['data'];
      //   print("_backgroundMessageHandler data: ${data}");
      // }

      // if (message.containsKey('notification')) {
      //   // Handle notification message
      //   final dynamic notification = message['notification'];
      //   print("_backgroundMessageHandler notification: ${notification}");
      // }

      String? imageUrl = data?["image"] ?? android.imageUrl;
      String title = data?["title"] ?? notification.title;
      String body = data?["body"] ?? notification.body;

      BigPictureStyleInformation? bigPictureStyleInformation;
      if (android.imageUrl != null) {
        final String bigPicture = await _base64encodedImage(imageUrl!);

        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          summaryText: title,
          contentTitle: body,
          htmlFormatContentTitle: true,
          htmlFormatSummaryText: true,
          htmlFormatContent: true,
          htmlFormatTitle: true,
        );
      }

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        title
            .toString()
            .replaceAll("<p>", "")
            .replaceAll("</p>", "")
            .replaceAll("<br />", "")
            .replaceAll("&nbsp;", " ")
            .replaceAll("&amp;", "&")
            .replaceAll("</p>", ""),
        body
            .toString()
            .replaceAll("<p>", "")
            .replaceAll("</p>", "")
            .replaceAll("<br />", "")
            .replaceAll("&nbsp;", " ")
            .replaceAll("&amp;", "&")
            .replaceAll("</p>", ""),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // icon: android.smallIcon,
            playSound: true,
            styleInformation: bigPictureStyleInformation,
          ),
        ),
        payload: json.encode(message?.data),
      );
    } else if (notification != null && ios != null) {
      Map<String, dynamic>? data = message?.data;

      String title = data?["title"] ?? notification.title;
      String body = data?["body"] ?? notification.body;

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        title,
        body,
        const NotificationDetails(),
        payload: json.encode(message?.data),
      );
    } else if ((message?.data.isNotEmpty ?? false) && notification == null && android == null) {
      Map<String, dynamic>? data = message?.data;

      BigPictureStyleInformation? bigPictureStyleInformation;
      if (data?["image"] != null) {
        final String bigPicture = await _base64encodedImage(data?["image"]);

        bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(bigPicture),
          summaryText: data?["title"] ?? '',
          contentTitle: data?["body"] ?? '',
          htmlFormatContentTitle: true,
          htmlFormatSummaryText: true,
          htmlFormatContent: true,
          htmlFormatTitle: true,
        );
      }
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        data?["title"] ?? '',
        data?["body"] ?? '',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // icon: android.smallIcon,
            playSound: true,
            styleInformation: bigPictureStyleInformation,
          ),
        ),
        payload: json.encode(message?.data),
      );
    }
  }
}

class NotificationPayloadModel {
  String? image;
  String? title;
  String? body;
  String? type;
  String? sound;
  String? icon;
  String? enquiryId;
  String? fromUserId;
  int? eventId;
  int? offerId;
  int? homeCategoryId;
  String? offerType;
  int? offerValue;
  int? planId;

  NotificationPayloadModel({
    this.image,
    this.eventId,
    this.title,
    this.body,
    this.type,
    this.sound,
    this.icon,
    this.enquiryId,
    this.fromUserId,
    this.homeCategoryId,
    this.offerId,
    this.offerType,
    this.offerValue,
    this.planId,
  });

  static NotificationPayloadModel fromJson(Map<String, dynamic> data) {
    return NotificationPayloadModel(
      image: data['image'],
      title: data['title'],
      body: data['body'],
      type: data['type'],
      sound: data['sound'],
      icon: data['icon'],
      enquiryId: data['enquiry_id']?.toString(),
      fromUserId: data['from_user_id']?.toString(),
      eventId: int.tryParse(data['event_id'].toString()),
      offerId: int.tryParse(data['offer_id'].toString()),
      homeCategoryId: int.tryParse(data['home_category_id'].toString()),
      offerType: data['offer_type']?.toString(),
      offerValue: int.tryParse(data['offer_value'].toString()),
      planId: int.tryParse(data['plan_id'].toString()),
    );
  }
}
