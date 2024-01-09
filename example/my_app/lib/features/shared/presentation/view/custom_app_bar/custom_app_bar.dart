import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

PreferredSizeWidget? customAppBar(
  BuildContext context, {
  VoidCallback? onTap,
  String? title,
  Widget? trailing,
  Color? textColor,
  Color? appBarColor,
  Color? iconColor,
  bool backArrow = true,
  bool actionButton = false,
  VoidCallback? backArrowTap,
  VoidCallback? actionButtonOnTap,
  IconData? actionnButtonIcon,
  bool titleCenter = true,
  double? toolbarHeight,
  double? elevation,
}) {
  return AppBar(
    toolbarHeight: toolbarHeight ?? 55.h,
    surfaceTintColor: appConstants.whiteBackgroundColor,
    scrolledUnderElevation: 0.0,
    backgroundColor: appBarColor ?? appConstants.whiteBackgroundColor,
    leadingWidth: backArrow == true ? 45 : 0,
    elevation: elevation ?? 0,
    leading: backArrow == true
        ? IconButton(
            highlightColor: Colors.transparent,
            icon: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/back_arrow.svg",
              width: 18.w,
              height: 18.h,
              color: iconColor,
            ),
            onPressed: onTap,
          )
        : CommonWidget.sizedBox(),
    centerTitle: titleCenter,
    title: CommonWidget.commonText(
      text: title ?? '',
      style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: textColor),
    ),
    actions: [
      actionButton == true
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: actionButtonOnTap,
                icon: Icon(
                  actionnButtonIcon ?? Icons.info_outline,
                  color: appConstants.default1Color,
                  size: 35.sp,
                ),
              ),
            )
          : trailing ?? const SizedBox.shrink()
    ],
  );
}
