import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonHomeWidget {
  static Widget commonScoreDetailBox({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage("assets/svgs/home_screen/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CommonWidget.container(
                height: 20.h,
                width: 50.w,
                borderRadius: 10.r,
                color: appConstants.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.circle_outlined, size: 10, color: Colors.white),
                    CommonWidget.commonText(
                      text: TranslationConstants.live.translate(context),
                      fontSize: 10,
                      color: appConstants.whiteBackgroundColor,
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),
            CommonWidget.sizedBox(height: 8),
            CommonWidget.commonText(
              text: "Pakistan tour of Audtalia,3rd Test Match",
              fontSize: 15,
              color: appConstants.whiteBackgroundColor,
              bold: true,
            ),
            CommonWidget.sizedBox(height: 8),
            CommonWidget.commonText(
              text: "Wed, 03 Jan - 06:00 AM",
              fontSize: 12,
              color: appConstants.whiteBackgroundColor,
            ),
            CommonWidget.sizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: commonflagbox(
                      image: 'https://upload.wikimedia.org/wikipedia/en/4/41/Flag_of_India.svg',
                      run: '313',
                      wicket: '10',
                      over: '77.1',
                      country: 'IND',
                      context: context,
                    ),
                  ),
                  CommonWidget.commonText(
                    text: "VS",
                    fontSize: 30,
                    color: appConstants.yellow,
                  ),
                  Expanded(
                    child: commonflagbox(
                        image:
                            'https://upload.wikimedia.org/wikipedia/commons/8/88/Flag_of_Australia_%28converted%29.svg',
                        run: '313',
                        wicket: '10',
                        over: '77.1',
                        country: 'AUS',
                        context: context),
                  ),
                ],
              ),
            ),
            CommonWidget.sizedBox(height: 8),
            CommonWidget.commonText(
              text: "Pakistan is leading by 14 runs",
              fontSize: 14,
              color: appConstants.whiteBackgroundColor,
            ),
            CommonWidget.sizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static commonflagbox({
    required String image,
    required String run,
    required String wicket,
    required String over,
    required String country,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              height: 32.r,
              width: 32.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CommonWidget.imageBuilder(
                  imageUrl: image,
                  height: 32.r,
                  width: 32.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonWidget.commonText(
                text: country,
                fontSize: 13,
                color: appConstants.whiteBackgroundColor,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: appConstants.whiteBackgroundColor,
                    fontSize: 12.sp,
                  ),
                  children: [
                    TextSpan(text: run),
                    const TextSpan(text: "-"),
                    TextSpan(text: wicket),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: appConstants.whiteBackgroundColor, fontSize: 12.sp),
                  children: [
                    TextSpan(text: over),
                    TextSpan(
                      text: TranslationConstants.overs.translate(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
