import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/my_reward_point_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_dashline.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class MyRewardPointWidget extends State<MyRewardPointScreen> {
  String couponCode = "ji32ungt21";
  Widget showTotalPointContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: DottedDecoration(
        shape: Shape.box,
        color: appConstants.primary1Color,
        borderRadius: BorderRadius.circular(10.r),
        dash: const <int>[7, 7],
        linePosition: LinePosition.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          totalPoints(),
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 15.h),
            child: CommonWidget.commonText(
              text: "10 ${TranslationConstants.refer_points.translate(context)} = ₹1",
              style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                totalPointsCommonButton(
                  bgColor: appConstants.secondary2Color,
                  texColor: appConstants.primary1Color,
                  onTap: () => transferNowPopup(),
                  text: TranslationConstants.transfer_now.translate(context),
                ),
                CommonWidget.sizedBox(width: 15),
                totalPointsCommonButton(
                  bgColor: appConstants.primary1Color,
                  texColor: appConstants.buttonTextColor,
                  onTap: () => CommonRouter.pushNamed(RouteList.reward_coupon_screen),
                  text: TranslationConstants.reedem_now.translate(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///commonButton Treansfer && Redeem Now
  Widget totalPointsCommonButton({
    required String text,
    required VoidCallback onTap,
    required Color bgColor,
    required Color texColor,
  }) {
    return Expanded(
      child: CommonWidget.commonButton(
        text: text,
        context: context,
        onTap: onTap,
        height: 44.h,
        width: 142.w,
        color: bgColor,
        alignment: Alignment.center,
        style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: texColor),
      ),
    );
  }

  ///Total points Row
  Widget totalPoints() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.r,
          width: 50.r,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: appConstants.bestSeller2Color,
            shape: BoxShape.circle,
          ),
          child: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/coin_icon.svg",
            color: appConstants.bestSeller1Color,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.total_point.translate(context),
                style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
              ),
              CommonWidget.commonText(
                text: "500",
                style: Theme.of(context).textTheme.h4BoldHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> transferNowPopup() {
    return showDialog(
      context: context,
      barrierColor: appConstants.default2Color,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(25.0.r),
          backgroundColor: appConstants.whiteBackgroundColor,
          surfaceTintColor: appConstants.whiteBackgroundColor,
          scrollable: true,
          contentPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          actionsPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonWidget.imageBuilder(
                  height: 140.h,
                  width: 169.w,
                  fit: BoxFit.fitHeight,
                  imageUrl: "assets/photos/png/my_reward_points/My_reward_transfer.png",
                ),
              ),
              CommonWidget.sizedBox(height: 30),
              CommonWidget.commonText(
                text: TranslationConstants.mobile_number.translate(context),
                style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.sizedBox(height: 3),
              CommonWidget.sizedBox(
                height: 43,
                child: transferTextFieldcommon(
                  length: 10,
                  text: TranslationConstants.enter_your_mobile_number.translate(context),
                ),
              ),
              CommonWidget.sizedBox(height: 14),
              CommonWidget.commonText(
                text: TranslationConstants.your_coin.translate(context),
                style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.sizedBox(height: 3),
              CommonWidget.sizedBox(
                height: 43,
                child: transferTextFieldcommon(
                  length: 20,
                  text: TranslationConstants.enter_your_coin.translate(context),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 22.w, right: 22.w, top: 10.h),
              child: Row(
                children: [
                  transferNowPopupCommonButton(
                    text: TranslationConstants.cancel.translate(context),
                    bgColor: appConstants.secondary2Color,
                    texColor: appConstants.primary1Color,
                    onTap: () => CommonRouter.pop(),
                  ),
                  CommonWidget.sizedBox(width: 15),
                  transferNowPopupCommonButton(
                    text: TranslationConstants.transfer.translate(context),
                    bgColor: appConstants.primary1Color,
                    texColor: appConstants.buttonTextColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget transferTextFieldcommon({
    required String text,
    required int length,
  }) {
    return TextField(
      maxLength: length,
      onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
      keyboardType: TextInputType.number,
      cursorHeight: 25.h,
      cursorColor: appConstants.primary1Color,
      decoration: InputDecoration(
        counterText: "",
        hintText: text,
        hintStyle: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default5Color),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.default7Color),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.primary1Color),
          borderRadius: BorderRadius.circular(8.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.default7Color),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget transferNowPopupCommonButton({
    required String text,
    required VoidCallback onTap,
    required Color bgColor,
    required Color texColor,
  }) {
    return Expanded(
      child: CommonWidget.commonButton(
        text: text,
        color: bgColor,
        context: context,
        onTap: onTap,
        height: 41.h,
        width: 131.w,
        borderRadius: 7.r,
        alignment: Alignment.center,
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
              color: texColor,
            ),
      ),
    );
  }

  Widget transactionDetailBox({
    required String name,
    required Color allColor,
    required Color borderColor,
    int? couponIndex,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: CommonWidget.container(
        isBorder: true,
        borderColor: borderColor,
        borderRadius: 8.r,
        padding: EdgeInsets.all(12.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                couponIndex != 1
                    ? CommonWidget.commonText(
                        text: "Robert Fox",
                        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      )
                    : Row(
                        children: [
                          CommonWidget.commonText(
                            text: "${TranslationConstants.coupon.translate(context)} :$couponCode",
                            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                  color: appConstants.default1Color,
                                ),
                          ),
                          CommonWidget.sizedBox(width: 8),
                          CommonWidget.imageButton(
                            svgPicturePath: "assets/photos/svg/refer_earn_screen/copy_code.svg",
                            iconSize: 15.sp,
                            color: appConstants.primary1Color,
                            onTap: () => Clipboard.setData(ClipboardData(text: couponCode)),
                          ),
                        ],
                      ),
                couponIndex != 1
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: CommonWidget.commonText(
                          text: "XXXXX X5248",
                          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                color: appConstants.default4Color,
                              ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: CommonWidget.commonText(
                          text: "Amazon",
                          style: Theme.of(context)
                              .textTheme
                              .overLineBookHeading
                              .copyWith(color: appConstants.default1Color),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: CommonWidget.commonText(
                    text: DateFormat('dd/MM/yyyy | hh:mm a').format(DateTime.now()),
                    style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                          color: appConstants.default4Color,
                        ),
                  ),
                ),
                CommonWidget.sizedBox(height: 13),
                couponIndex != 1
                    ? Row(
                        children: [
                          CommonWidget.commonBulletPoint(
                            size: 4.sp,
                            color: allColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                          ),
                          CommonWidget.commonText(
                            text: name,
                            style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: allColor),
                          ),
                        ],
                      )
                    : CommonWidget.commonButton(
                        text: TranslationConstants.buy_now.translate(context),
                        height: 37.h,
                        width: 95.w,
                        borderRadius: 7.25.r,
                        alignment: Alignment.center,
                        context: context,
                        style: Theme.of(context)
                            .textTheme
                            .captionMediumHeading
                            .copyWith(color: appConstants.buttonTextColor),
                        onTap: () {},
                      ),
              ],
            ),
            Column(
              children: [
                CommonWidget.sizedBox(height: 5),
                CommonWidget.container(
                  height: 50.h,
                  width: 55.w,
                  color: allColor,
                  borderRadius: 5.8.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CommonWidget.commonText(
                          text: "120",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMediumHeading
                              .copyWith(color: appConstants.buttonTextColor),
                        ),
                      ),
                      Center(
                        child: CommonWidget.commonText(
                          text: "Points",
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.buttonTextColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonWidget.sizedBox(height: 2),
                couponIndex != 1
                    ? CommonWidget.commonText(
                        text: "100= ₹5",
                        style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                              color: appConstants.default4Color,
                            ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTabbar({required String titalText, required String text}) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidget.commonText(
            text: titalText,
            style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.default1Color),
          ),
          CommonWidget.sizedBox(width: 5),
          CommonWidget.container(
            color: appConstants.secondary2Color,
            borderRadius: 3.r,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
              child: CommonWidget.commonText(
                text: text,
                style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(color: appConstants.primary1Color),
              ),
            ),
          )
        ],
      ),
    );
  }
}
