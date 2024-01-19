import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget matchTitleContainer() {
  return CommonWidget.container(
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    padding: EdgeInsets.all(16.r),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: appConstants.primary1Color,
                    backgroundImage: const NetworkImage(
                      "https://img.freepik.com/free-vector/brush-stroke-style-indian-flag-theme-independence-day-background-vector_1055-10859.jpg",
                    ),
                  ),
                  CommonWidget.commonText(text: "IND", fontWeight: FontWeight.w500),
                ],
              ),
              CommonWidget.commonText(
                text: "VS",
                color: appConstants.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: appConstants.primary1Color,
                    backgroundImage:
                        const NetworkImage("https://cdn.britannica.com/78/6078-004-77AF7322/Flag-Australia.jpg"),
                  ),
                  CommonWidget.commonText(text: "AUS", fontWeight: FontWeight.w500),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget timeSchedule() {
  return CommonWidget.container(
    borderRadius: 15.r,
    color: appConstants.whiteBackgroundColor,
    padding: EdgeInsets.all(5.r),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTimeSchedule(
          image: "assets/svgs/livescore_icon/stickynote.svg",
          text: "Wed, 03, Jan, 05:00 AM at Your Time",
        ),
        Divider(thickness: 0.8, color: appConstants.dividerColors),
        commonTimeSchedule(
          image: "assets/svgs/livescore_icon/like.svg",
          text: "Pakistan apt to bet",
        ),
        Divider(thickness: 0.8, color: appConstants.dividerColors),
        commonTimeSchedule(
          image: "assets/svgs/livescore_icon/location.svg",
          text: "Sydney Cricket Ground, Sydney, Austalia",
        ),
      ],
    ),
  );
}

Widget commonTimeSchedule({
  required String image,
  required String text,
}) {
  return Padding(
    padding: EdgeInsets.only(right: 10.w, top: 8.h, left: 10.w),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: appConstants.greyColor1,
          child: CommonWidget.imageBuilder(
            imageUrl: image,
            height: 24.sp,
            color: appConstants.greyTextColor,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        CommonWidget.commonText(
          text: text,
          color: appConstants.textColor,
          maxLines: 3,
          fontSize: 15,
          textOverflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}

Widget commonTextAndBulletPoint({required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 5.w),
          child: CommonWidget.commonPoint(),
        ),
        CommonWidget.commonText(
          text: text,
          fontSize: 18,
          maxLines: 3,
          fontWeight: FontWeight.w600,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget teamSquads({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.all(5.r),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTeamSquadsList(text: "Australia", onTap: () => CommonRouter.pushNamed(RouteList.team_squads_screen)),
        Divider(thickness: 0.8, color: appConstants.dividerColors),
        commonTeamSquadsList(text: "Indian", onTap: () => CommonRouter.pushNamed(RouteList.team_squads_screen)),
      ],
    ),
  );
}

Widget commonTeamSquadsList({
  required String text,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18.r,
            color: appConstants.textColor,
          ),
        ],
      ),
    ),
  );
}

Widget umpiresDetails({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.all(16.r),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    color: appConstants.whiteBackgroundColor,
    borderRadius: 15.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(
                imageUrl: 'assets/png/live_score/umpires.png',
                height: 50.h,
              ),
              CommonWidget.sizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonumpiresDetails(
                      text: TranslationConstants.umpires.translate(context),
                      secondText: "Jael Wilsan, Richard Illingworth",
                    ),
                    CommonWidget.sizedBox(height: 10),
                    commonumpiresDetails(
                      text: TranslationConstants.third_umpires.translate(context),
                      secondText: "Michele Gough",
                    ),
                    CommonWidget.sizedBox(height: 10),
                    commonumpiresDetails(
                      text: TranslationConstants.referee.translate(context),
                      secondText: "Javagal Shrinath+",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget commonumpiresDetails({
  required String text,
  required String secondText,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: CommonWidget.commonText(
          text: text,
          color: appConstants.greyTextColor,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.start,
        ),
      ),
      Expanded(
        child: CommonWidget.commonText(
          text: secondText,
          fontWeight: FontWeight.w400,
          maxLines: 3,
          textAlign: TextAlign.start,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
