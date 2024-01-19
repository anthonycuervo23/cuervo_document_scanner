// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:captain_score/shared/common_widgets/app_constants.dart';
import 'package:captain_score/shared/models/app_language_model.dart';
import 'package:captain_score/shared/models/general_setting_model.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/captain_score_app.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:captain_score/shared/utils/new_notification_service.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/languages.dart';
import 'package:captain_score/firebase_options.dart';
import 'package:captain_score/http_overrides.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'di/get_it.dart' as get_it;

FirebaseMessaging messaging = FirebaseMessaging.instance;
final StreamController<int> controller = StreamController<int>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  try {
    await Firebase.initializeApp();
    await PushNotificationService().enableIOSNotifications();
    await PushNotificationService().registerNotificationListeners();
    if (message?.data.containsKey("af-uinstall-tracking") ?? false) {
      return;
    } else {
      PushNotificationService().sendLocalNotification(message: message);
    }
  } on Exception {}
}

@pragma('vm:entry-point')
void computeIsolate(Message message) {
  final StreamController controller = StreamController.broadcast();

  Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      controller.add([message.oldDuration + timer.tick, message.message]);
    },
  );

  controller.stream.listen((event) {
    message.sendPort.send(event);
  });
}

void main() async {
  // if (kDebugMode) {
  // } else if (kDebugMode) {}
  // runZonedGuarded<Future<void>>(() async {
  //   await mainFunction();
  // }, (error, stack) {
  //   print(error);
  //   FirebaseCrashlytics.instance.recordError(error, stack);
  // });
  await mainFunction();
}

Future<void> mainFunction() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  appConstants = AppConstants();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  prefs = await SharedPreferences.getInstance();
  totalNotificationCounts = await AppFunctions().getNotificationCount();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isIOS) {
    DartPingIOS.register();
    await AppFunctions().initTrackingDialog();
  }

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  Lottie.cache.maximumSize = 10;

  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //  await FirebaseMessaging.instance.getToken();

  MobileAds.instance.initialize();
  // await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  firebaseAnalytics = FirebaseAnalytics.instance;
  firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  await firebaseAnalytics.setDefaultEventParameters(AppFunctions().getDefaultParams());

  await path_provider.getApplicationDocumentsDirectory().then((dir) async {
    Hive.init(dir.path);
    Hive.registerAdapter<AppLanguageListModel>(AppLanguageListModelAdapter());
    Hive.registerAdapter<GeneralSettingEntity>(GeneralSettingEntityAdapter());

    dmtBox = await Hive.openBox(HiveBoxConstants.DMT_BOX);

    appLanBox = await Hive.openBox(HiveBoxConstants.APP_LAN_BOX);
    userLanBox = await Hive.openBox(HiveBoxConstants.USER_LAN_BOX);
    currentLanBox = await Hive.openBox(HiveBoxConstants.CURRENT_LANG_BOX);
    userDataBox = await Hive.openBox(HiveBoxConstants.USER_DATA_BOX);
    generalSettingBox = await Hive.openBox(HiveBoxConstants.GENERAL_SETTING_BOX);
    appActivityAnaltics = await Hive.openBox(HiveBoxConstants.APP_ACTIVITY_ANALYTICS);

    isFirst = await dmtBox.get(HiveConstants.IS_FIRST_LOAD, defaultValue: true);
    launchNo = await dmtBox.get(HiveConstants.LAUNCH_NUMBER, defaultValue: 0);
    currentLangCode = await currentLanBox.get(HiveConstants.PREFERRED_LANGUAGE, defaultValue: 'en');
    isStory = await dmtBox.get(HiveConstants.IS_STORY, defaultValue: false);
    isTourCompleted = await dmtBox.get(HiveConstants.IS_TOUR_COMPLETED, defaultValue: true);
    isBusinessCreated = await dmtBox.get(HiveConstants.IS_BUSINESS_CREATED, defaultValue: false);

    deviceData = Map<String, String>.from(await dmtBox.get(HiveConstants.DEVICE_DATA, defaultValue: {}));
    isBusinessUpdated = await dmtBox.get(HiveConstants.IS_BUSINESS_UPDATED, defaultValue: false);
    isCRMFromHive = await dmtBox.get(HiveConstants.IS_CRM_USER, defaultValue: false);

    appStartTime = await dmtBox.get(HiveConstants.APP_START_TIME, defaultValue: null);
    appCloseTime = await dmtBox.get(HiveConstants.APP_CLOSE_TIME, defaultValue: null);
    userAppActivity = Map<String, int>.from(await dmtBox.get(HiveConstants.USER_APP_ACTIVITY, defaultValue: {}));
    imageImpression = Map<String, int>.from(await dmtBox.get(HiveConstants.IMAGE_IMPRESSION, defaultValue: {}));
    imageScrollCount = List<int>.from(await dmtBox.get(HiveConstants.IMAGE_SCROLL_COUNT, defaultValue: []));
    isAdsOnline = await dmtBox.get(HiveConstants.IS_ADS_ONLINE, defaultValue: false);

    totalDownloadPost = await dmtBox.get(HiveConstants.TOTAL_DOWNLOAD_POST, defaultValue: 0);
    appOpenCount = await dmtBox.get(HiveConstants.APP_OPEN_COUNT, defaultValue: 0);

    dmtBox.put(HiveConstants.LAUNCH_NUMBER, launchNo + 1);
    deviceData = await AppFunctions().initPlatformState();
    await saveAssetsLangToDevice();

    if (isFirst!) {
      dmtBox.put(HiveConstants.SHARE_NUMBER, 0);
      dmtBox.put(HiveConstants.NAV_NUMBER, 0);
      dmtBox.put(HiveConstants.IS_FIRST_LOAD, false);
      languages = [
        AppLanguageListModel(id: 1, name: 'English', shortCode: 'en', isDefault: 1),
      ];
      appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
      currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, 'en');
      await firebaseAnalytics.logEvent(name: 'custom_first_open');
    } else {
      languages = List<AppLanguageListModel>.from(
        await appLanBox.get(
          HiveConstants.APP_LANGUAGE_LIST,
          defaultValue: <AppLanguageListModel>[
            AppLanguageListModel(id: 1, name: 'English', shortCode: 'en', isDefault: 1),
          ],
        ),
      );

      var filterList = languages.where((element) => (element.isDefault == 1)).toList();
      String currentLang = filterList.isNotEmpty ? filterList[0].shortCode : 'en';
      currentLangCode = currentLang;
      currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, currentLang);
    }

    navigationCount = await dmtBox.get(HiveConstants.NAV_NUMBER, defaultValue: 0);
    unawaited(get_it.init());

    HttpOverrides.global = MyHttpOverrides();

    isPinSet = await dmtBox.get(HiveConstants.IS_PIN_SET, defaultValue: false);

    Catcher2Options debugOptions = Catcher2Options(
      SilentReportMode(),
      [
        ConsoleHandler(
          enableStackTrace: true,
          enableApplicationParameters: false,
          enableCustomParameters: false,
          enableDeviceParameters: false,
          handleWhenRejected: false,
        )
      ],
      customParameters: {
        'datetime': DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now()).toString(),
        "error_type": "app",
        "issue_type": "App Handled Exception",
        "model_name": deviceData?["device_model"] ?? "",
        "screen_name": currentRouteName,
        "api_endpoint": "",
      },
    );

    Catcher2Options releaseOptions = Catcher2Options(
      SilentReportMode(),
      [
        HttpHandler(
          HttpRequestType.post,
          Uri.parse("https://dmt.captainscore.in/api/v7/error-log/save"),
          headers: {'Content-Type': 'application/json', "Accept": 'application/json'},
          enableCustomParameters: true,
          enableApplicationParameters: true,
          enableDeviceParameters: true,
          enableStackTrace: true,
          requestTimeout: const Duration(seconds: 3),
          responseTimeout: const Duration(seconds: 3),
        ),
        EmailAutoHandler(
          "smtp.gmail.com",
          587,
          "dmterror2023@gmail.com",
          "DMTError",
          "tbezkkjkyprjpgdm",
          ["dmterror2023@gmail.com"],
          emailTitle: "Auto Generated Error Mail",
          enableApplicationParameters: true,
          enableCustomParameters: true,
          enableDeviceParameters: true,
          enableStackTrace: true,
        ),
        SlackHandler(
          "https://hooks.slack.com/services/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",
          "#dmt-poster-maker-error",
          username: "Parth Virani",
          iconEmoji: ":thinking_face:",
          enableDeviceParameters: true,
          enableApplicationParameters: true,
          enableCustomParameters: true,
          enableStackTrace: true,
          printLogs: true,
        ),
      ],
      customParameters: {
        'datetime': DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now()).toString(),
        "error_type": "app",
        "issue_type": "App Handled Exception",
        "model_name": deviceData?["device_model"] ?? "",
        "screen_name": currentRouteName,
        "api_endpoint": "",
      },
    );

    Catcher2(
      rootWidget: const CaptainScoreApp(),
      ensureInitialized: true,
      enableLogger: true,
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
    );
    FlutterNativeSplash.remove();
  });
}

Future<void> saveAssetsLangToDevice() async {
  globalDownloadLocation =
      '${(await path_provider.getApplicationDocumentsDirectory()).absolute.path}${Platform.pathSeparator}OceanMTech';

  languageLocalPath =
      '${(await path_provider.getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}languages';

  ByteData byteData = await rootBundle.load("assets/languages/en.json");

  if (!await Directory(languageLocalPath).exists()) {
    await Directory(languageLocalPath).create();
  }
  if (!(await File('$languageLocalPath/en.json').exists())) {
    File file = await File('$languageLocalPath/en.json').create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}

Future createVideoIsolate({required int page, required BuildContext buildContext}) async {
  // Set loading to true
  // BlocProvider.of<ReelsHomeCubit>(buildContext, listen: false).setLoading();
  // ReceivePort mainReceivePort = ReceivePort();
  // Isolate.spawn<SendPort>(getVideosTask, mainReceivePort.sendPort);
  // SendPort isolateSendPort = await mainReceivePort.first;
  // ReceivePort isolateResponseReceivePort = ReceivePort();
  // isolateSendPort.send([page, buildContext, isolateResponseReceivePort.sendPort]);
  // final isolateResponse = await isolateResponseReceivePort.first;
  // final urls = isolateResponse;
  // Update new urls
  // BlocProvider.of<ReelsHomeCubit>(buildContext, listen: false).updateUrls(reelsDetail: urls);
}

void getVideosTask(SendPort mySendPort) async {
  ReceivePort isolateReceivePort = ReceivePort();

  mySendPort.send(isolateReceivePort.sendPort);

  await for (var message in isolateReceivePort) {
    if (message is List) {
      // final int index = message[0];
      // final BuildContext context = message[1];
      // final SendPort isolateResponseSendPort = message[2];
      // final List<ReelsDetail> urls =
      //     await BlocProvider.of<ReelsHomeCubit>(context, listen: false).getReelsURL(pageNo: index);
      // isolateResponseSendPort.send(urls);
    }
  }
}
