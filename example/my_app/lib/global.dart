import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:bakery_shop_flutter/core/build_context.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/features/settings/data/models/ads_data_model.dart';
import 'package:bakery_shop_flutter/features/settings/data/models/general_setting_model.dart';
import 'package:bakery_shop_flutter/features/settings/domain/entities/general_setting_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/account_info_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/analytics/deep_link/deep_link_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/utils/app_constants.dart';
import 'package:bakery_shop_flutter/utils/deep_link_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AppConstants appConstants;

late Box bakeryBox;
late Box appLanBox;
late Box userLanBox;
late Box currentLanBox;
late Box userDataBox;
late Box generalSettingBox;
late Box appActivityAnaltics;

String deviceNotificationToken = '';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

StreamSubscription<ConnectivityResult>? connectivitySubscription;
StreamController<InternetStatus>? connnectionController = StreamController<InternetStatus>.broadcast();
FocusScopeNode currentFocus = FocusScope.of(buildContext);

enum InternetStatus { connected, notConnected }

bool showConnectionMessage = false;
ConnectivityResult? connectivityResult;
bool isConnectionSuccessful = true;

dynamic userLoginData;
dynamic userToken;

Map<String, String>? deviceData;

String globalDownloadLocation = '';
String globalDataLocation = '${Platform.pathSeparator}.data';

SharedPreferences? prefs;
int totalNotificationCounts = 0;
late CounterCubit badgeCounterCubit;
// late ProductListCubit productListCubit;

List<ProductItem> listOfProductData = [];

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: "veodNQbCbXDw6BdxBpdnZL",
  appId: "1638145856",
  showDebug: kDebugMode ? true : false,
  timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
  appInviteOneLink: "https://magiclyavatar.onelink.me/Hcqg/9fmmzqzw", // Optional field
  disableAdvertisingIdentifier: false, // Optional field
  disableCollectASA: false,
); // Optional field

int navigationCount = 0;
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

Map<String, int> userAppActivity = {};
String? currentRouteName;
Object? routeArguments;

DeepLinkCubit deepLinkCubit = getItInstance<DeepLinkCubit>();

Map deepLinkData = {};
Map gcd = {};
DeepLinkData? deepLink;

AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions)
  ..onAppOpenAttribution((res) {
    // print("onAppOpenAttribution res: " + res.toString());
    deepLinkData = res;
    deepLink = DeepLinkData(Map<String, dynamic>.from(deepLinkData));

    deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);

    // print("onAppOpenAttribution res DeepLinkValue: " + deepLink.toString());

    // https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**...
  })
  ..onInstallConversionData((res) {
    // print("onInstallConversionData res: " + res.toString());
    gcd = res;
  })
  ..onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        // print(dp.deepLink?.toString());
        // print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        // print("deep link not found");
        break;
      case Status.ERROR:
        // print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        // print("deep link status parsing error");
        break;
    }
    // print("onDeepLinking res: " + dp.toString());
    deepLinkData = dp.toJson();
    if (dp.deepLink?.clickEvent != null) {
      deepLink = DeepLinkData(dp.deepLink!.clickEvent);
      deepLinkCubit.updateDeepLinkData(deepLinkData: deepLink);
      if (kDebugMode) {
        print("onDeepLinking res: deepLink${deepLink!.deepLinkPath} & Whole Data: ${deepLink.toString()}");
      }
    }
  })
  ..initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  )
  ..waitForCustomerUserId(false);

late String currentLangCode;

bool isFirst = true;
bool isTourCompleted = false;

late int launchNo;
late bool? isDarkMode;
late FirebaseAnalytics? firebaseAnalytics;
String languageLocalPath = '';

int? initialLoginMobileNo;
String? countryCode;

GeneralSettingEntity? generalSettingEntity;
FreePlanAds? freePlanAds;

// Custom Ads Data
List<CustomAds> customBannerAds = [];
List<CustomAds> customLargeBannerAds = [];
List<CustomAds> customFullScreenAds = [];
List<CustomAds> customNativeAds = []; //Native Image Ads
List<CustomAds> customNativeAdvancedAds = []; //Native Video Ads
List<CustomAds> customRewardVideoAds = [];
List<CustomAds> customAppOpenAds = [];
List<AdsSchedule> adsSchedule = [];
CustomAdsSetting? customAdsSetting;

String? appStartTime;
String? appCloseTime;
String countryName = '';
String stateName = '';
String cityName = '';
String pinCode = '';
String locationJson = '';
String? googleUserName = '';

Map<String, dynamic> imageReport = {};
List<int> imageScrollCount = [];
Map<String, int> imageImpression = {};
const int helloAlarmID = 7;
List<ProductDataForCartModel> localCartDataStore = [];

bool isAdsOnline = false;
bool isCustomAdsOnline = false;
bool shouldShowAppOpenAdd = true;

int totalProductView = 0;
int appOpenCount = 0;

// Check Device Available Storage using Dart
double? getFreeDiskSpace;
double? getTotalDiskSpace;
double? getFreeRAM;
double? getTotalRAM;

List<TempProductData> favoriteProductList = [];
List<ProductDataForCartModel> localCartProduct1 = [];
List<ProductDataForCartModel> localCartProduct = [];

AccountInfoEntity? accountInfoEntity;
FontsData? fonts = accountInfoEntity?.appSetting.fonts;

UserEntity? userEntity;
MyCartEntity? myCartEntity;
OfferDataEntity? offerDataEntity;
CouponData? appliedCouponData;
// UserDataLoadCubit userDataLoadCubit;

late AddAddressCubit addAddressCubit;
