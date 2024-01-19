import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool team1Card = false;
bool team2Card = false;
int itemCount = 10;

Widget scoreCard({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: Column(
      children: [
        batterScoreCard(context: context),
        bowlerScoreCard(context: context),
        fallOfWickets(context: context),
      ],
    ),
  );
}

Widget batterScoreCard({required BuildContext context}) {
  return CommonWidget.container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.symmetric(vertical: 10.w),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 10.r,
    child: Column(
      children: [
        Row(
          children: [
            CommonWidget.sizedBox(width: 10.w),
            Expanded(
              child: CommonWidget.commonText(
                text: TranslationConstants.batter.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 30.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "R",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 40.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "B",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 35.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "4",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 35.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "6",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 45.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "S",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Divider(
            color: appConstants.dividerColor,
            thickness: 0.8,
            height: 20.h,
          ),
        ),
        ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
                        child: CommonWidget.commonText(
                          text: "David Warner",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "2",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "5",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "1",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "2",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "45.4",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Visibility(
                  visible: itemCount - 1 != index,
                  child: Divider(color: appConstants.dividerColor, thickness: 0.8),
                ),
                SizedBox(height: 2.h),
              ],
            );
          },
        ),
        Divider(color: appConstants.dividerColor, thickness: 0.2),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: CommonWidget.commonText(
                  text: "${TranslationConstants.extras.translate(context)} :",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: "2( 0 b, 1 lb, 0 wd, 1 nb, 0 p)",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bowlerScoreCard({required BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.symmetric(vertical: 10.w),
    decoration: BoxDecoration(
      color: appConstants.whiteBackgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          children: [
            CommonWidget.sizedBox(width: 10.w),
            Expanded(
              child: CommonWidget.commonText(
                text: TranslationConstants.bowler.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 30.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "O",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 40.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "M",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 35.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "R",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 35.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "W",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 45.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: "ER",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Divider(
            color: appConstants.dividerColor,
            thickness: 0.8,
            height: 20.h,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
                        child: CommonWidget.commonText(
                          text: "Shane Warne",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "16.0",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "2",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "75",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "2",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.container(
                        width: 35.w,
                        alignment: Alignment.center,
                        child: CommonWidget.commonText(
                          text: "4.46",
                          fontSize: 14,
                          color: appConstants.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Visibility(
                  visible: itemCount - 1 != index,
                  child: Divider(color: appConstants.dividerColor, thickness: 0.8),
                ),
                SizedBox(height: 2.h),
              ],
            );
          },
          itemCount: itemCount,
        ),
      ],
    ),
  );
}

Widget fallOfWickets({required BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
    decoration: BoxDecoration(
      color: appConstants.whiteBackgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CommonWidget.commonText(
                text: TranslationConstants.fall_of_wickets.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 75.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: TranslationConstants.scores.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.container(
              width: 75.w,
              alignment: Alignment.center,
              child: CommonWidget.commonText(
                text: TranslationConstants.overs.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Divider(color: appConstants.dividerColor, thickness: 0.8, height: 20.h),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
                        child: CommonWidget.commonText(
                          text: "David Warner",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CommonWidget.container(
                      width: 75.w,
                      alignment: Alignment.center,
                      child: CommonWidget.commonText(
                        text: "1/0",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appConstants.greyTextColor,
                      ),
                    ),
                    CommonWidget.container(
                      width: 75.w,
                      alignment: Alignment.center,
                      child: CommonWidget.commonText(
                        text: "0.2",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appConstants.greyTextColor,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: itemCount - 1 != index,
                  child: Divider(color: appConstants.dividerColor, thickness: 0.8, height: 10.h),
                ),
              ],
            );
          },
          itemCount: itemCount,
        ),
      ],
    ),
  );
}
