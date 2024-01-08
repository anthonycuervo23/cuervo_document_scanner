// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CheckStoragePermission {
  Future<bool> checkPermission({required BuildContext context}) async {
    bool isAllowed = false;

    String versionCode = '';
    if ((!kIsWeb && Platform.isAndroid)) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      var data = await deviceInfoPlugin.androidInfo;
      versionCode = data.version.release.toString();
    }

    if (((!kIsWeb && Platform.isAndroid) && await Permission.storage.request().isGranted) ||
        ((!kIsWeb && Platform.isAndroid) && versionCode == '13' && await Permission.photos.request().isGranted) ||
        ((!kIsWeb && Platform.isIOS) && await Permission.photos.request().isGranted)) {
      isAllowed = true;
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Files Permission'),
          content: const Text('This app needs file access to save PDF & Images files.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Deny'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text('Settings'),
              onPressed: () async {
                await openAppSettings();
              },
            ),
          ],
        ),
      );
      Navigator.of(context).pop();
    }
    // print(isAllowed);

    return isAllowed;
  }

  Future<bool> checkCameraPermission({required BuildContext context}) async {
    bool isAllowed = false;

    if (((!kIsWeb && Platform.isAndroid) && await Permission.camera.request().isGranted) ||
        ((!kIsWeb && Platform.isIOS) && await Permission.camera.request().isGranted)) {
      isAllowed = true;
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Files Permission'),
          content: const Text('This app needs file camera access to edit template files.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Deny'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text('Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    // print(isAllowed);

    return isAllowed;
  }
}