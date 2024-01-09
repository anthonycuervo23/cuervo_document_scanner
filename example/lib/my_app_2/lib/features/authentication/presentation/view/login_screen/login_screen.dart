import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/login_screen/login_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends LoginWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        context,
        backArrow: false,
        trailing: Padding(
          padding: EdgeInsets.only(right: 20.h),
          child: CommonWidget.textButton(
            text: TranslationConstants.skip.translate(context),
            textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.primary1Color),
            onTap: () async {
              await bakeryBox.put(HiveConstants.IS_TOUR_COMPLETED, true);
              CommonRouter.pushNamedAndRemoveUntil(RouteList.app_home);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 15.w, bottom: 12.h, left: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.sizedBox(height: 10),
                CommonWidget.commonText(
                  text: TranslationConstants.welcome_to.translate(context),
                  style: Theme.of(context).textTheme.subTitle2BookHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
                CommonWidget.commonText(
                  text: TranslationConstants.bakery_shop.translate(context),
                  style: Theme.of(context).textTheme.h3BoldHeading.copyWith(color: appConstants.primary1Color),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.mobile_number.translate(context),
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ),
                CommonWidget.sizedBox(height: 5),
                mobileTextField(),
                continueButton(context: context),
                CommonWidget.sizedBox(height: 20),
                dashedLine(context: context),
                CommonWidget.sizedBox(height: 10),
                googleButton(),
              ],
            ),
            policyText(context: context),
          ],
        ),
      ),
    );
  }
}
