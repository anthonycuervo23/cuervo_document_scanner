import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/player_info/presentation/pages/player_info_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class PlayerInfoWidget extends State<PlayerInfoScreen> {
  List<String> detail = ['Virat Kohli', '05 Nov 1988', 'Batter', 'Right Handed Bat', 'Right Arm Fast Medium'];

  Widget profileImage() {
    return Center(
      child: Container(
        color: appConstants.whiteBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CircleAvatar(
                radius: 40.r,
                backgroundImage: const NetworkImage(
                  'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcR1h65X6WJgJLQX__Ji0g_l7lykHKgX2h9afpJHIvey6H-7-4S_ZYWAdW9LcbZ47tVFbEBpo46kWm0huBs',
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: 'Virat Kohli ',
                  fontSize: 18,
                  bold: true,
                ),
                CommonWidget.commonText(
                  text: '(Batter)',
                  fontSize: 14.sp,
                  color: appConstants.greyTextColor,
                ),
              ],
            ),
            CommonWidget.commonText(
              text: 'India . 35 yrs',
              fontSize: 12.sp,
              color: appConstants.greyTextColor,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget personalInformation() {
    List<String> title = [
      TranslationConstants.full_name.translate(context),
      TranslationConstants.birth.translate(context),
      TranslationConstants.role.translate(context),
      TranslationConstants.batting_style.translate(context),
      TranslationConstants.bowling_style.translate(context),
    ];
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: CommonWidget.commonText(
                    text: title[index],
                    color: appConstants.greyTextColor,
                    bold: true,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: CommonWidget.commonText(
                    text: detail[index],
                    bold: true,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget teamPlayedFor() {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10.r,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Wrap(
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonWidget.container(
              borderRadius: 20.sp,
              height: 40,
              width: 90,
              alignment: Alignment.center,
              color: appConstants.greyButtonColor,
              child: CommonWidget.commonText(
                text: 'lorem',
                fontSize: 14,
                color: appConstants.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleText({
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CommonWidget.commonPoint(),
          CommonWidget.sizedBox(width: 5),
          CommonWidget.commonText(
            text: text,
            bold: true,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget battingCareerStatics() {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 35.w, child: CommonWidget.commonText(text: 'LPL', bold: true)),
                CommonWidget.commonText(text: 'T1OI', bold: true),
                CommonWidget.commonText(text: 'ODI', bold: true),
                CommonWidget.commonText(text: 'ADB T10', bold: true),
              ],
            ),
          ),
          Divider(color: appConstants.dividerColor, thickness: 0.8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '20', stats: TranslationConstants.mathes.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.runs.translate(context), width: 50.w),
              commonStaticsText(title: '20', stats: TranslationConstants.innings.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.balls.translate(context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '20', stats: TranslationConstants.high_score.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.century.translate(context), width: 50.w),
              commonStaticsText(title: '20', stats: TranslationConstants.fifty.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.average.translate(context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '20', stats: TranslationConstants.not_out.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.fours.translate(context), width: 50.w),
              commonStaticsText(title: '20', stats: TranslationConstants.sixes.translate(context)),
              commonStaticsText(title: '20', stats: TranslationConstants.strike_rate.translate(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget bowlingStaticsStats() {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 35.w, child: CommonWidget.commonText(text: 'LPL', bold: true)),
                CommonWidget.commonText(text: 'T1OI', bold: true),
                CommonWidget.commonText(text: 'ODI', bold: true),
                CommonWidget.commonText(text: 'ADB T10', bold: true),
              ],
            ),
          ),
          Divider(color: appConstants.dividerColor, thickness: 0.8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '20', stats: TranslationConstants.mathes.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.innings.translate(context), width: 50.w),
              commonStaticsText(title: '00', stats: TranslationConstants.wickets.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.economy.translate(context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '00', stats: TranslationConstants.balls.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.runs.translate(context), width: 50.w),
              commonStaticsText(title: '00', stats: TranslationConstants.average.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.bbi.translate(context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonStaticsText(title: '00', stats: TranslationConstants.bbm.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.five_wicket.translate(context), width: 50.w),
              commonStaticsText(title: '00', stats: TranslationConstants.ten_wickets.translate(context)),
              commonStaticsText(title: '00', stats: TranslationConstants.maidens.translate(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonStaticsText({
    required String title,
    required String stats,
    double? width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: width ?? 74.w,
        child: Column(
          children: [
            CommonWidget.commonText(
              text: title,
              color: appConstants.textColor,
              bold: true,
            ),
            CommonWidget.commonText(
              text: stats,
              color: appConstants.greyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
