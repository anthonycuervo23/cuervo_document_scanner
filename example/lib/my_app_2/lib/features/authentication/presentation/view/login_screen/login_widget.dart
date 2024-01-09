// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/login_screen/login_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginWidget extends State<Loginscreen> {
  late AuthenticationCubit authenticationCubit;
  @override
  void initState() {
    authenticationCubit = getItInstance<AuthenticationCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    authenticationCubit.loadingCubit.hide();
    authenticationCubit.close();
  }

  Widget mobileTextField() {
    return CommonWidget.textField(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      textInputAction: TextInputAction.done,
      controller: authenticationCubit.mobileController,
      inputFormatters: [PhoneNumberFormatter()],
      maxLength: 11,
      style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color),
      isfocusedBorderColor: true,
      focusedBorderColor: appConstants.primary3Color,
      hintText: TranslationConstants.mobile_no_10.translate(context),
      hintStyle: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default4Color),
      hintColor: appConstants.default4Color,
      prefixWidget: CommonWidget.sizedBox(
        width: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              marginAllSide: 2.5.r,
              child: Center(
                child: CommonWidget.commonText(
                  text: "+91",
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                ),
              ),
            ),
            CommonWidget.sizedBox(
              height: 20,
              child: VerticalDivider(
                width: 5.w,
                color: appConstants.default6Color,
                thickness: 1.5.r,
              ),
            ),
          ],
        ),
      ),
      context: context,
    );
  }

  Widget continueButton({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Center(
        child: CommonWidget.commonButton(
          padding: EdgeInsets.all(8.r),
          context: context,
          alignment: Alignment.center,
          text: TranslationConstants.continue_button.translate(context),
          style: Theme.of(context).textTheme.subTitle2BookHeading.copyWith(color: appConstants.buttonTextColor),
          onTap: () async {
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
            }
            if (authenticationCubit.mobileController.text.trim().replaceAll(' ', '').length == 10) {
              // CommonRouter.pushNamed(RouteList.otp_verification, arguments: phoneNumber);
              authenticationCubit.generateOtpMobile(
                mobilenumber: authenticationCubit.mobileController.text,
                userNewOld: UserNewOld.newUser,
              );
            } else {
              if (authenticationCubit.mobileController.text.isEmpty) {
                CustomSnackbar.show(
                  snackbarType: SnackbarType.ERROR,
                  message: TranslationConstants.enter_mobile_number.translate(context),
                );
              } else {
                CustomSnackbar.show(
                  snackbarType: SnackbarType.ERROR,
                  message: TranslationConstants.enter_valid_phone_number.translate(context),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget policyText({required BuildContext context}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.by_continue.translate(context),
              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default2Color),
              color: appConstants.default2Color,
              fontSize: 10.sp,
            ),
            CommonWidget.textButton(
              onTap: () => CommonRouter.pushNamed(RouteList.policy_screen, arguments: TypeOfPolicy.privacyPolicy),
              text: TranslationConstants.terms.translate(context),
              textStyle: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.primary1Color),
              fontSize: 11.sp,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.textButton(
              onTap: () => CommonRouter.pushNamed(RouteList.policy_screen, arguments: TypeOfPolicy.termsAndConditions),
              text: TranslationConstants.conditions.translate(context),
              textStyle: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.primary1Color),
              fontSize: 11.sp,
            ),
            CommonWidget.commonText(
              text: TranslationConstants.or.translate(context),
              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default2Color),
              color: appConstants.default2Color,
              fontSize: 10.sp,
            ),
            CommonWidget.textButton(
              onTap: () => CommonRouter.pushNamed(RouteList.policy_screen, arguments: TypeOfPolicy.privacyPolicy),
              text: TranslationConstants.privacy_policy.translate(context),
              textStyle: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.primary1Color),
              fontSize: 11.sp,
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 20),
      ],
    );
  }

  Widget googleButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: () async {
          UserCredential? userCredential = await signInWithGoogle();
          if (userCredential?.user != null) {
            // CommonRouter.pushNamed(RouteList.referral_screen);
            authenticationCubit.loginWithEmail(
              email: userCredential?.user?.email ?? '',
              googleId: userCredential?.user?.uid ?? '',
              context: context,
              userNewOld: UserNewOld.newUser,
            );
            CustomSnackbar.show(
              snackbarType: SnackbarType.SUCCESS,
              message: TranslationConstants.sign_in_success.translate(context),
            );
          } else {
            CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.sign_in_failed.translate(context),
            );
          }
        },
        child: CommonWidget.container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          isBorder: true,
          borderRadius: appConstants.buttonRadius,
          borderWidth: 1.5,
          borderColor: appConstants.default6Color,
          color: appConstants.textFiledColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/google_icon.svg"),
              CommonWidget.sizedBox(width: 12),
              CommonWidget.commonText(
                text: TranslationConstants.google.translate(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashedLine({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CommonWidget.sizedBox(
        height: 18,
        width: ScreenUtil().screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CommonWidget.commonDashLine(
                color: appConstants.default5Color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                isLeft: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: CommonWidget.commonText(
                text: TranslationConstants.you_can_connect.translate(context),
                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default3Color),
                fontWeight: FontWeight.w600,
                color: appConstants.default3Color,
                fontSize: 11.sp,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: CommonWidget.commonDashLine(
                color: appConstants.default5Color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignIn googleUser = GoogleSignIn();

  try {
    if (await googleUser.isSignedIn()) {
      await googleUser.signOut();
    }
    GoogleSignInAccount? account = await googleUser.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await account?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    googleUserName = account?.displayName;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
