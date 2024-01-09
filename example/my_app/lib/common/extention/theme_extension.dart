import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeTextExtentions on TextTheme {
// H1

  TextStyle get h1BoldHeading => (getFontFamily(font: fonts?.h1.boldHeading.fontFamily) ?? displayLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h1.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.h1.boldHeading.fontSize.sp ?? 48.sp,
      );

  TextStyle get h1MediumHeading => (getFontFamily(font: fonts?.h1.mediumHeading.fontFamily) ?? displayLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h1.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.h1.mediumHeading.fontSize.sp ?? 48.sp,
      );

  TextStyle get h1BookHeading => (getFontFamily(font: fonts?.h1.bookHeading.fontFamily) ?? displayLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h1.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.h1.bookHeading.fontSize.sp ?? 48.sp,
      );

// H2

  TextStyle get h2BoldHeading => (getFontFamily(font: fonts?.h2.boldHeading.fontFamily) ?? displayMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h2.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.h2.boldHeading.fontSize.sp ?? 40.sp,
      );

  TextStyle get h2MediumHeading => (getFontFamily(font: fonts?.h2.mediumHeading.fontFamily) ?? displayMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h2.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.h2.mediumHeading.fontSize.sp ?? 40.sp,
      );

  TextStyle get h2BookHeading => (getFontFamily(font: fonts?.h2.bookHeading.fontFamily) ?? displayMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h2.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.h2.bookHeading.fontSize.sp ?? 40.sp,
      );

// H3

  TextStyle get h3BoldHeading => (getFontFamily(font: fonts?.h3.boldHeading.fontFamily) ?? displaySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h3.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.h3.boldHeading.fontSize.sp ?? 33.sp,
      );

  TextStyle get h3MediumHeading => (getFontFamily(font: fonts?.h3.mediumHeading.fontFamily) ?? displaySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h3.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.h3.mediumHeading.fontSize.sp ?? 33.sp,
      );

  TextStyle get h3BookHeading => (getFontFamily(font: fonts?.h3.bookHeading.fontFamily) ?? displaySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h3.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.h3.bookHeading.fontSize.sp ?? 33.sp,
      );

// H4

  TextStyle get h4BoldHeading => (getFontFamily(font: fonts?.h4.boldHeading.fontFamily) ?? headlineMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h4.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.h4.boldHeading.fontSize.sp ?? 28.sp,
      );

  TextStyle get h4MediumHeading =>
      (getFontFamily(font: fonts?.h4.mediumHeading.fontFamily) ?? headlineMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h4.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.h4.mediumHeading.fontSize.sp ?? 28.sp,
      );

  TextStyle get h4BookHeading => (getFontFamily(font: fonts?.h4.bookHeading.fontFamily) ?? headlineMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.h4.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.h4.bookHeading.fontSize.sp ?? 28.sp,
      );

// subTitle1

  TextStyle get subTitle1BoldHeading =>
      (getFontFamily(font: fonts?.subTitle1.boldHeading.fontFamily) ?? titleMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle1.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.subTitle1.boldHeading.fontSize.sp ?? 23.sp,
      );

  TextStyle get subTitle1MediumHeading =>
      (getFontFamily(font: fonts?.subTitle1.mediumHeading.fontFamily) ?? titleMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle1.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.subTitle1.mediumHeading.fontSize.sp ?? 23.sp,
      );

  TextStyle get subTitle1BookHeading =>
      (getFontFamily(font: fonts?.subTitle1.bookHeading.fontFamily) ?? titleMedium)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle1.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.subTitle1.bookHeading.fontSize.sp ?? 23.sp,
      );

// subTitle2

  TextStyle get subTitle2BoldHeading =>
      (getFontFamily(font: fonts?.subTitle2.boldHeading.fontFamily) ?? titleSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle2.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.subTitle2.boldHeading.fontSize.sp ?? 19.sp,
        // height: 22.h,
      );

  TextStyle get subTitle2MediumHeading =>
      (getFontFamily(font: fonts?.subTitle2.mediumHeading.fontFamily) ?? titleSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle2.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.subTitle2.mediumHeading.fontSize.sp ?? 19.sp,
      );

  TextStyle get subTitle2BookHeading =>
      (getFontFamily(font: fonts?.subTitle2.bookHeading.fontFamily) ?? titleSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle2.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.subTitle2.bookHeading.fontSize.sp ?? 19.sp,
      );

  TextStyle get subTitle2LightHeading =>
      (getFontFamily(font: fonts?.subTitle2.lightHeading.fontFamily) ?? titleSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.subTitle2.lightHeading.fontWeight) ?? FontWeight.w300,
        fontSize: fonts?.subTitle2.lightHeading.fontSize.sp ?? 19.sp,
      );

// body

  TextStyle get bodyBoldHeading => (getFontFamily(font: fonts?.body.boldHeading.fontFamily) ?? bodyLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.body.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.body.boldHeading.fontSize.sp ?? 16.sp,
      );

  TextStyle get bodyMediumHeading => (getFontFamily(font: fonts?.body.mediumHeading.fontFamily) ?? bodyLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.body.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.body.mediumHeading.fontSize.sp ?? 16.sp,
      );

  TextStyle get bodyBookHeading => (getFontFamily(font: fonts?.body.bookHeading.fontFamily) ?? bodyLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.body.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.body.bookHeading.fontSize.sp ?? 16.sp,
      );

  TextStyle get bodyLightHeading => (getFontFamily(font: fonts?.body.lightHeading.fontFamily) ?? bodyLarge)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.body.lightHeading.fontWeight) ?? FontWeight.w300,
        fontSize: fonts?.body.lightHeading.fontSize.sp ?? 16.sp,
      );

// caption

  TextStyle get captionBoldHeading =>
      (getFontFamily(font: fonts?.caption.boldHeading.fontFamily) ?? bodySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.caption.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.caption.boldHeading.fontSize.sp ?? 13.sp,
      );

  TextStyle get captionMediumHeading =>
      (getFontFamily(font: fonts?.caption.mediumHeading.fontFamily) ?? bodySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.caption.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.caption.mediumHeading.fontSize.sp ?? 13.sp,
      );

  TextStyle get captionBookHeading =>
      (getFontFamily(font: fonts?.caption.bookHeading.fontFamily) ?? bodySmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.caption.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.caption.bookHeading.fontSize.sp ?? 13.sp,
      );

// overLine

  TextStyle get overLineBoldHeading =>
      (getFontFamily(font: fonts?.overline.boldHeading.fontFamily) ?? labelSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.overline.boldHeading.fontWeight) ?? FontWeight.w700,
        fontSize: fonts?.overline.boldHeading.fontSize.sp ?? 11.sp,
      );

  TextStyle get overLineMediumHeading =>
      (getFontFamily(font: fonts?.overline.mediumHeading.fontFamily) ?? labelSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.overline.mediumHeading.fontWeight) ?? FontWeight.w500,
        fontSize: fonts?.overline.mediumHeading.fontSize.sp ?? 11.sp,
      );

  TextStyle get overLineBookHeading =>
      (getFontFamily(font: fonts?.overline.bookHeading.fontFamily) ?? labelSmall)!.copyWith(
        color: appConstants.default1Color,
        fontWeight: getFontWeight(fonts?.overline.bookHeading.fontWeight) ?? FontWeight.w400,
        fontSize: fonts?.overline.bookHeading.fontSize.sp ?? 11.sp,
      );
//
}

TextStyle? getFontFamily({String? font}) {
  try {
    if (font != null) {
      if (font == 'Circular Std') {
        return null;
      }
      return GoogleFonts.getFont(font);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }

  return null;
}

FontWeight? getFontWeight(int? condition) {
  switch (condition) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;

    default:
      return null;
  }
}
