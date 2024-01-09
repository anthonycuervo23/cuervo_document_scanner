import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/change_password_screen/change_password_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ChangePasswordWidget extends State<ChangePasswordScreen> {
  late ChangePasswordCubit changePasswordCubit;

  @override
  void initState() {
    changePasswordCubit = getItInstance<ChangePasswordCubit>();
    super.initState();
  }

  @override
  void dispose() {
    changePasswordCubit.loadingCubit.hide();
    changePasswordCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.change_password.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget commonTextField(
      {required String titleText,
      required String hintText,
      required VoidCallback onIconTab,
      required ChangePasswordLoadedState state,
      required bool obscureText,
      required Icon icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: titleText,
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CommonWidget.textField(
          style: TextStyle(fontSize: 14.sp),
          borderRadius: 5.r,
          maxLines: 1,
          hintText: hintText,
          hintSize: 12.sp,
          contentPadding: EdgeInsets.only(left: 12.w),
          textInputType: TextInputType.visiblePassword,
          borderColor: appConstants.textFiledColor,
          issuffixWidget: true,
          textInputAction: TextInputAction.done,
          obscureText: obscureText,
          suffixWidget: IconButton(
            onPressed: onIconTab,
            highlightColor: appConstants.transparent,
            icon: icon,
          ),
        ),
      ],
    );
  }

  Widget upDatePasswordButton() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: CommonWidget.container(
          height: 50,
          color: appConstants.theme1Color,
          borderRadius: 10.sp,
          alignment: Alignment.center,
          child: CommonWidget.commonText(
            text: TranslationConstants.update_password.translate(context),
            color: appConstants.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
