import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/refer_and_earn_screen_view.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bakery_shop_flutter/global.dart';

abstract class ReferAndEarnWidget extends State<ReferAndEarnScreen> {
  String referCode = "BKRP1007";

  Widget screenView({required BuildContext context}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
                color: appConstants.primary1Color,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/photos/png/refer_earn_screen/refer_earn_background.png',
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.sizedBox(height: 35),
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/refer_earn_screen/refer_earn.svg",
                    height: 140.h,
                  ),
                  CommonWidget.sizedBox(height: 10),
                  CommonWidget.sizedBox(
                    width: 260,
                    child: CommonWidget.commonText(
                      text: TranslationConstants.invite_your_friend.translate(context),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .captionMediumHeading
                          .copyWith(color: appConstants.buttonTextColor, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(bottom: -45.h, left: 0, right: 0, child: copyUi(context)),
          ],
        ),
        Expanded(child: howItWork()),
        referWithFriendButton(context),
        CommonWidget.sizedBox(height: 5),
        GestureDetector(
          onTap: () => CommonRouter.pushNamed(RouteList.my_reward_point_screen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.view_all_reward.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
              ),
              CommonWidget.sizedBox(width: 5),
              CommonWidget.commonIcon(
                icon: Icons.arrow_forward_ios_outlined,
                iconSize: 16.r,
                iconColor: appConstants.primary1Color,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: CommonWidget.textButton(
            text: TranslationConstants.terms_and_condition.translate(context),
            textStyle: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                  color: appConstants.default1Color,
                ),
            onTap: () => CommonRouter.pushNamed(RouteList.policy_screen, arguments: TypeOfPolicy.termsAndConditions),
          ),
        ),
      ],
    );
  }

  Widget referWithFriendButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 10.h),
      child: CommonWidget.commonButton(
        text: "${TranslationConstants.refer_with_friends.translate(context)}!",
        height: 51.h,
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
        alignment: Alignment.center,
        context: context,
        onTap: () async {
          final result = await Share.shareWithResult(
              'https://www.thesprucepets.com/thmb/APYdMl_MTqwODmH4dDqaY5q0UoE=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/all-about-tabby-cats-552489-hero-a23a9118af8c477b914a0a1570d4f787.jpg');
          if (result.status == ShareResultStatus.success) {
            if (kDebugMode) {
              print('Thank you for sharing my website!');
            }
          }
        },
      ),
    );
  }

  Widget copyUi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Material(
        shadowColor: appConstants.default9Color.withOpacity(0.2),
        borderOnForeground: true,
        elevation: 10,
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.transparent,
        child: ClipPath(
          clipper: CuponClipper(holeRadius: 7.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: appConstants.whiteBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.your_refer_code.translate(context),
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default3Color,
                            ),
                      ),
                      CommonWidget.commonText(
                        text: referCode,
                        style: Theme.of(context).textTheme.h4MediumHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                    ],
                  ),
                ),
                CommonWidget.sizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: appConstants.default7Color,
                    thickness: 2,
                  ),
                ),
                CommonWidget.sizedBox(
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonWidget.imageButton(
                        svgPicturePath: "assets/photos/svg/refer_earn_screen/copy_code.svg",
                        iconSize: 22.sp,
                        color: appConstants.primary1Color,
                        onTap: () => Clipboard.setData(ClipboardData(text: referCode)),
                      ),
                      CommonWidget.sizedBox(height: 5),
                      CommonWidget.commonText(
                        text: TranslationConstants.copy_code.translate(context),
                        style: Theme.of(context)
                            .textTheme
                            .overLineMediumHeading
                            .copyWith(color: appConstants.default1Color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget howItWork() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 65.h, bottom: 10.h),
      child: CommonWidget.container(
        borderRadius: appConstants.prductCardRadius,
        isBorder: true,
        borderColor: appConstants.default7Color,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.how_it_work.translate(context),
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
                CommonWidget.sizedBox(width: 8),
                CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/refer_earn_screen/question_mark.svg",
                    color: appConstants.primary1Color),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return bulletPoint(text: "Lorem ipsum dolor sit amet, consectetur adi");
                },
              ),
            ),
            CommonWidget.textButton(
              text: TranslationConstants.view_more.translate(context),
              textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                    color: appConstants.primary1Color,
                  ),
              onTap: () => CommonRouter.pushNamed(RouteList.how_it_work_screen),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulletPoint({required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 10.w),
            child: CommonWidget.commonBulletPoint(size: 4.h),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 262.w),
            child: CommonWidget.commonText(
              style: Theme.of(context)
                  .textTheme
                  .captionBookHeading
                  .copyWith(color: appConstants.default3Color, overflow: TextOverflow.ellipsis),
              text: text,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CuponClipper extends CustomClipper<Path> {
  final double holeRadius;

  CuponClipper({required this.holeRadius});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    Path holePath = Path();
    int numberOfHoles = (size.width / (holeRadius * 2.5)).floor();

    for (int i = 1; i <= numberOfHoles - 1; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset((size.width / numberOfHoles) * i, -3.5),
          radius: holeRadius,
        ),
      );
    }
    for (int i = 1; i <= numberOfHoles - 1; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset((size.width / numberOfHoles) * i, size.height + 3.5),
          radius: holeRadius,
        ),
      );
    }

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
