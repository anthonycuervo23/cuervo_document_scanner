import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/presentation/view/login_screen/login_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Widget emailTextField() {
    return CommonWidget.textField(
      controller: authenticationCubit.emailController,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.emailAddress,
      isfocusedBorderColor: true,
      focusedBorderColor: appConstants.themeColor,
      enabledBorderColor: appConstants.grey,
      disabledBorderColor: appConstants.grey,
      hintText: TranslationConstants.enter_email.translate(context),
      hintStyle: TextStyle(color: appConstants.grey),
      hintColor: appConstants.black,
      cursorColor: appConstants.themeColor,
    );
  }

  Widget passwordtextField() {
    return CommonWidget.textField(
      controller: authenticationCubit.passwordController,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.multiline,
      isfocusedBorderColor: true,
      focusedBorderColor: appConstants.themeColor,
      enabledBorderColor: appConstants.grey,
      disabledBorderColor: appConstants.grey,
      hintText: TranslationConstants.enter_password.translate(context),
      hintStyle: TextStyle(color: appConstants.grey),
      hintColor: appConstants.black,
      cursorColor: appConstants.themeColor,
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
          style: TextStyle(color: appConstants.white, fontSize: 20.sp),
          onTap: () async {
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
            }
            if (authenticationCubit.emailController.text.isNotEmpty &&
                authenticationCubit.passwordController.text.isNotEmpty) {
              authenticationCubit.loginWithEmail(
                email: authenticationCubit.emailController.text,
                context: context,
                password: authenticationCubit.passwordController.text,
              );
            } else {
              if (authenticationCubit.emailController.text.isEmpty) {
                CustomSnackbar.show(
                  snackbarType: SnackbarType.ERROR,
                  message: TranslationConstants.enter_email_id.translate(context),
                );
              } else {
                CustomSnackbar.show(
                  snackbarType: SnackbarType.ERROR,
                  message: TranslationConstants.enter_valid_emialaddress.translate(context),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
