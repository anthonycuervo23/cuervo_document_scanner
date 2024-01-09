// ignore_for_file: empty_catches

import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/check_storage_permission.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

void commonPrint(Object? object) {
  debugPrint(object.toString());
}

class AppFunctions {
  bool isUserLoggedIn() {
    bool isUserLoggedIn = false;
    if (userLoginData != null && userLoginData!.token.isNotEmpty) {
      return true;
    }
    return isUserLoggedIn;
  }

  String? getUserToken() {
    // String? token;
    // if (userLoginData != null) {
    //   return userLoginData!.token;
    // }
    String? accessToken = userDataBox.get(HiveConstants.USER_TOKEN, defaultValue: null);
    userToken = accessToken;

    if (kDebugMode) {
      print('getToken ==> $accessToken');
    }
    // String? accessToken = SharedPref.instance.shared?.getString(SharePrefConstants.token);
    return accessToken;
  }

  Future<void> checkAndLogout() async {
    Future.delayed(
      Duration.zero,
      () async {
        if (userLoginData == null) {
          AppFunctions().forceLogout();
          return;
        }
      },
    );
  }

  Future<void> forceLogout({bool onClearData = false}) async {
    // if (isCRM) return;

    // if (currentRouteName == RouteList.login || currentRouteName == RouteList.gmail_login) {
    //   return;
    // }

    // isCRM = false;
    // crmMemberId = null;
    // crmMobileNo = null;
    // defaultBusiness = null;
    // isFirst = true;
    // launchNo = 0;
    // myBusinessList = null;
    // deviceData = null;
    // generalSettingEntity = null;
    // freePlanAds = null;
    // isBusinessCreated = false;

    bakeryBox.clear();
    appLanBox.clear();
    userLanBox.clear();
    currentLanBox.clear();
    userDataBox.clear();
    generalSettingBox.clear();
    appActivityAnaltics.clear();
    // bakeryBox.put(HiveConstants.IS_FIRST_LOAD, false);
    userEntity = null;
    // if (!onClearData) {
    //   Catcher2.navigatorKey?.currentState?.popUntil((route) => (route.isFirst));

    //   if ((countryCode.toString().toLowerCase() == "in") || isCRM) {
    userLoginData = null;
    await FirebaseAuth.instance.signOut();
    await Catcher2.navigatorKey?.currentState?.pushReplacementNamed(RouteList.login_screen);
    //   } else {
    //     userLoginData = null;
    //     await Catcher2.navigatorKey?.currentState?.pushReplacementNamed(RouteList.gmail_login);
    //   }
    // } else {
    //   userLoginData = null;
    // }
  }

  Future<Map<String, String>> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    deviceData = <String, String>{};
    try {
      if (Platform.isAndroid) {
        var data = await deviceInfoPlugin.androidInfo;
        deviceData = await _readAnroidDeviceInfo(data);
        await bakeryBox.put(HiveConstants.DEVICE_DATA, deviceData);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceData = _readIosDeviceInfo(data);
        await bakeryBox.put(HiveConstants.DEVICE_DATA, deviceData);
      }
    } on PlatformException {
      deviceData = <String, String>{
        'device_model': "test",
        'systemVersion': "notfound",
        'device_type': Platform.isAndroid ? "android" : "ios",
        'device_id': deviceNotificationToken.toString().isEmpty ? 'notfound' : deviceNotificationToken.toString(),
        'unique_id': "notfound",
      };
      await bakeryBox.put(HiveConstants.DEVICE_DATA, deviceData);
    }
    if (kDebugMode) {
      // print(deviceData);
    }

    if (deviceData != null && deviceData!.containsKey('device_id')) {
      if (deviceNotificationToken.toString().isEmpty) {
        deviceData!['device_id'] = 'notfound';
      } else {
        deviceData!['device_id'] = deviceNotificationToken.toString();
      }
    } else {
      if (deviceNotificationToken.toString().isEmpty) {
        deviceData!['device_id'] = 'notfound';
      } else {
        deviceData?.addAll({'device_id': deviceNotificationToken.toString()});
      }
    }

    return deviceData ??
        <String, String>{
          'device_model': "test",
          'systemVersion': "notfound",
          'device_type': Platform.isAndroid ? "android" : "ios",
          'device_id': deviceNotificationToken.toString().isEmpty ? 'notfound' : deviceNotificationToken.toString(),
          'unique_id': "notfound",
        };
  }

  Map<String, String> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, String>{
      'device_model': data.model,
      'systemVersion': data.systemVersion,
      'device_type': Platform.isAndroid ? "android" : "ios",
      'device_id': deviceNotificationToken.toString().isEmpty ? 'notfound' : deviceNotificationToken.toString(),
      'unique_id': data.identifierForVendor ?? 'unknown',
      'release': data.systemVersion.toString()
    };
  }

  Future<Map<String, String>> _readAnroidDeviceInfo(AndroidDeviceInfo data) async {
    const androidIdPlugin = AndroidId();
    final String? androidId = await androidIdPlugin.getId();

    if (androidId != null) {
      appsflyerSdk.setAndroidIdData(androidId);
    }

    return <String, String>{
      'device_model': data.model,
      'systemVersion': data.version.sdkInt.toString(),
      'device_type': Platform.isAndroid ? "android" : "ios",
      'device_id': deviceNotificationToken.toString().isEmpty ? 'notfound' : deviceNotificationToken.toString(),
      'unique_id': androidId?.toString() ?? 'notfound',
      'release': data.version.release.toString(),
    };
  }

  Future<void> downloadAtDMTLocation(BuildContext context, String downloadUrl) async {
    if (await CheckStoragePermission().checkPermission(context: context)) {
      String dataLocation = globalDownloadLocation + globalDataLocation;

      if (downloadUrl.contains('http')) {
        // download http location
        if (downloadUrl.contains('mp4') || downloadUrl.endsWith('mkv')) {
          Client client = Client();
          var req = await client.get(Uri.parse(downloadUrl));
          if (req.statusCode >= 400) {
            throw HttpException(req.statusCode.toString());
          }
          var bytes = req.bodyBytes;

          File file = File('$dataLocation/${downloadUrl.split('/').last}');
          if (await File(file.path).exists()) {
            await file.writeAsBytes(bytes);
          } else {
            await File(file.path).create(recursive: true);
            await file.writeAsBytes(bytes);
          }

          String filePath = '$dataLocation/${'${downloadUrl.split('.').first}_thumbnail'}.jpeg';
          if (!(await File(filePath).exists())) {
            await File(filePath).create(recursive: true);
          }

          // String? thumbnailImage = await VideoThumbnail.thumbnailFile(
          //   video: file.toString().trim(),
          //   thumbnailPath: (await getTemporaryDirectory()).path,
          //   imageFormat: ImageFormat.JPEG,
          //   maxHeight: 120,
          //   quality: 80,
          //   maxWidth: 120,
          // );
          // print(thumbnailImage);
        } else {
          Client client = Client();
          var req = await client.get(Uri.parse(downloadUrl));
          if (req.statusCode >= 400) {
            throw HttpException(req.statusCode.toString());
          }
          var bytes = req.bodyBytes;

          File file = File('$dataLocation/${downloadUrl.split('/').last}');
          if (await File(file.path).exists()) {
            await file.writeAsBytes(bytes);
          } else {
            await File(file.path).create(recursive: true);
            await file.writeAsBytes(bytes);
          }
        }
      } else {
        // download from file location
        File file;
        if (downloadUrl.contains('mp4')) {
          // mp4 location
          file = File('$dataLocation/${downloadUrl.split('/').last}');
          // /${'${downloadUrl.split('/').last.split('.').first}_thumbnail'}.jpeg
          // try {
          //   await VideoThumbnail.thumbnailFile(
          //     video: file.path.toString().trim(),
          //     thumbnailPath: dataLocation,
          //     imageFormat: ImageFormat.JPEG,
          //     maxHeight: isStory ? 1920 : 1080,
          //     quality: 80,
          //     maxWidth: 1080,
          //   );
          // } on Exception {}
        } else {
          file = File('$dataLocation/${downloadUrl.split('/').last}');
        }
        if (await File(file.path).exists()) {
          await File(downloadUrl).copy(file.path);
        } else {
          await File(file.path).create(recursive: true);
          await File(downloadUrl).copy(file.path);
        }
      }
    }
  }

  Future<void> initTrackingDialog() async {
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        // Show a custom explainer dialog before the system dialog
        // Wait for dialog popping animation
        await Future.delayed(const Duration(milliseconds: 200));
        // Request system's tracking authorization dialog
        await AppTrackingTransparency.requestTrackingAuthorization();
      }

      await AppTrackingTransparency.getAdvertisingIdentifier();
    } on Exception {}
  }

  isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  void popAllAlertDialog(BuildContext context) {
    Catcher2.navigatorKey?.currentState?.popUntil((route) => isThereCurrentDialogShowing(context) == false);
  }

  void cleanUpMemory() {
    ImageCache imageCache = PaintingBinding.instance.imageCache;

    if (imageCache.currentSizeBytes >= 55 << 20 || imageCache.currentSize >= 50) {
      imageCache.clear();
    }
    if (imageCache.liveImageCount >= 20) {
      imageCache.clearLiveImages();
    }
  }

  Future<void> incrementNotificationCount() async {
    int count = await getNotificationCount();
    prefs ??= await SharedPreferences.getInstance();
    if (prefs != null) {
      (prefs)!.setInt('notifications_count', count + 1);
      totalNotificationCounts = count + 1;
      badgeCounterCubit.reloadState();
    }
  }

  Future<void> decrementNotificationCount() async {
    int count = await getNotificationCount();
    prefs ??= await SharedPreferences.getInstance();
    if (prefs != null) {
      (prefs)!.setInt('notifications_count', (count - 1 > 0 ? (count - 1) : 0));
      totalNotificationCounts = (count - 1 > 0 ? (count - 1) : 0);
      badgeCounterCubit.reloadState();
    }
  }

  Future<int> getNotificationCount() async {
    prefs ??= await SharedPreferences.getInstance();
    if (prefs != null) {
      totalNotificationCounts = (prefs)!.getInt('notifications_count') ?? 0;
      badgeCounterCubit.reloadState();
      return totalNotificationCounts;
    }
    return 0;
  }

  Future<void> resetNotificationCount() async {
    prefs ??= await SharedPreferences.getInstance();
    if (prefs != null) {
      (prefs)!.setInt('notifications_count', 0);
      totalNotificationCounts = 0;
      badgeCounterCubit.reloadState();
    }
  }
}
