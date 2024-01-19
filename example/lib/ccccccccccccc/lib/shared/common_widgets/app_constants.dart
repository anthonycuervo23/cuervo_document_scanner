// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class AppConstants {
  AppConstants() : super() {
    loadColor(true);
  }

  FontWeight appFontWeight = FontWeight.bold;
  FontWeight appFontW800 = FontWeight.w800;
  double iconSize = 32;
  double fontSize = 20;
  String intentDataChannel = "app.channel.shared.data";
  String intentDataChannelMethod = "getSharedText";
  IconThemeData appIconThemeData = const IconThemeData(size: 26);

  String loctionApiKey = 'AIzaSyA6vKEF9G12zSbgsJBcTxUVXvGzlnBnMJ4';

  Color _defaultColor = const Color(0xff222222);
  Color _primaryColor = const Color(0xff0F1B49);
  Color _secondaryColor = Color((int.parse('0xff${'FFDDC0'}')));
  Color _whiteBackgroundColor = Color((int.parse('0xff${'FFFFFF'}')));
  Color _greyBackgroundColor = Color((int.parse('0xff${'F4F4F4'}')));
  Color _greyColor1 = const Color.fromRGBO(237, 237, 237, 1);
  Color _greyTextColor = const Color.fromRGBO(126, 126, 126, 1);
  Color _dividerColor = const Color.fromRGBO(216, 216, 216, 1);
  Color _textColor = const Color.fromRGBO(32, 32, 32, 1);
  Color _textColor1 = const Color.fromRGBO(32, 32, 32, 0.5);
  Color _greyButtonColor = const Color.fromRGBO(241, 241, 241, 1);
  Color _dividerColors = const Color.fromRGBO(235, 235, 235, 1);
  Color _yellow = const Color.fromRGBO(240, 202, 57, 1);
  Color _red = const Color.fromRGBO(255, 23, 23, 1);
  Color _green = const Color.fromRGBO(55, 206, 2, 1);
  Color _circleColor = const Color.fromRGBO(255, 255, 255, 0.13);
  Color _gradiantColor1 = const Color.fromRGBO(54, 89, 148, 1);
  Color _gradiantColor2 = const Color.fromRGBO(15, 27, 73, 1);
  Color _unSelectedIconColor = const Color.fromRGBO(126, 145, 181, 1);
  Color _lightBlack = const Color.fromRGBO(0, 0, 0, 0.88);
  Color _transparent = Colors.transparent;

  late Color primary1Color;
  late Color primary2Color;
  late Color primary3Color;

  late Color secondary1Color;
  late Color secondary2Color;

  late Color default1Color;
  late Color default2Color;
  late Color default3Color;
  late Color default4Color;
  late Color default5Color;
  late Color default6Color;
  late Color default7Color;
  late Color default8Color;
  late Color default9Color;
  late Color default10Color;
  late Color default11Color;
  late Color default12Color;
  late Color defaultColorBlack;
  late Color greyColor1;
  late Color greyTextColor;
  late Color dividerColor;
  late Color textColor;
  late Color greyButtonColor;

  late Color greyBackgroundColor;
  late Color whiteBackgroundColor;
  late Color dividerColors;
  late Color yellow;
  late Color red;
  late Color green;
  late Color circleColor;
  late Color textColor1;
  late Color gradiantColor1;
  late Color gradiantColor2;
  late Color unSelectedIconColor;
  late Color transparent;
  late Color lightBlack;

  void loadColor(bool isLightMode) {
    if (isLightMode) {
      loadLight();
    } else {
      loadDark();
    }
  }

  void loadLight() {
    whiteBackgroundColor = _whiteBackgroundColor;
    greyBackgroundColor = _greyBackgroundColor;
    primary1Color = _primaryColor;
    primary2Color = _primaryColor.withOpacity(0.50);
    primary3Color = _primaryColor.withOpacity(0.41);
    secondary1Color = _secondaryColor;
    secondary2Color = _secondaryColor.withOpacity(0.50);
    default1Color = _defaultColor;
    default2Color = _defaultColor.withOpacity(0.70);
    default3Color = _defaultColor.withOpacity(0.60);
    default4Color = _defaultColor.withOpacity(0.41);
    default5Color = _defaultColor.withOpacity(0.30);
    default6Color = _defaultColor.withOpacity(0.17);
    default7Color = _defaultColor.withOpacity(0.14);
    default8Color = _defaultColor.withOpacity(0.11);
    default9Color = _defaultColor.withOpacity(0.08);
    default10Color = _defaultColor.withOpacity(0.06);
    default11Color = _defaultColor.withOpacity(0.05);
    default12Color = _defaultColor.withOpacity(0.95);
    greyColor1 = _greyColor1;
    greyTextColor = _greyTextColor;
    dividerColor = _dividerColor;
    textColor = _textColor;
    greyButtonColor = _greyButtonColor;
    greyColor1 = _greyColor1;
    greyTextColor = _greyTextColor;
    dividerColor = _dividerColor;
    textColor = _textColor;
    dividerColors = _dividerColors;
    yellow = _yellow;
    red = _red;
    green = _green;
    circleColor = _circleColor;
    textColor1 = _textColor1;
    gradiantColor1 = _gradiantColor1;
    gradiantColor2 = _gradiantColor2;
    unSelectedIconColor = _unSelectedIconColor;
    transparent = _transparent;
    lightBlack = _lightBlack;
  }

  void loadDark() {
    whiteBackgroundColor = _whiteBackgroundColor;
    greyBackgroundColor = _greyBackgroundColor;
    primary1Color = _primaryColor;
    primary2Color = _primaryColor.withOpacity(0.50);
    primary3Color = _primaryColor.withOpacity(0.41);
    secondary1Color = _secondaryColor;
    secondary2Color = _secondaryColor.withOpacity(0.50);
    default1Color = _defaultColor;
    default2Color = _defaultColor.withOpacity(0.70);
    default3Color = _defaultColor.withOpacity(0.60);
    default4Color = _defaultColor.withOpacity(0.41);
    default5Color = _defaultColor.withOpacity(0.30);
    default6Color = _defaultColor.withOpacity(0.17);
    default7Color = _defaultColor.withOpacity(0.14);
    default8Color = _defaultColor.withOpacity(0.11);
    default9Color = _defaultColor.withOpacity(0.08);
    default10Color = _defaultColor.withOpacity(0.06);
    default11Color = _defaultColor.withOpacity(0.05);
    default12Color = _defaultColor.withOpacity(0.95);
    greyColor1 = _greyColor1;
    greyTextColor = _greyTextColor;
    dividerColor = _dividerColor;
    textColor = _textColor;
    greyButtonColor = _greyButtonColor;
    greyColor1 = _greyColor1;
    greyTextColor = _greyTextColor;
    dividerColor = _dividerColor;
    textColor = _textColor;
    dividerColors = _dividerColors;
    yellow = _yellow;
    red = _red;
    green = _green;
    circleColor = _circleColor;
    textColor1 = _textColor1;
    gradiantColor1 = _gradiantColor1;
    gradiantColor2 = _gradiantColor2;
    unSelectedIconColor = _unSelectedIconColor;
    transparent = _transparent;
    lightBlack = _lightBlack;
  }
}
