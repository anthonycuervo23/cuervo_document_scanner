import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/refer_point/refer_point_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ReferPointWidget extends State<ReferPointScreen> {
  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.refer_point.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget commonTextField({
    required String titleText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: titleText,
            fontSize: 14,
            bold: true,
          ),
        ),
        CommonWidget.textField(
          hintText: hintText,
          borderRadius: 5.r,
          hintSize: 14.sp,
          contentPadding: EdgeInsets.only(left: 12.w),
          borderColor: appConstants.textFiledColor,
        )
      ],
    );
  }

  Widget submitButton() {
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
            text: TranslationConstants.submit.translate(context),
            color: appConstants.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
