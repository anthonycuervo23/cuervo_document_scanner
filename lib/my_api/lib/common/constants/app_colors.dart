import 'package:flutter/material.dart';

class AppColor {
  static const Color _black = Colors.black;
  static const Color _appTitle = Colors.black;
  static const Color _white = Colors.white;
  static const Color _iconColor = Colors.white;
  static const Color _notificationTextColor = Colors.white;
  static const Color _drawerTextColor = Colors.white;
  static const Color _white1 = Colors.white54;
  static const Color _blueAccent = Colors.blueAccent;
  static const Color _blue = Colors.blue;
  static const Color _grey = Colors.grey;
  static const Color _black12 = Colors.black12;
  static const Color _black26 = Colors.black26;
  static const Color _black38 = Colors.black38;
  static const Color _black45 = Colors.black45;
  static const Color _black54 = Colors.black54;
  static const Color _black87 = Colors.black87;
  static const Color _red = Colors.red;
  static const Color _transparent = Colors.transparent;
  static const Color _hintText = Colors.black38;
  static const Color _imagepickerbox = Color.fromRGBO(244, 244, 244, 1);
  static const Color _familyDetailsBox = Color.fromRGBO(245, 245, 245, 1);
  static const Color _starColor = Color.fromRGBO(255, 177, 59, 1);
  static const Color _backgroundColor = Color.fromRGBO(242, 242, 242, 1);
  static const Color _homeBackgroundColor = Color.fromRGBO(244, 244, 244, 1);
  static const Color _noButtonColor = Color.fromRGBO(255, 231, 210, 1);
  static const Color _introScreenDescriptionText = Color.fromRGBO(34, 34, 34, 0.6);
  static const Color _disableButtonColor = Color.fromRGBO(34, 34, 34, 0.3);
  static const Color _familyDetailContainerTextColor = Color.fromRGBO(34, 34, 34, 0.4);
  static const Color _themeColor = Color.fromRGBO(183, 84, 0, 1);
  static const Color _containerColor = Color.fromRGBO(255, 244, 234, 1);
  static const Color _borderColor = Color.fromRGBO(183, 84, 0, 0.4);
  static const Color _outOfRangeDotIndicator = Color.fromRGBO(229, 215, 202, 1);
  static const Color _coinColor = Color.fromRGBO(248, 174, 31, 1);
  static const Color _greyBorderColor = Colors.black87;

  static const Color _bestSellerContainer = Color.fromRGBO(255, 243, 225, 1);
  // static const Color _trashBackground = Color.fromRGBO(255, 229, 229, 1);
  // static const Color _shareBackground = Color.fromRGBO(222, 241, 228, 1);
  static const Color _paidColor = Color.fromRGBO(53, 121, 253, 1);
  static const Color _unpaidColor = Color.fromRGBO(240, 149, 13, 1);
  static const Color _deliveredColor = Color.fromRGBO(0, 170, 17, 1);
  static const Color _cancelledColor = Color.fromRGBO(244, 54, 54, 1);
  static const Color _refundOrderColor = Color.fromRGBO(150, 67, 255, 1);

  static late Color background;
  static late Color appbarColor;
  static late Color appbarTextColor;
  static late Color black;
  static late Color iconColor;
  static late Color appTitle;
  static late Color drawerTextColor;
  static late Color imagepickerbox;
  // static late Color shareBackground;
  static late Color introScreenDescriptionText;
  static late Color paidColor;
  static late Color coinColor;
  static late Color unpaidColor;
  static late Color refundOrderColor;
  static late Color cancelledColor;
  static late Color bestSellerContainer;
  static late Color deliveredColor;
  static late Color white;
  static late Color noButtonColor;
  static late Color familyDetailsBox;
  // static late Color trashBackground;
  static late Color starColor;
  static late Color disableButtonColor;
  static late Color familyDetailContainerTextColor;
  static late Color notificationTextColor;
  static late Color containerColor;
  static late Color backgroundColor;
  static late Color homeBackgroundColor;
  static late Color outOfRangeDotIndicator;
  static late Color white1;
  static late Color black12; // grey0
  static late Color black26; // grey1
  static late Color black38; // grey2
  static late Color black45; // grey3
  static late Color black54; // grey4
  static late Color black87; // grey5
  static late Color grey;
  static late Color textColor;
  static late Color transparent;
  static late Color highlightTextColor;
  static late Color buttonColor;
  static late Color red;
  static late Color icon;
  static late Color hintText;
  static late Color buttonTextColor;
  static late Color themeColor;
  static late Color borderColor;
  static late Color greyBorderColor;

  static void loadColor(bool isLightMode) {
    if (isLightMode) {
      loadLight();
    } else {
      loadDark();
    }
  }

  static void loadLight() {
    themeColor = _themeColor;
    background = _white;
    appbarTextColor = _white;
    appbarColor = _white;
    iconColor = _iconColor;
    black = _black;
    drawerTextColor = _drawerTextColor;
    noButtonColor = _noButtonColor;
    starColor = _starColor;
    coinColor = _coinColor;
    // trashBackground = _trashBackground;
    white = _white;
    paidColor = _paidColor;
    unpaidColor = _unpaidColor;
    // shareBackground = _shareBackground;
    refundOrderColor = _refundOrderColor;
    bestSellerContainer = _bestSellerContainer;
    cancelledColor = _cancelledColor;
    deliveredColor = _deliveredColor;
    imagepickerbox = _imagepickerbox;
    disableButtonColor = _disableButtonColor;
    familyDetailsBox = _familyDetailsBox;
    familyDetailContainerTextColor = _familyDetailContainerTextColor;
    white1 = _white1;
    appTitle = _appTitle;
    backgroundColor = _backgroundColor;
    outOfRangeDotIndicator = _outOfRangeDotIndicator;
    homeBackgroundColor = _homeBackgroundColor;
    notificationTextColor = _notificationTextColor;
    containerColor = _containerColor;
    textColor = _black;
    introScreenDescriptionText = _introScreenDescriptionText;
    highlightTextColor = _blueAccent;
    buttonTextColor = _white;
    buttonColor = _blue;
    grey = _grey;
    black12 = _black12;
    black26 = _black26;
    black38 = _black38;
    black45 = _black45;
    black54 = _black54;
    black87 = _black87;
    red = _red;
    transparent = _transparent;
    icon = _black;
    hintText = _hintText;
    borderColor = _borderColor;
    greyBorderColor = _greyBorderColor;
  }

  static void loadDark() {
    themeColor = _themeColor;
    background = _black;
    appbarTextColor = _black;
    appbarColor = _white;
    iconColor = _iconColor;
    starColor = _starColor;
    introScreenDescriptionText = _introScreenDescriptionText;
    notificationTextColor = _notificationTextColor;
    noButtonColor = _noButtonColor;
    // trashBackground = _trashBackground;
    // shareBackground = _shareBackground;
    drawerTextColor = _drawerTextColor;
    coinColor = _coinColor;
    black = _white;
    appTitle = _appTitle;
    disableButtonColor = _disableButtonColor;
    backgroundColor = _backgroundColor;
    homeBackgroundColor = _homeBackgroundColor;
    familyDetailsBox = _familyDetailsBox;
    familyDetailContainerTextColor = _familyDetailContainerTextColor;
    textColor = _white;
    bestSellerContainer = _bestSellerContainer;
    paidColor = _paidColor;
    refundOrderColor = _refundOrderColor;
    unpaidColor = _unpaidColor;
    cancelledColor = _cancelledColor;
    deliveredColor = _deliveredColor;
    outOfRangeDotIndicator = _outOfRangeDotIndicator;
    highlightTextColor = _blueAccent;
    buttonTextColor = _white;
    buttonColor = _blue;
    containerColor = _containerColor;
    white1 = _white1;
    grey = _grey;
    imagepickerbox = _imagepickerbox;
    black12 = _black12;
    black26 = _black26;
    black38 = _black38;
    black45 = _black45;
    black54 = _black54;
    black87 = _black87;
    red = _red;
    transparent = _transparent;
    icon = _white;
    hintText = _white;
    greyBorderColor = _greyBorderColor;
  }
}
