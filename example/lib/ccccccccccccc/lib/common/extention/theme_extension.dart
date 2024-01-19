import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

extension ThemeTextExtentions on TextTheme {
// H1

  TextStyle get h1BoldHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 60.sp);

  TextStyle get h1SemiboldHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 60.sp);

  TextStyle get h1MediumHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 60.sp);

  TextStyle get h1RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 60.sp);

// H2

  TextStyle get h2BoldHeading =>
      displayMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 48.sp);

  TextStyle get h2SemiboldHeading =>
      displayMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 48.sp);

  TextStyle get h2MediumHeading =>
      displayMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 48.sp);
  TextStyle get h2RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 48.sp);

// H3

  TextStyle get h3BoldHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 42.sp);

  TextStyle get h3SemiboldHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 42.sp);

  TextStyle get h3MediumHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 42.sp);

  TextStyle get h3RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 42.sp);

// H4

  TextStyle get h4BoldHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 40.sp);

  TextStyle get h4SemiboldHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 40.sp);

  TextStyle get h4MediumHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 40.sp);

  TextStyle get h4RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 40.sp);

// H5

  TextStyle get h5BoldHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 35.sp);

  TextStyle get h5SemiboldHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 35.sp);

  TextStyle get h5MediumHeading =>
      displaySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 35.sp);
  TextStyle get h5RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 35.sp);

// H6

  TextStyle get h6BoldHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 33.sp);

  TextStyle get h6SemiboldHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 33.sp);

  TextStyle get h6MediumHeading =>
      headlineMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 33.sp);

  TextStyle get h6RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 33.sp);

// subTitle1

  TextStyle get subTitle1BoldHeading =>
      titleMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 28.sp);

  TextStyle get subTitle1SemiboldHeading =>
      titleMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 28.sp);

  TextStyle get subTitle1MediumHeading =>
      titleMedium!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 28.sp);

  TextStyle get subTitle1RegularHeading =>
      (displayLarge)!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 28.sp);

// subTitle2

  TextStyle get subTitle2BoldHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 23.sp);

  TextStyle get subTitle2SemiboldHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 23.sp);

  TextStyle get subTitle2MediumHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 23.sp);

  TextStyle get subTitle2RegularHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 23.sp);

// subTitle3

  TextStyle get subTitle3BoldHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 19.sp);

  TextStyle get subTitle3SemiboldHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 19.sp);

  TextStyle get subTitle3MediumHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 19.sp);

  TextStyle get subTitle3RegularHeading =>
      titleSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 19.sp);

// body1

  TextStyle get body1BoldHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 16.sp);

  TextStyle get body1SemiboldHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 16.sp);

  TextStyle get body1MediumHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 16.sp);

  TextStyle get body1RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 16.sp);

  // body2

  TextStyle get body2BoldHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 14.sp);

  TextStyle get body2SemiboldHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 14.sp);

  TextStyle get body2MediumHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 14.sp);

  TextStyle get body2RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 14.sp);

// caption1

  TextStyle get caption1BoldHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 13.sp);

  TextStyle get caption1SemiboldHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 13.sp);

  TextStyle get caption1MediumHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 13.sp);

  TextStyle get caption1RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 13.sp);

// caption2

  TextStyle get caption2BoldHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 11.sp);

  TextStyle get caption2SemiboldHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 11.sp);

  TextStyle get caption2MediumHeading =>
      bodySmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 11.sp);

  TextStyle get caption2RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 11.sp);

// overLine1

  TextStyle get overLine1BoldHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 10.sp);

  TextStyle get overLine1SemiboldHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 10.sp);

  TextStyle get overLine1MediumHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 10.sp);

  TextStyle get overLine1RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 10.sp);

// overLine2

  TextStyle get overLine2BoldHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w700, fontSize: 8.sp);

  TextStyle get overLine2SemiboldHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w600, fontSize: 8.sp);

  TextStyle get overLine2MediumHeading =>
      labelSmall!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w500, fontSize: 8.sp);

  TextStyle get overLine2RegularHeading =>
      bodyLarge!.copyWith(color: appConstants.default1Color, fontWeight: FontWeight.w400, fontSize: 8.sp);
//
}
