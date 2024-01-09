// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:bakery_shop_flutter/global.dart';
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
  IconThemeData appIconThemeData = IconThemeData(size: 26);

  String loctionApiKey = 'AIzaSyA6vKEF9G12zSbgsJBcTxUVXvGzlnBnMJ4';

  double buttonRadius = accountInfoEntity?.appSetting.buttonRadius ?? 12;
  double prductCardRadius = accountInfoEntity?.appSetting.productCardRadius ?? 10;

  Color _defaultColor = Color((int.parse('0xff${accountInfoEntity?.appSetting.secondaryColor ?? '222222'}')));
  Color _primaryColor = Color((int.parse('0xff${accountInfoEntity?.appSetting.primaryColor ?? 'B75400'}')));
  Color _secondaryColor = Color((int.parse('0xff${'FFDDC0'}')));
  Color _buttonTextColor = Color((int.parse('0xff${'FFFFFF'}')));
  Color _greenColor = Color((int.parse('0xff${'0EAC3B'}')));
  Color _whiteBackgroundColor = Color((int.parse('0xff${'FFFFFF'}')));
  Color _greyBackgroundColor = Color((int.parse('0xff${'F4F4F4'}')));
  Color _requiredColor = Color((int.parse('0xff${'FF5252'}')));
  Color _profilePhoneColor = Color((int.parse('0xff${'1573FF'}')));
  Color _profileEmailColor = Color((int.parse('0xff${'FF4D4D'}')));
  Color _profileDobColor = Color((int.parse('0xff${'EC9C00'}')));
  Color _profileAnniversaryColor = Color((int.parse('0xff${'8D33FF'}')));
  Color _profileAddressColor = Color((int.parse('0xff${'FF1C52'}')));
  Color _vegColor = Color((int.parse('0xff${'0EAC3B'}')));
  Color _nonVegColor = Color((int.parse('0xff${'FF4329'}')));
  Color _starRateColor = Color((int.parse('0xff${'FFB13B'}')));
  Color _notificationColor = Color((int.parse('0xff${'FF4D4D'}')));
  Color _likeColor = Color((int.parse('0xff${'FF4D4D'}')));
  Color _unlikeColor = Color((int.parse('0xff${'FFFFFF'}')));
  Color _bestSellerColor = Color((int.parse('0xff${'EC9C00'}')));
  Color _textFiledColor = Color((int.parse('0xff${'FFFFFF'}')));
  Color _oStatus1Color = Color((int.parse('0xff${'0EAC3B'}')));
  Color _oStatus2Color = Color((int.parse('0xff${'EC9C00'}')));
  Color _oStatus3Color = Color((int.parse('0xff${'FF4C4C'}')));
  Color _oStatus4Color = Color((int.parse('0xff${'1573FF'}')));

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

  late Color greyBackgroundColor;
  late Color whiteBackgroundColor;
  late Color buttonTextColor;
  late Color green1Color;
  late Color green2Color;
  late Color profilePhone1Color;
  late Color profilePhone2Color;
  late Color profileEmail1Color;
  late Color profileEmail2Color;
  late Color profileDob1Color;
  late Color profileDob2Color;
  late Color profileAnniversary1Color;
  late Color profileAnniversary2Color;
  late Color profileAddress1Color;
  late Color profileAddress2Color;
  late Color vegColor;
  late Color nonVegColor;
  late Color starRateColor;
  late Color notificationColor;
  late Color likeColor;
  late Color unlikeColor;
  late Color bestSeller1Color;
  late Color bestSeller2Color;
  late Color requiredColor;
  late Color textFiledColor;

  late Color oStatus1Color;
  late Color oStatus2Color;
  late Color oStatus3Color;
  late Color oStatus4Color;

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
    green1Color = _greenColor;
    green2Color = _greenColor.withOpacity(0.2);
    buttonTextColor = _buttonTextColor;
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
    requiredColor = _requiredColor;
    profilePhone1Color = _profilePhoneColor;
    profilePhone2Color = _profilePhoneColor.withOpacity(0.11);
    profileEmail1Color = _profileEmailColor;
    profileEmail2Color = _profileEmailColor.withOpacity(0.11);
    profileDob1Color = _profileDobColor;
    profileDob2Color = _profileDobColor.withOpacity(0.11);
    profileAnniversary1Color = _profileAnniversaryColor;
    profileAnniversary2Color = _profileAnniversaryColor.withOpacity(0.11);
    profileAddress1Color = _profileAddressColor;
    profileAddress2Color = _profileAddressColor.withOpacity(0.11);
    vegColor = _vegColor;
    nonVegColor = _nonVegColor;
    starRateColor = _starRateColor;
    notificationColor = _notificationColor;
    likeColor = _likeColor;
    unlikeColor = _unlikeColor;
    bestSeller1Color = _bestSellerColor;
    bestSeller2Color = _bestSellerColor.withOpacity(0.11);
    textFiledColor = _textFiledColor;
    oStatus1Color = _oStatus1Color;
    oStatus2Color = _oStatus2Color;
    oStatus3Color = _oStatus3Color;
    oStatus4Color = _oStatus4Color;
  }

  void loadDark() {
    whiteBackgroundColor = _whiteBackgroundColor;
    greyBackgroundColor = _greyBackgroundColor;
    primary1Color = _primaryColor;
    primary2Color = _primaryColor.withOpacity(0.50);
    primary3Color = _primaryColor.withOpacity(0.41);
    secondary1Color = _secondaryColor;
    secondary2Color = _secondaryColor.withOpacity(0.50);
    green1Color = _greenColor;
    green2Color = _greenColor.withOpacity(0.2);
    buttonTextColor = _buttonTextColor;
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
    requiredColor = _requiredColor;
    profilePhone1Color = _profilePhoneColor;
    profilePhone2Color = _profilePhoneColor.withOpacity(0.11);
    profileEmail1Color = _profileEmailColor;
    profileEmail2Color = _profileEmailColor.withOpacity(0.11);
    profileDob1Color = _profileDobColor;
    profileDob2Color = _profileDobColor.withOpacity(0.11);
    profileAnniversary1Color = _profileAnniversaryColor;
    profileAnniversary2Color = _profileAnniversaryColor.withOpacity(0.11);
    profileAddress1Color = _profileAddressColor;
    profileAddress2Color = _profileAddressColor.withOpacity(0.11);
    vegColor = _vegColor;
    nonVegColor = _nonVegColor;
    starRateColor = _starRateColor;
    notificationColor = _notificationColor;
    likeColor = _likeColor;
    unlikeColor = _unlikeColor;
    bestSeller1Color = _bestSellerColor;
    bestSeller2Color = _bestSellerColor.withOpacity(0.11);
    textFiledColor = _textFiledColor;
    oStatus1Color = _oStatus1Color;
    oStatus2Color = _oStatus2Color;
    oStatus3Color = _oStatus3Color;
    oStatus4Color = _oStatus4Color;
  }
}
