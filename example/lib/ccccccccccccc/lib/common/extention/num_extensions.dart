import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtension on num {
  String convertToPercentageString() {
    return '${((this) * 10).toStringAsFixed(0)} %';
  }

  double toDp() {
    double width = ScreenUtil().screenWidth;
    // double height = ScreenUtil().screenHeight;
    // print((width * this) / 1080);
    return ((width * this) / 1080);

    // if (kDebugMode) {
    //     print(this.toString() + ":" + (this / 3).toString());
    // }
    // // // print(ScreenUtil().screenWidth);
    // return (this / 3);
  }

  double toDIEWidthDp({double? canWidth}) {
    if (canWidth == 0 || canWidth == null) {
      return toDouble();
    } else if (canWidth < 360) {
      return toDouble();
    }
    return ((ScreenUtil().screenWidth * 0.98) * this) / (canWidth);
  }

  double toOrigionalDIEWidthDp({required double canWidth}) {
    return (this * canWidth) / (ScreenUtil().screenWidth * 0.98);
  }

  double toRatioScale({required double ratio}) {
    return this / ratio;
  }

  double toWidthDp() {
    double width = ScreenUtil().screenWidth;
    // double height = ScreenUtil().screenHeight;

    return ((width * this) / 1080);

    // return (this / 3);
  }

  double toOrigionalWidthDp() {
    double width = ScreenUtil().screenWidth;

    return ((this * 1080) / width);

    // return (this / 3);
  }

  double toHeightDp() {
    // double width = ScreenUtil().screenWidth;
    double height = ScreenUtil().screenHeight;

    return ((height * this) / 1920).toDouble();
    // return ((1080 * this) / height) / 2;

    // return (this / 3);
  }

  double toSreenDp() {
    // double width = ScreenUtil().screenWidth;
    // double height = ScreenUtil().screenHeight;
    double pixelRatio = ScreenUtil().pixelRatio?.toDouble() ?? 3;

    return (this / pixelRatio);

    // return (this / 3);
  }

  double toStoryHeightDp() {
    double height = ScreenUtil().scaleHeight;
    // double height = ScreenUtil().screenHeight;

    return ((height * this) / 1920);

    // return (this / 3);
  }

  double toOrigional() {
    // print(this.toString() + ":" + (this / 3).toString());
    // // print(ScreenUtil().screenWidth);
    return (this).toDouble();
  }

  double toScaledFont() {
    // print(this.toString() + ":" + (this / 3).toString());
    // // print(ScreenUtil().screenWidth);
    return (this * 3).toDouble();
  }

  double opacityInScale() {
    return (this / 100) > 1 ? 1 : (this / 100);
  }
}
