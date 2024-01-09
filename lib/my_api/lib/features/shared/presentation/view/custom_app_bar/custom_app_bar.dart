import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_admin_flutter/global.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget? CustomAppBar(
  BuildContext context, {
  VoidCallback? onTap,
  String? title,
  Widget? trailing,
  String? leadingIconUrl,
  bool? shadowColor,
  Color? textColor,
  Color? appBarColor,
  Color? iconColor,
  bool leadingIcon = true,
  bool actionButton = false,
  VoidCallback? backArrowTap,
  VoidCallback? actionButtonOnTap,
  IconData? actionnButtonIcon,
  bool titleCenter = true,
  TextStyle? style,
  double? elevation,
  Color? shadowcolor,
  double? fontSize,
  Color? fontColor,
  Widget? titleWidget,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
  Color? dividerColor,
}) {
  return AppBar(
    surfaceTintColor: appConstants.white,
    elevation: elevation ?? 0,
    shadowColor: shadowcolor ?? appConstants.transparent,
    scrolledUnderElevation: 0.0,
    backgroundColor: appBarColor ?? appConstants.appbarColor,
    leadingWidth: leadingIcon == true ? 45 : 0,
    bottom: bottom ??
        PreferredSize(
          preferredSize: const Size(0, 0),
          child: dividerColor != null ? Divider(color: dividerColor, height: 5.h) : const SizedBox.shrink(),
        ),
    leading: leadingIcon == true
        ? IconButton(
            highlightColor: Colors.transparent,
            icon: CommonWidget.imageBuilder(
              imageUrl: leadingIconUrl ?? "assets/photos/svg/common/app_bar_back_arrow.svg",
              width: 18.w,
              height: 18.h,
              color: iconColor,
            ),
            onPressed: onTap,
          )
        : const SizedBox.shrink(),
    centerTitle: titleCenter,
    title: titleWidget ??
        CommonWidget.commonText(
          text: title ?? '',
          style: style ??
              TextStyle(
                fontSize: fontSize ?? 18.sp,
                fontWeight: FontWeight.bold,
                color: textColor ?? appConstants.textColor,
              ),
        ),
    actions: actions ??
        [
          actionButton == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: actionButtonOnTap,
                    icon: Icon(
                      actionnButtonIcon ?? Icons.info_outline,
                      color: appConstants.icon,
                      size: 35.sp,
                    ),
                  ),
                )
              : trailing ?? const SizedBox.shrink()
        ],
  );
}
