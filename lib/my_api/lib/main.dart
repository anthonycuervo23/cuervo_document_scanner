// ignore_for_file: empty_catches

import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bakery_shop_admin_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_admin_flutter/common/constants/languages.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/firebase_options.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/http_overrides.dart';
import 'package:bakery_shop_admin_flutter/new_notification_service.dart';
import 'package:bakery_shop_admin_flutter/utils/app_constants.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:catcher/core/catcher.dart';
import 'package:catcher/handlers/console_handler.dart';
import 'package:catcher/handlers/http_handler.dart';
import 'package:catcher/mode/silent_report_mode.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:catcher/model/http_request_type.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart' as web_hive;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';
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

Future<void> main() async {
  await mainFunction();
}

Future<void> mainFunction() async {
  WidgetsFlutterBinding.ensureInitialized();
  appConstants = AppConstants();
  prefs = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if ((!kIsWeb && Platform.isIOS)) {
    // DartPingIOS.register();
    await AppFunctions().initTrackingDialog();
  }

  if ((!kIsWeb && Platform.isAndroid)) {
    await AndroidAlarmManager.initialize();
  }

  try {
    countryCode = await FlutterSimCountryCode.simCountryCode; // return IN
    if (countryCode == null || (countryCode?.isEmpty ?? true)) {
      countryCode = 'NA';
    }
  } on Exception {
    countryCode = 'NA';
  }

  if (kDebugMode || (!kIsWeb && Platform.isIOS)) {
    countryCode = 'IN';
  }

  if (!kIsWeb) {
    ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  firebaseAnalytics = FirebaseAnalytics.instance;
  firebaseAnalytics?.setAnalyticsCollectionEnabled(true);
  if (kDebugMode) {
    firebaseAnalytics?.setAnalyticsCollectionEnabled(false);
  }

  // if (kReleaseMode) {
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //   Isolate.current.addOnExitListener(RawReceivePort((pair) async {}).sendPort);

  //   Isolate.current.addErrorListener(RawReceivePort((pair) async {
  //     final List<dynamic> errorAndStacktrace = pair;ok
  //     await FirebaseCrashlytics.instance.recordError(
  //       errorAndStacktrace.first,
  //       errorAndStacktrace.last,
  //     );
  //   }).sendPort);
  // }

  if (kIsWeb) {
    await web_hive.Hive.initFlutter();
  } else {
    String path = await AppFunctions().getApplicationDirectory();
    Hive.init(path);
  }

  Hive.registerAdapter<AppLanguageEntity>(AppLanguageEntityAdapter());

  bakeryBox = await Hive.openBox(HiveBoxConstants.DMT_BOX);
  appLanBox = await Hive.openBox(HiveBoxConstants.APP_LAN_BOX);
  userLanBox = await Hive.openBox(HiveBoxConstants.USER_LAN_BOX);
  currentLanBox = await Hive.openBox(HiveBoxConstants.CURRENT_LANG_BOX);
  userDataBox = await Hive.openBox(HiveBoxConstants.USER_DATA_BOX);
  generalSettingBox = await Hive.openBox(HiveBoxConstants.GENERAL_SETTING_BOX);
  appActivityAnaltics = await Hive.openBox(HiveBoxConstants.APP_ACTIVITY_ANALYTICS);

  isFirst = await bakeryBox.get(HiveConstants.IS_FIRST_LOAD, defaultValue: true);
  launchNo = await bakeryBox.get(HiveConstants.LAUNCH_NUMBER, defaultValue: 0);
  currentLangCode = await currentLanBox.get(HiveConstants.PREFERRED_LANGUAGE, defaultValue: 'en');
  userLoginData = await userDataBox.get(HiveConstants.USER_ENTITY_DATA, defaultValue: null);
  userToken = await userDataBox.get(HiveConstants.USER_TOKEN, defaultValue: null);
  generalSettingEntity = await generalSettingBox.get(HiveConstants.GENERAL_SETTING_DATA, defaultValue: null);
  freePlanAds = generalSettingEntity?.freePlanAds;
  customAdsSetting = generalSettingEntity?.customAdsSetting;
  isTourCompleted = await bakeryBox.get(HiveConstants.IS_TOUR_COMPLETED, defaultValue: true);
  deviceData = Map<String, String>.from(await bakeryBox.get(HiveConstants.DEVICE_DATA, defaultValue: {}));

  appStartTime = await bakeryBox.get(HiveConstants.APP_START_TIME, defaultValue: null);
  appCloseTime = await bakeryBox.get(HiveConstants.APP_CLOSE_TIME, defaultValue: null);
  userAppActivity = Map<String, int>.from(await bakeryBox.get(HiveConstants.USER_APP_ACTIVITY, defaultValue: {}));
  imageImpression = Map<String, int>.from(await bakeryBox.get(HiveConstants.IMAGE_IMPRESSION, defaultValue: {}));
  imageScrollCount = List<int>.from(await bakeryBox.get(HiveConstants.IMAGE_SCROLL_COUNT, defaultValue: []));
  isAdsOnline = await bakeryBox.get(HiveConstants.IS_ADS_ONLINE, defaultValue: false);

  totalProductView = await bakeryBox.get(HiveConstants.TOTAL_DOWNLOAD_POST, defaultValue: 0);
  appOpenCount = await bakeryBox.get(HiveConstants.APP_OPEN_COUNT, defaultValue: 0);

  getFreeDiskSpace = await bakeryBox.get(HiveConstants.GET_FREE_DISK_SPACE, defaultValue: null);
  getTotalDiskSpace = await bakeryBox.get(HiveConstants.GET_TOTAL_DISK_SPACE, defaultValue: null);
  getFreeRAM = await bakeryBox.get(HiveConstants.GET_FREE_RAM, defaultValue: null);
  getTotalRAM = await bakeryBox.get(HiveConstants.GET_TOTAL_RAM, defaultValue: null);

  bakeryBox.put(HiveConstants.LAUNCH_NUMBER, launchNo + 1);
  deviceData = await AppFunctions().initPlatformState();
  await saveAssetsLangToDevice();

  if (isFirst!) {
    bakeryBox.put(HiveConstants.SHARE_NUMBER, 0);
    bakeryBox.put(HiveConstants.NAV_NUMBER, 0);
    bakeryBox.put(HiveConstants.IS_FIRST_LOAD, false);
    languages = [
      AppLanguageEntity(id: 1, name: 'English', shortCode: 'en', isDefault: 1, imageUrl: ''),
    ];
    appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
    currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, 'en');
    await firebaseAnalytics?.logEvent(name: 'custom_first_open');
  } else {
    languages = List<AppLanguageEntity>.from(
      await appLanBox.get(
        HiveConstants.APP_LANGUAGE_LIST,
        defaultValue: <AppLanguageEntity>[
          AppLanguageEntity(id: 1, name: 'English', shortCode: 'en', isDefault: 1, imageUrl: ''),
        ],
      ),
    );

    var filterList = languages.where((element) => (element.isDefault == 1)).toList();
    String currentLang = filterList.isNotEmpty ? filterList[0].shortCode : 'en';
    currentLangCode = currentLang;
    currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, currentLang);
  }

  navigationCount = await bakeryBox.get(HiveConstants.NAV_NUMBER, defaultValue: 0);
  unawaited(get_it.init());

  HttpOverrides.global = MyHttpOverrides();

  CatcherOptions releaseOptions = CatcherOptions(
    SilentReportMode(),
    [
      ConsoleHandler(enableStackTrace: false),
      HttpHandler(
        HttpRequestType.post,
        Uri.parse("https://bakery.oceanmtechdmt.in/api/v7/error-log/save"),
        headers: {'Content-Type': 'application/json', "Accept": 'application/json'},
        enableCustomParameters: true,
      ),
    ],
    customParameters: {
      "user_id": userLoginData?.id ?? "",
      'mobile_no': userLoginData?.mobileNo ?? "",
      "error_log": '',
      "error_type": "app",
    },
  );

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.

  var catcher = Catcher(rootWidget: const BakeryApp(), ensureInitialized: true, enableLogger: true);

  CatcherOptions debugOptions = CatcherOptions(
    SilentReportMode(),
    [ConsoleHandler(enableStackTrace: true)],
  );

  catcher.updateConfig(debugConfig: debugOptions, releaseConfig: releaseOptions);
}

Future<void> saveAssetsLangToDevice() async {
  if (kIsWeb) {
    final jsonString = await rootBundle.loadString('assets/languages/en.json');
    storage.setItem('en.json', jsonString);
  } else {
    globalDownloadLocation = '${await AppFunctions().getApplicationDirectory()}${Platform.pathSeparator}OceanMTech';
    languageLocalPath = '${await AppFunctions().getApplicationDirectory()}${Platform.pathSeparator}languages';
    ByteData byteData = await rootBundle.load("assets/languages/en.json");

    if (!await Directory(languageLocalPath).exists()) {
      await Directory(languageLocalPath).create();
    }

    File file = await File('$languageLocalPath/en.json').create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}
