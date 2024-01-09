import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_details_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class RewardCouponDetailsWidgets extends State<RewardCouponDetailsScreen> {
  String couponCode = "FLP9685241XVH";

  Widget couponDetailsWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: appConstants.whiteBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonWidget.container(
                  height: 3.h,
                  width: 25.w,
                  borderRadius: 28.r,
                  color: appConstants.default7Color,
                ),
              ),
              CommonWidget.sizedBox(height: 10),
              CommonWidget.commonText(
                text: TranslationConstants.copy_code_and_use_at_checkout.translate(context),
                style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: couponCode,
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonButton(
                    text: TranslationConstants.copy.translate(context),
                    context: context,
                    onTap: () => Clipboard.setData(ClipboardData(text: couponCode)),
                    height: 35.h,
                    width: 80.w,
                    borderRadius: 30.r,
                    color: appConstants.secondary2Color,
                    alignment: Alignment.center,
                    style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              Row(
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.expiry_date.translate(context),
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonText(
                    text: "30 September,2023",
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                          color: appConstants.default4Color,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: CommonWidget.commonDashLine(
                  width: double.infinity,
                  fontSize: 12.sp,
                  height: 10,
                  fontWeight: FontWeight.w700,
                  color: appConstants.default7Color,
                ),
              ),
              howToRedeem(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CommonWidget.commonButton(
                  text: TranslationConstants.reedem_now.translate(context),
                  context: context,
                  alignment: Alignment.center,
                  height: 51.h,
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                        color: appConstants.buttonTextColor,
                      ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget howToRedeem() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.how_to_redeem.translate(context),
                style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                      color: appConstants.default1Color,
                      height: 1.8,
                    ),
              ),
              bulletpointsText(text: "Click on 'Redeem now'"),
              bulletpointsText(text: "Add product to the cart."),
              bulletpointsText(text: "Apply the code."),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
                child: CommonWidget.commonText(
                  text: TranslationConstants.details.translate(context),
                  style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
              ),
              CommonWidget.commonText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat ",
                textOverflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default4Color,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget couponContainer() {
    return Center(
      child: CommonWidget.container(
        width: 143.w,
        borderRadius: 7.29.r,
        color: appConstants.whiteBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/reward_coupon_screen/amazon_logo.svg",
                height: 28.h,
              ),
            ),
            CommonWidget.commonText(
              text: "25% OFF up to ₹ 250",
              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                    color: appConstants.primary1Color,
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: CommonWidget.commonDashLine(
                width: 138.w,
                fontSize: 10.sp,
                height: 20.h,
                fontWeight: FontWeight.bold,
                color: appConstants.default7Color,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/common/coin_icon.svg",
                  height: 20.h,
                  color: appConstants.oStatus2Color,
                ),
                CommonWidget.sizedBox(width: 10),
                CommonWidget.commonText(
                  text: "6990",
                  style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
              ],
            ),
            CommonWidget.sizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget bulletpointsText({required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        children: [
          CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/reward_coupon_screen/bullet_icon.svg",
            height: 13.h,
            color: appConstants.primary1Color,
          ),
          CommonWidget.sizedBox(width: 10),
          CommonWidget.commonText(
            text: text,
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                  color: appConstants.default3Color,
                ),
          ),
        ],
      ),
    );
  }
}
