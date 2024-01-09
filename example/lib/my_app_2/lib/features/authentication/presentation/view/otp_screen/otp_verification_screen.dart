import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/otp_screen/otp_verification_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerificationScreen extends StatefulWidget {
  final GenerateOtpArgument authenticationOtpArgument;

  const OtpVerificationScreen({super.key, required this.authenticationOtpArgument});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends OtpVerificationWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.otp_verification.translate(context),
                  style: Theme.of(context).textTheme.subTitle1BoldHeading.copyWith(color: appConstants.default1Color),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.we_have_sent.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
                  ),
                ),
                CommonWidget.sizedBox(
                  width: ScreenUtil().screenWidth,
                  child: authenticationOtpArgument.updateLoginDetailsParams?.loginType != LogintType.email
                      ? mobileNumberDetail(context)
                      : CommonWidget.commonText(
                          text: authenticationOtpArgument.updateLoginDetailsParams?.email ?? '',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                ),
                CommonWidget.sizedBox(height: 30),
                SizedBox(width: ScreenUtil().screenWidth, child: otpField()),
                CommonWidget.sizedBox(height: 20),
                timerShow(context),
              ],
            ),
            loginButton(context: context),
          ],
        ),
      ),
    );
  }
}
