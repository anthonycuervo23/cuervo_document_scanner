// ignore_for_file: prefer_const_constructors

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_status/order_status_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OrderStatusWidget extends State<OrderStatusScreen> {
  String orderID = "mnhyt00125";
  Widget orderCopyId({
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.sizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(
              top: 5.h,
              bottom: 5.h,
            ),
            child: Container(
              height: 40.h,
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              decoration: BoxDecoration(
                color: appConstants.textFiledColor,
                border: Border.all(color: appConstants.default6Color),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.order_ID.translate(context),
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color),
                  ),
                  CommonWidget.sizedBox(width: 1),
                  CommonWidget.commonText(
                    text: "mnhyt00125",
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.primary1Color),
                  ),
                  Spacer(),
                  CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/order_status_screen/order_id_copy_code.svg",
                    iconSize: 15.sp,
                    color: appConstants.default1Color,
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: orderID,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderTimelineWidget({
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.time_line.translate(context),
          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
        ),
        CommonWidget.sizedBox(height: 10),
        Row(
          children: [
            timeLineIcons(),
            orderProcessed(context),
          ],
        ),
      ],
    );
  }

  Widget timeLineIcons() {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: CommonWidget.sizedBox(
        width: 60,
        child: Column(
          children: [
            commonTimeLineIcon(
              iconColor: appConstants.whiteBackgroundColor,
              imagePath: "assets/photos/svg/order_status_screen/order_confrimed.svg",
              color: appConstants.oStatus1Color,
              isDoted: true,
            ),
            commonTimeLineIcon(
              iconColor: appConstants.whiteBackgroundColor,
              imagePath: "assets/photos/svg/order_status_screen/order_processed.svg",
              color: appConstants.oStatus2Color,
              isDoted: true,
            ),
            commonTimeLineIcon(
              iconColor: appConstants.whiteBackgroundColor,
              imagePath: "assets/photos/svg/order_status_screen/out_for_deliver.svg",
              color: appConstants.oStatus3Color,
              isDoted: true,
            ),
            commonTimeLineIcon(
              iconColor: appConstants.whiteBackgroundColor,
              imagePath: "assets/photos/svg/order_status_screen/order_delivered.svg",
              color: appConstants.oStatus4Color,
              isDoted: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget orderProcessed(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          commonTile(
            context,
            title: TranslationConstants.order_confirmed.translate(context),
            oderTime: "04:35 pm, 05 Sep 2023",
            time: "04:35 pm",
          ),
          commonTile(
            context,
            title: TranslationConstants.order_processed.translate(context),
            oderTime: TranslationConstants.order_getting_ready.translate(context),
            time: "04:35 pm",
          ),
          commonTile(
            context,
            title: TranslationConstants.out_for_deliver.translate(context),
            oderTime: TranslationConstants.order_already_away.translate(context),
            time: "04:35 pm",
          ),
          commonTile(
            context,
            title: TranslationConstants.delivered.translate(context),
            oderTime: TranslationConstants.order_is_your_door.translate(context),
            time: "04:35 pm",
          ),
        ],
      ),
    );
  }

  Widget commonTile(BuildContext context, {required title, required oderTime, required time}) {
    return CommonWidget.sizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: title,
            style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: oderTime,
                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default5Color),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.commonText(
                  text: time,
                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget commonTimeLineIcon({
    required String imagePath,
    required Color? color,
    required Color? iconColor,
    required bool isDoted,
  }) {
    return CommonWidget.sizedBox(
      height: 80,
      child: Column(
        children: [
          Container(
            height: 45.h,
            width: 45.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CommonWidget.imageBuilder(
                imageUrl: imagePath,
                height: 20.h,
                color: iconColor,
              ),
            ),
          ),
          Visibility(
            visible: isDoted,
            child: Expanded(
              child: commonVerticalDashLine(
                fontWeight: FontWeight.bold,
                fontSize: 5.sp,
                color: appConstants.default1Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonVerticalDashLine({
    double? fontSize,
    double? height,
    double? width,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return CommonWidget.sizedBox(
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => CommonWidget.commonText(
          text: " |",
          textAlign: TextAlign.center,
          fontWeight: fontWeight ?? FontWeight.w100,
          color: color ?? appConstants.default1Color,
          fontSize: fontSize ?? 16.sp,
          bold: true,
        ),
      ),
    );
  }
}
