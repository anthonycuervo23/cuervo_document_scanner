import 'dart:io';

import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void listenConnection() {
  connectivitySubscription = Connectivity().onConnectivityChanged.listen(
    (ConnectivityResult result) {
      if (kDebugMode) {
        print("Connection$result");
      }
      connectivityResult = result;
      if (result == ConnectivityResult.wifi) {
        if (Platform.isAndroid) {
          _tryConnection();
        } else {
          connnectionController?.sink.add(InternetStatus.connected);
          showConnectionMessage = true;
          CustomSnackbar.show(
            snackbarType: SnackbarType.SUCCESS,
            message: "Back Online!!!",
            bgColor: Colors.green[800],
          );
        }
      } else if (result == ConnectivityResult.mobile) {
        if (Platform.isAndroid) {
          _tryConnection();
        } else {
          connnectionController?.sink.add(InternetStatus.connected);
          showConnectionMessage = true;
          CustomSnackbar.show(
            snackbarType: SnackbarType.SUCCESS,
            message: "Back Online!!!",
            bgColor: Colors.green[800],
          );
        }
      } else {
        isConnectionSuccessful = false;
        if (showConnectionMessage) {
          connnectionController?.sink.add(InternetStatus.notConnected);
          CustomSnackbar.show(
            snackbarType: SnackbarType.ERROR,
            message: "No Connection",
            duration: const Duration(hours: 1),
          );
        } else {
          showConnectionMessage = true;
        }
      }
    },
  );
}

Future<void> _tryConnection() async {
  try {
    try {
      final ping = Ping('google.com', count: 2);
      ping.stream.listen((event) {
        if (event.summary?.received == 2) {
          isConnectionSuccessful = true;
          if (showConnectionMessage) {
            connnectionController?.sink.add(InternetStatus.connected);
            CustomSnackbar.show(
              snackbarType: SnackbarType.SUCCESS,
              message: "Back Online!!!",
              bgColor: Colors.green[800],
            );
            ping.stop();
          } else {
            showConnectionMessage = true;
          }
        }
      });
    } on SocketException {
      isConnectionSuccessful = false;
      if (showConnectionMessage) {
        connnectionController?.sink.add(InternetStatus.notConnected);
        CustomSnackbar.show(
          snackbarType: SnackbarType.ERROR,
          message: "No Connection",
          duration: const Duration(hours: 1),
        );
      } else {
        showConnectionMessage = true;
      }
    }
  } on Exception {
    if (kDebugMode) {
      print(Exception);
    }
  }
}
