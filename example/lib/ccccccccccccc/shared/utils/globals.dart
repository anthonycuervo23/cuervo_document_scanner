// ignore_for_file: unused_element

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:captain_score/features/shorts/presentation/cubit/shorts_cubit.dart';
import 'package:captain_score/shared/common_widgets/app_constants.dart';
import 'package:captain_score/shared/cubit/ads/ads_setting/ads_setting_cubit.dart';
import 'package:captain_score/shared/cubit/analytics/deep_link/deep_link_cubit.dart';
import 'package:captain_score/shared/cubit/counter/counter_cubit.dart';
import 'package:captain_score/shared/cubit/general_setting/general_setting_cubit.dart';
import 'package:captain_score/shared/models/general_setting_model.dart';
import 'package:captain_score/shared/utils/deep_link_data.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:captain_score/di/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AppConstants appConstants;

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldState> templateScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey buttonGlobalKey = GlobalKey();
final GlobalKey<NavigatorState> navigatorKeyNavState = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late Box dmtBox;
late Box appLanBox;
late Box userLanBox;
late Box currentLanBox;
late Box userDataBox;
late Box generalSettingBox;
late Box appActivityAnaltics;
late String currentLangCode;
late bool? isFirst;
late int launchNo;
late bool? isDarkMode;
late FirebaseAnalytics firebaseAnalytics;
String languageLocalPath = '';

Map<String, String>? deviceData;
bool isNewTemplateLoaded = false;
bool isStory = false;
String deviceNotificationToken = '';

Map<dynamic, dynamic>? intentData;
String appSignature = 'captainscore_signature';

FirebaseMessaging messaging = FirebaseMessaging.instance;

//Ads Variables
bool isAdsOnline = false;
bool shouldShowAppOpenAdd = true;
int adsClick = 7;
int maxFailedLoadAttempts = 5;
late AdsSettingCubit adsCubit;
int adsAfterNoOfGrids = 5;
int adsAfterNoOfListItems = 3;
int adsAfterNoOfNavigation = 3;

String? appStartTime;
String? appCloseTime;
Map<String, int> userAppActivity = {};
String countryName = '';
String stateName = '';
String cityName = '';
String pincodeName = '';
String locationJson = '';

String? todayDownloadDate;
int? todayDownloadCount;
int navigationCount = 0;

int? initialLoginMobileNo;
String? countryCode;

bool isPinSet = false;

int totalDownloadPost = 0;
int appOpenCount = 0;

bool showConnectionMessage = false;
bool isConnectionSuccessful = true;
ConnectivityResult? connectivityResult;
StreamSubscription<ConnectivityResult>? connectivitySubscription;

// App Temination State
bool isAppDispatched = false;

bool isContentDefaultLanguageChanged = false;

bool isTourCompleted = true;
bool isBusinessCreated = false;

GlobalKey categoriesGridKey = const GlobalObjectKey("categoriesGridKey");
GlobalKey postGridKey = const GlobalObjectKey("postGridKey");
GlobalKey downloadKey = const GlobalObjectKey("downloadKey");
// Customize
const int kPreloadLimit = 3;

// Customize
const int kNextLimit = 5;

// For better UX, latency should be minimum.
// For demo: 2s is taken but something under a second will be better
const int kLatency = 2;

String globalDownloadLocation = '';
String globalDataLocation = '${Platform.pathSeparator}.data';

int routeDuration = 0;
final routingIsolateReceivePort = ReceivePort();
Isolate? routeIsolate;
final postIsolateReceivePort = ReceivePort();

class Message {
  String message;
  SendPort sendPort;
  int oldDuration;

  Message({
    required this.message,
    required this.sendPort,
    required this.oldDuration,
  });
}

Map<String, dynamic> imageReport = {};
List<int> imageScrollCount = [];
Map<String, int> imageImpression = {};
const int helloAlarmID = 7;

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: "veodNQbCbXDw6BdxBpdnZL",
  appId: "1638145856",
  showDebug: kDebugMode ? true : false,
  timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
  appInviteOneLink: "https://link.captainscore.in/Lp1g/invite", // Optional field
  disableAdvertisingIdentifier: false, // Optional field
  disableCollectASA: false,
); // Optional field

DeepLinkCubit deepLinkCubit = getItInstance<DeepLinkCubit>();

Map deepLinkData = {};
Map? _gcd = {};
DeepLinkData? deepLink;

AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions)
  ..onAppOpenAttribution((res) {
    // print("onAppOpenAttribution res: " + res.toString());
    deepLinkData = res;
    deepLink = DeepLinkData(Map<String, dynamic>.from(deepLinkData));

    deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);

    // print("onAppOpenAttribution res DeepLinkValue: " + deepLink.toString());

    // https://link.captainscore.in/Lp1g?pid=dmt&af_dp=captainscore%253A%252F%252Fmainactivity&af_sub1=KdrhF6&deep_link_path=package-list&af_force_deeplink=true

    // https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**...
  })
  ..onInstallConversionData((dynamic res) {
    // print("onInstallConversionData res: Conv" + res.toString());

    {
      if (res != null) {
        String status = res["af_status"].toString();

        if (status == "Non-organic") {
          // print("Print 1");
          if (res.containsKey("is_first_launch") && res["is_first_launch"].toString() == "true") {
            _gcd = res;
            // print("Conversion: First Launch");
            //Deferred deep link in case of a legacy link
            // print("Print2");
            if (_gcd!.containsKey("deep_link_path")) {
              // print("Print3");
              if (_gcd!.containsKey("deep_link_value")) {
                // print("Print4");
                Map<String, dynamic>? temp = Map<String, dynamic>.from(_gcd!);
                deepLink = DeepLinkData(temp);
                deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);
              } else {
                // print("Print6");
                Map<String, dynamic>? temp = Map<String, dynamic>.from(_gcd!);
                if (!_gcd!.containsKey("deep_link_value")) {
                  temp.addAll({"deep_link_value": _gcd!["deep_link_path"]});
                }
                deepLink = DeepLinkData(temp);
                deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);
              }
            }
          } else {
            // print("Conversion: Not First Launch");
          }
        } else {
          // print("Conversion: This is an organic install.");
        }
      }
    }
  })
  ..onDeepLinking((DeepLinkResult dp) {
    // print("onInstallConversionData res: onDeepLinking " + dp.toString());
    switch (dp.status) {
      case Status.FOUND:
        // print("Print7");
        if (deepLink == null) {
          // print("Print8");
          deepLinkData = dp.toJson();
          // print("Print9 + ${deepLinkData.toString()}");

          if (dp.deepLink?.clickEvent != null) {
            // print("Print 10 + ${deepLinkData.toString()}");
            deepLink = DeepLinkData(dp.deepLink!.clickEvent);
            deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);

            // print("onDeepLinking res: deepLink${deepLink!.deepLinkPath} & Whole Data: ${deepLink.toString()}");
          }
        }
        // print(dp.deepLink?.toString());
        // print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        {
          // print("Print 11 + ${deepLinkData.toString()}");
          if (_gcd != null) {
            String status = _gcd!["af_status"].toString();
            // print("Print 12 + ${status.toString()}");

            if (status == "Non-organic") {
              // print("Print 13 + ${deepLinkData.toString()}");
              if (_gcd!.containsKey("is_first_launch") && _gcd!["is_first_launch"].toString() == "true") {
                // print("Conversion: First Launch");
                //Deferred deep link in case of a legacy link
                if (_gcd!.containsKey("deep_link_value") || _gcd!.containsKey("deep_link_path")) {
                  // print("Print 15 + ${_gcd.toString()}");
                  Map<String, dynamic>? temp = Map<String, dynamic>.from(_gcd!);
                  if (!_gcd!.containsKey("deep_link_value")) {
                    temp.addAll({"deep_link_value": _gcd!["deep_link_path"]});
                  }
                  deepLink = DeepLinkData(temp);
                  deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);
                }
              } else {
                // print("Print 16 + ${_gcd.toString()}");
                // print("Conversion: Not First Launch");
              }
            } else {
              // print("Print 18 + ${_gcd.toString()}");
              // print("Conversion: This is an organic install. onDeepLinking ");
            }
          }
          // print("Print 19 + ${_gcd.toString()}");
        }
      // print("deep link not found");
      // break;
      case Status.ERROR:
        // print("deep link error: ${dp.error}");
        // print("Print 20 + ${_gcd.toString()}");
        break;
      case Status.PARSE_ERROR:
        // print("deep link status parsing error");

        // print("Print 21 + ${_gcd.toString()}");
        break;
    }
    // print("onDeepLinking res: " + dp.toString());
  })
  ..initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  )
  ..waitForCustomerUserId(false);

String? currentRouteName;
Object? routeArguments;

bool isBusinessUpdated = false;
bool isCRMFromHive = false;

enum InternetStatus { connected, notConnected }

StreamController<InternetStatus>? connnectionController = StreamController<InternetStatus>.broadcast();
bool shouldShowBottomSheet = false;
List<String> iosPlansIds = [];

late GeneralSettingCubit generalSettingCubit;
GeneralSettingEntity? generalSettingEntity;

AppUpdateInfo? appUpdateInfo;
// AppCheckerResult? appStoreData;

int totalFullScreenAdsSeen = 0;
Catcher2? catcher;
Brightness postBrightness = Brightness.light;
SharedPreferences? prefs;
int totalNotificationCounts = 0;
CounterCubit? badgeCounterCubit;

PackageInfo? appPackageInfo;

late ShortsCubit shortsCubit;
