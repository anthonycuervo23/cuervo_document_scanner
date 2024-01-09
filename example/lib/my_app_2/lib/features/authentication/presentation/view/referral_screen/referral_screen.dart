// ignore_for_file: deprecated_member_use

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/referral_redeem/referral_redeem_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  late final ReferralRedeemCubit referralRedeemCubit;
  @override
  void initState() {
    referralRedeemCubit = getItInstance<ReferralRedeemCubit>();
    super.initState();
  }

  @override
  void dispose() {
    referralRedeemCubit.loadingCubit.hide();
    referralRedeemCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: appConstants.whiteBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
          context,
          onTap: () => CommonRouter.pop(),
          backArrow: false,
          trailing: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: CommonWidget.textButton(
              onTap: () => CommonRouter.pushReplacementNamed(
                RouteList.edit_profile_screen,
                arguments: UserNewOld.newUser,
              ),
              text: TranslationConstants.skip.translate(context),
              textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.primary1Color),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.who_is_your.translate(context),
                style: Theme.of(context).textTheme.subTitle1BoldHeading.copyWith(color: appConstants.default1Color),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: CommonWidget.commonText(
                  text: TranslationConstants.get_a_referral.translate(context),
                  style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default3Color),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/once_used_picture/refer_screen.svg",
                  height: 160.h,
                  // width: 160.w,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  CommonWidget.textField(
                    context: context,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    textInputType: TextInputType.text,
                    controller: referralRedeemCubit.referCodeController,
                    focusedBorderColor: appConstants.primary3Color,
                    isfocusedBorderColor: true,
                    hintText: TranslationConstants.enter_referral_code.translate(context),
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                    maxLength: 8,
                    hintColor: appConstants.default4Color,
                    hintStyle: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                          color: appConstants.default4Color,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CommonWidget.commonButton(
                      padding: EdgeInsets.all(8.r),
                      alignment: Alignment.center,
                      context: context,
                      text: TranslationConstants.continue_button.translate(context),
                      style: Theme.of(context)
                          .textTheme
                          .subTitle2BookHeading
                          .copyWith(color: appConstants.buttonTextColor),
                      onTap: () {
                        if (referralRedeemCubit.referCodeController.text.isEmpty) {
                          CustomSnackbar.show(
                            snackbarType: SnackbarType.ERROR,
                            message: TranslationConstants.please_enter_valid_referral_code.translate(context),
                          );
                        } else {
                          referralRedeemCubit.referralCodeData(userNewOld: UserNewOld.newUser, context: context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
