import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.robotoTextTheme();

  static TextStyle get _whiteHeadline5 =>
      _poppinsTextTheme.headlineSmall!.copyWith(fontSize: 24.sp, color: Colors.white, fontFamily: 'Calibri');
  static TextStyle get _whiteHeadline6 =>
      _poppinsTextTheme.titleLarge!.copyWith(fontSize: 20.sp, color: Colors.white, fontFamily: 'Calibri');
  static TextStyle get _whiteSubtitle1 =>
      _poppinsTextTheme.titleMedium!.copyWith(fontSize: 24.sp, color: Colors.white, fontFamily: 'Calibri');

  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyMedium!.copyWith(
        color: Colors.white,
        fontSize: 14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5.h,
        fontFamily: 'Calibri',
      );

  static TextStyle get whiteButton => _poppinsTextTheme.labelLarge!.copyWith(
        fontSize: 14.sp,
        color: Colors.white,
        fontFamily: 'Calibri',
      );

  static getTextTheme() => TextTheme(
        titleSmall: _whiteSubtitle1,
        titleMedium: _whiteSubtitle1,
        bodyMedium: _whiteBodyText2,
        headlineSmall: _whiteHeadline5,
        titleLarge: _whiteHeadline6,
        labelLarge: whiteButton,
      );

  static TextStyle? get _vulcanHeadline6 => _whiteHeadline6.copyWith(color: appConstants.primary1Color);

  static TextStyle? get _vulcanHeadline5 => _whiteHeadline5.copyWith(color: appConstants.primary1Color);

  static TextStyle? get vulcanSubtitle1 => _whiteSubtitle1.copyWith(color: appConstants.primary1Color);

  static TextStyle? get vulcanBodyText2 => _whiteBodyText2.copyWith(color: appConstants.primary1Color);

  static getLightTextTheme() => TextTheme(
        headlineSmall: _vulcanHeadline5,
        titleLarge: _vulcanHeadline6,
        titleMedium: vulcanSubtitle1,
        titleSmall: vulcanBodyText2,
        bodyMedium: vulcanBodyText2,
        labelLarge: whiteButton,
      );
}
