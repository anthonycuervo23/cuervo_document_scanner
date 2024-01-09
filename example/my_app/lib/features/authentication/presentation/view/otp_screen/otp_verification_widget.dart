import 'dart:async';

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/otp_verification/otp_verification_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/otp_screen/otp_verification_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

abstract class OtpVerificationWidget extends State<OtpVerificationScreen> {
  String? lastDigitsOfNumber;
  late final OtpVerificationCubit otpVerificationCubit;
  late GenerateOtpArgument authenticationOtpArgument;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    authenticationOtpArgument = widget.authenticationOtpArgument;
    _focusNode.requestFocus();
    otpVerificationCubit = getItInstance<OtpVerificationCubit>();
    otpVerificationCubit.timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (otpVerificationCubit.secondsRemaining != 0) {
          otpVerificationCubit.loadTimer(enableResend: false, seconds: otpVerificationCubit.secondsRemaining--);
        } else {
          otpVerificationCubit.loadTimer(enableResend: true, seconds: 0);
        }
      },
    );
    if (authenticationOtpArgument.updateLoginDetailsParams?.loginType != LogintType.email) {
      lastDigitsOfNumber =
          authenticationOtpArgument.mobileNumber.substring(authenticationOtpArgument.mobileNumber.length - 4);
    }

    super.initState();
  }

  void _resendCode() {
    otpVerificationCubit.resendCode(
      mobilenumber: authenticationOtpArgument.mobileNumber,
      userNewOld: authenticationOtpArgument.useOldNew,
    );
  }

  @override
  dispose() {
    super.dispose();
    otpVerificationCubit.loadingCubit.hide();
    otpVerificationCubit.timer.cancel();
    otpVerificationCubit.close();
  }

  Widget mobileNumberDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.num_ninie_one.translate(context),
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
        CommonWidget.commonText(
          text: TranslationConstants.phone_number_by_x.translate(context),
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
        CommonWidget.commonText(
          text: lastDigitsOfNumber ?? '',
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
      ],
    );
  }

  Widget otpField() {
    final defaultPinTheme = PinTheme(
      width: 42.w,
      height: 44.h,
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      textStyle: Theme.of(context).textTheme.subTitle2BookHeading.copyWith(
            color: appConstants.default1Color,
          ),
      decoration: BoxDecoration(
        border: Border.all(color: appConstants.default7Color),
        borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appConstants.primary2Color),
      borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: appConstants.primary2Color),
      borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
    );

    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      closeKeyboardWhenCompleted: true,
      controller: otpVerificationCubit.otpController,
      autofocus: true,
      focusNode: _focusNode,
    );
  }

  Widget timerShow(BuildContext context) {
    return BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
      bloc: otpVerificationCubit,
      builder: (_, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.didnot_receive_the_OTP.translate(context),
              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                    color: Colors.grey.withOpacity(0.8),
                  ),
            ),
            (state as OtpLoadTimerState).enableResend
                ? InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => _resendCode(),
                    child: CommonWidget.commonText(
                      text: TranslationConstants.resend.translate(context),
                      style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                            color: appConstants.primary1Color,
                            decoration: TextDecoration.underline,
                            decorationColor: appConstants.primary1Color,
                          ),
                    ),
                  )
                : CommonWidget.commonText(
                    text:
                        '00:${state.secondsRemaining.toString().length > 1 ? state.secondsRemaining : '0${state.secondsRemaining}'}',
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(color: appConstants.primary1Color),
                  ),
          ],
        );
      },
    );
  }

  Widget loginButton({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: CommonWidget.commonButton(
        context: context,
        padding: EdgeInsets.all(8.r),
        alignment: Alignment.center,
        color: otpVerificationCubit.otpController.length != 6 ? appConstants.default5Color : appConstants.primary1Color,
        text: authenticationOtpArgument.useOldNew == UserNewOld.oldUser
            ? TranslationConstants.continue_button.translate(context)
            : TranslationConstants.login.translate(context),
        style: Theme.of(context).textTheme.subTitle2BookHeading.copyWith(color: appConstants.buttonTextColor),
        onTap: () {
          if (otpVerificationCubit.otpController.length == 6) {
            if (authenticationOtpArgument.useOldNew == UserNewOld.newUser) {
              otpVerificationCubit.verifyOtpData(
                phoneNumber: authenticationOtpArgument.mobileNumber,
                isNewUser: authenticationOtpArgument.generateOtpEntity?.isUserNew ?? false,
                context: context,
              );
            } else {
              if (authenticationOtpArgument.updateLoginDetailsParams != null) {
                otpVerificationCubit.updateVerifyOtpData(
                  context: context,
                  updateLoginDetailsParams: authenticationOtpArgument.updateLoginDetailsParams!,
                );
              }
            }
          }
        },
      ),
    );
  }
}
