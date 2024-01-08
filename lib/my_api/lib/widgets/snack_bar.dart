// ignore_for_file: constant_identifier_names

import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackbarType { SUCCESS, ERROR, PROCESSING }

class CustomSnackbar {
  static show({
    required SnackbarType snackbarType,
    required String message,
    IconData? icon,
    Color? bgColor,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      padding: EdgeInsets.all(12.w),
      elevation: 8,
      duration: duration ??
          (snackbarType == SnackbarType.PROCESSING ? const Duration(seconds: 5) : const Duration(seconds: 3)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CommonWidget.imageBuilder(
              imageUrl: snackbarType == SnackbarType.ERROR
                  ? "assets/photos/svg/common/warning.svg"
                  : "assets/photos/svg/common/circle_checl.svg",
              color: Colors.white,
              height: 20.w,
              width: 20.w,
            ),
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: bgColor ??
          (snackbarType == SnackbarType.ERROR
              ? Colors.red.withOpacity(0.9)
              : snackbarType == SnackbarType.PROCESSING
                  ? Colors.green[900]
                  : appConstants.themeColor),
    );

    if (isConnectionSuccessful ||
        (message == "Back Online!!!" ||
            message == "No Connection" ||
            message == "Please check your internet connection" ||
            message == "Network Change Detected")) {
      snackbarKey.currentState?.hideCurrentSnackBar();
      snackbarKey.currentState?.clearSnackBars();
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }

  static showMesssageWithPosition({
    required SnackbarType snackbarType,
    required String message,
    IconData? icon,
    String? imagePath,
    Color? bgColor,
    Duration? duration,
    Widget? action,
  }) {
    final snackBar = SnackBar(
      padding: EdgeInsets.all(12.w),
      elevation: 0,
      duration: duration ??
          (snackbarType == SnackbarType.PROCESSING ? const Duration(seconds: 5) : const Duration(seconds: 3)),
      content: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 1,
        color: Colors.white24,
        child: SizedBox(
          height: 80.h,
          width: ScreenUtil().screenWidth,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imagePath != null ? CommonWidget.sizedBox(width: 8.w) : const SizedBox.shrink(),
                imagePath != null
                    ? Container(
                        color: Colors.white,
                        width: 50.r,
                        height: 50.r,
                        child: Center(
                          child: CommonWidget.imageBuilder(imageUrl: imagePath, width: 50.r, height: 50.r),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CommonWidget.imageBuilder(
                          imageUrl: snackbarType == SnackbarType.ERROR
                              ? "assets/svgs/warning.svg"
                              : "assets/svgs/circle_checl.svg",
                          color: Colors.white,
                          height: 20.w,
                          width: 20.w,
                        ),
                      ),
                imagePath != null ? CommonWidget.sizedBox(width: 16.w) : const SizedBox.shrink(),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                action != null
                    ? Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Container(width: 2, height: 80.h, color: Colors.white),
                      )
                    : const SizedBox.shrink(),
                action ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: bgColor ??
          (snackbarType == SnackbarType.ERROR
              ? Colors.red.withOpacity(0.9)
              : snackbarType == SnackbarType.PROCESSING
                  ? Colors.green[900]
                  : appConstants.themeColor),
    );

    snackbarKey.currentState?.hideCurrentSnackBar();
    snackbarKey.currentState?.clearSnackBars();
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
