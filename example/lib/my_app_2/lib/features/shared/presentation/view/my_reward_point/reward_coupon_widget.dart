import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class RewardCouponWidget extends State<RewardCouponScreen> {
  Widget couponReward({required VoidCallback ontap}) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            child: GestureDetector(
              onTap: ontap,
              child: Material(
                color: Colors.transparent,
                shadowColor: appConstants.default11Color,
                elevation: 15,
                child: ClipPath(
                  clipper: RewardCouponClipper(
                    holeRadius1: 7.r,
                  ),
                  child: Container(
                    height: 160.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: appConstants.whiteBackgroundColor,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            rewardValidity(),
                            Padding(
                              padding: EdgeInsets.only(top: 25.h, bottom: 30.h, right: 10.w, left: 6.w),
                              child: commonVerticalDashLine(
                                width: 10,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: appConstants.default7Color,
                              ),
                            ),
                            rewardOffUpDetails(),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CommonWidget.sizedBox(
                            height: 75,
                            width: 90,
                            child: Image.asset("assets/photos/png/my_reward_points/coupon_side_image.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  ///RewardValidity
  Widget rewardValidity() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25.h, bottom: 20.h),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/reward_coupon_screen/amazon_logo.svg",
              height: 22.h,
            ),
          ),
          CommonWidget.sizedBox(height: 15),
          CommonWidget.commonText(
            text: "Validity",
            style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                  color: appConstants.default5Color,
                ),
          ),
          CommonWidget.commonText(
            text: "12 Sep - 30 Sep",
            style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                  color: appConstants.default1Color,
                ),
          ),
        ],
      ),
    );
  }

  ///RewardOffUPDetails Column
  Widget rewardOffUpDetails() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: "25% OFF up to ₹ 250",
            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                  color: appConstants.primary1Color,
                ),
          ),
          CommonWidget.commonText(
            text: "Lorem ipsum dolor sit amet...",
            style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                  color: appConstants.default5Color,
                ),
          ),
          CommonWidget.commonText(
            text: "Terms & Conditions",
            style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                  color: appConstants.default3Color,
                ),
          ),
          CommonWidget.sizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: CommonWidget.commonDashLine(
              width: 120.w,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: appConstants.default7Color,
            ),
          ),
          rewardCoin(),
        ],
      ),
    );
  }

  ///Reward CoinCountDetails
  Widget rewardCoin() {
    return Row(
      children: [
        CommonWidget.imageBuilder(
          imageUrl: "assets/photos/svg/common/coin_icon.svg",
          height: 20.h,
          color: appConstants.oStatus2Color,
        ),
        CommonWidget.sizedBox(width: 10),
        CommonWidget.commonText(
          text: "6990",
          style: Theme.of(context).textTheme.subTitle1MediumHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
      ],
    );
  }

  ///commonVerticalDashLine
  Widget commonVerticalDashLine({
    double? fontSize,
    double? height,
    double? width,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return CommonWidget.sizedBox(
      width: width,
      height: height,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => CommonWidget.commonText(
          text: " |",
          textAlign: TextAlign.center,
          fontWeight: fontWeight ?? FontWeight.w100,
          color: color ?? appConstants.default7Color,
          fontSize: fontSize ?? 16.sp,
          bold: true,
        ),
      ),
    );
  }
}

class RewardCouponClipper extends CustomClipper<Path> {
  final double holeRadius1;

  RewardCouponClipper({required this.holeRadius1});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(8.r)));
    path.addOval(Rect.fromCircle(center: Offset(-5.w, (size.height / 3.5.h) * 1.8.h), radius: 15.r));
    path.addOval(Rect.fromCircle(center: Offset(size.width + 5.w, (size.height / 3.5.h) * 1.8.h), radius: 15.r));
    path.fillType = PathFillType.evenOdd;

    Path holePath = Path();
    int numberOfHoles = (size.width / (holeRadius1 * 3)).floor();

    for (int i = 7; i <= numberOfHoles - 1; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset((size.width / numberOfHoles) * i, -2.w),
          radius: holeRadius1,
        ),
      );
    }

    for (int i = 1; i <= 9; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset((size.width / numberOfHoles) * i, size.height + 2.w),
          radius: holeRadius1,
        ),
      );
    }

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
