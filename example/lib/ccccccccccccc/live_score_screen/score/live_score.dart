import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

List overrun = [
  "W",
  "0",
  "0",
  "6",
  "2",
  "0",
  "W",
  "0",
  "0",
  "6",
  "2",
  "0",
  "W",
  "0",
  "0",
  "6",
  "2",
  "0",
  "W",
  "0",
  "0",
  "6",
  "2",
  "0",
];

Widget tvLiveDetails({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          "assets/svgs/livescore_icon/tv.svg",
          height: 220.h,
        ),
        Positioned(
          right: 10.w,
          top: 14.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonWidget.container(
                height: 20.h,
                width: 50.w,
                borderRadius: 10.r,
                color: appConstants.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      size: 10,
                      color: appConstants.whiteBackgroundColor,
                    ),
                    CommonWidget.commonText(
                      text: TranslationConstants.live.translate(context),
                      fontSize: 10,
                      color: appConstants.whiteBackgroundColor,
                      bold: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 25.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: "1 Run",
                fontSize: 19.sp,
                color: appConstants.whiteBackgroundColor,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 26.h,
          top: 158.h,
          left: 0,
          right: 0,
          child: CommonWidget.container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: appConstants.whiteBackgroundColor,
            borderRadius: 3.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                fullScore(
                  over: "14.0",
                  teamname: 'PAK',
                  run: '52',
                  wkt: '2',
                ),
                fullScore(
                  over: "19.0",
                  teamname: 'IND',
                  run: '202',
                  wkt: '10',
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget batterScore({required BuildContext context}) {
  return BlocBuilder<ToggleCubit, bool>(
    builder: (context, state) {
      return CommonWidget.container(
        padding: EdgeInsets.all(5.r),
        margin: EdgeInsets.all(10.r),
        color: appConstants.whiteBackgroundColor,
        borderRadius: 15.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            betterTitleText(context),
            Divider(thickness: 0.8, color: appConstants.dividerColors),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CommonWidget.commonText(text: "Babar Azam "),
                          ),
                        ),
                      ),
                      CommonWidget.sizedBox(width: 50, child: CommonWidget.commonText(text: "21")),
                      CommonWidget.sizedBox(
                        width: 40,
                        child: CommonWidget.commonText(
                          text: "46",
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.sizedBox(
                        width: 40,
                        child: CommonWidget.commonText(
                          text: "1",
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.sizedBox(
                        width: 40,
                        child: CommonWidget.commonText(
                          text: "0",
                          color: appConstants.greyTextColor,
                        ),
                      ),
                      CommonWidget.sizedBox(
                        width: 40,
                        child: CommonWidget.commonText(
                          text: "45.46",
                          color: appConstants.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(thickness: 0.8, color: appConstants.dividerColors),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonWidget.commonText(text: "P”ship:"),
                  ),
                  CommonWidget.sizedBox(width: 30, child: CommonWidget.commonText(text: "0(0) ")),
                  CommonWidget.sizedBox(width: 70),
                  CommonWidget.sizedBox(width: 50, child: CommonWidget.commonText(text: "L’WKT:")),
                  CommonWidget.sizedBox(width: 50, child: CommonWidget.commonText(text: "S.Ayub ")),
                  CommonWidget.sizedBox(width: 50, child: CommonWidget.commonText(text: "33(53)")),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget betterTitleText(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(text: TranslationConstants.batter.translate(context)),
          ),
        ),
        CommonWidget.sizedBox(
          width: 50,
          child: CommonWidget.commonText(
            text: TranslationConstants.r.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.b.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.fors.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.sixs.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.sr.translate(context),
          ),
        ),
      ],
    ),
  );
}

Widget bowlerScore({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.all(5.r),
    margin: EdgeInsets.all(10.r),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bowlerTitleText(context),
        Divider(
          thickness: 0.8,
          color: appConstants.dividerColors,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CommonWidget.commonText(text: "Lorem Page"),
                  ),
                ),
              ),
              CommonWidget.sizedBox(width: 50, child: CommonWidget.commonText(text: "2")),
              CommonWidget.sizedBox(
                width: 40,
                child: CommonWidget.commonText(
                  text: "50",
                  color: appConstants.textColor1,
                ),
              ),
              CommonWidget.sizedBox(
                width: 40,
                child: CommonWidget.commonText(
                  text: "2",
                  color: appConstants.textColor1,
                ),
              ),
              CommonWidget.sizedBox(
                width: 70,
                child: CommonWidget.commonText(
                  text: "0.2",
                  color: appConstants.textColor1,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bowlerTitleText(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(
              text: TranslationConstants.bowler.translate(context),
            ),
          ),
        ),
        CommonWidget.sizedBox(
          width: 50,
          child: CommonWidget.commonText(
            text: TranslationConstants.o.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.r.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 40,
          child: CommonWidget.commonText(
            text: TranslationConstants.wkt.translate(context),
          ),
        ),
        CommonWidget.sizedBox(
          width: 70,
          child: CommonWidget.commonText(
            text: TranslationConstants.eco.translate(context),
          ),
        ),
      ],
    ),
  );
}

Widget yetToBatplayerList({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.all(5.r),
    margin: EdgeInsets.all(10.r),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.commonText(text: TranslationConstants.yet_to_bat.translate(context)),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.8, color: appConstants.dividerColors),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: CommonWidget.commonText(
            text: "Mohammad Rizwan , Agha Salman, Asmar Jamal, Sazid Khan, Hasan Ali, Mir Hamza",
            textAlign: TextAlign.start,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}

Widget lastOverData({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.all(5.r),
    margin: EdgeInsets.all(10.r),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.commonText(
                    text: "Last 24 Balls",
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 0.8, color: appConstants.dividerColors),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CommonWidget.container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  color: appConstants.greyColor1,
                  alignment: Alignment.center,
                  borderRadius: 20.r,
                  child: CommonWidget.commonText(text: "Over - 1"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    overrun.length,
                    (index) => Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: CommonWidget.commonText(
                            text: "${overrun[index]}",
                            color: overrun[index] == "W"
                                ? appConstants.red
                                : overrun[index] == "6" || overrun[index] == "2" || overrun[index] == "4"
                                    ? appConstants.green
                                    : appConstants.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget fullScore({
  required String teamname,
  required String run,
  required String over,
  required String wkt,
}) {
  return Row(
    children: [
      CommonWidget.commonText(text: teamname),
      CommonWidget.sizedBox(width: 5),
      CommonWidget.commonText(text: "$run -"),
      CommonWidget.sizedBox(width: 5),
      CommonWidget.commonText(text: wkt),
      CommonWidget.sizedBox(width: 5),
      CommonWidget.commonText(text: "($over)"),
    ],
  );
}
