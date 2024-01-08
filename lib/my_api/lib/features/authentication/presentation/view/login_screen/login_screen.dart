import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/presentation/view/login_screen/login_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(right: 15.w, bottom: 12.h, left: 15.w, top: 80.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.welcome_to.translate(context),
                    style: Theme.of(context).textTheme.subTitle2BookHeading.copyWith(
                          color: appConstants.black,
                        ),
                  ),
                ),
                CommonWidget.commonText(
                  text: TranslationConstants.bakery_shop_admin.translate(context),
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: appConstants.themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.email_id.translate(context),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: appConstants.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: emailTextField(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: passwordtextField(),
                ),
                continueButton(context: context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
