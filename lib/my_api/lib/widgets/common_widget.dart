import 'dart:io';
import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/core/build_context.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:bakery_shop_admin_flutter/global.dart';

class CommonWidget {
  static Widget commonPadding({
    Widget? child,
    EdgeInsets? padding,
    bool? isSymmetric,
    double? horizontal,
    double? verticle,
    bool? isAllSidePdding,
    double? allSidePaddingValue,
    bool? isOnlyoneSidePadding,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return Padding(
      padding: isSymmetric == true
          ? EdgeInsets.symmetric(horizontal: horizontal ?? 0, vertical: verticle ?? 0)
          : isAllSidePdding == true
              ? EdgeInsets.all(allSidePaddingValue ?? 0)
              : isOnlyoneSidePadding == true
                  ? EdgeInsets.only(left: left ?? 0, right: right ?? 0, top: top ?? 0, bottom: bottom ?? 0)
                  : EdgeInsets.symmetric(horizontal: ScreenUtil().screenWidth * 0.05),
      child: child,
    );
  }

  static Widget toggleButton({
    Color? activeThumbColor,
    Color? inactiveThumbColor,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? trackerOutLineeColor,
    required bool value,
    required void Function(bool)? onChanged,
    double? buttnWidth,
    Color? backgroundColor,
  }) {
    return container(
      width: buttnWidth ?? 40.w,
      // color: appConstants.red,
      color: backgroundColor,

      child: Transform.scale(
        scaleX: 0.75.r,
        scaleY: 0.75.r,
        child: Switch(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          thumbColor: value
              ? MaterialStatePropertyAll<Color>(activeThumbColor ?? appConstants.iconColor)
              : MaterialStatePropertyAll<Color>(inactiveThumbColor ?? appConstants.white),
          activeTrackColor: activeTrackColor ?? appConstants.themeColor,
          onFocusChange: (value) {},
          splashRadius: 1,
          inactiveTrackColor: inactiveTrackColor ?? appConstants.black12,
          inactiveThumbColor: activeThumbColor ?? appConstants.white,
          trackOutlineColor: MaterialStatePropertyAll(trackerOutLineeColor ?? appConstants.transparent),
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  static Widget container({
    double? width,
    double? height,
    bool? isBorder = false,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? color,
    AlignmentGeometry? alignment,
    double? marginAllSide,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    bool? isBorderOnlySide,
    bool? isMarginAllSide = true,
    EdgeInsetsGeometry? margin,
    double? paddingAllSide,
    bool? ispaddingAllSide = false,
    EdgeInsetsGeometry? padding,
    Widget? child,
    List<BoxShadow>? shadow,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin ?? EdgeInsets.all(marginAllSide ?? 0),
      padding: padding ?? EdgeInsets.all(paddingAllSide ?? 0),
      alignment: alignment,
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border.all(
                color: borderColor ?? appConstants.grey,
                width: borderWidth ?? 1.0,
              )
            : null,
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 0),
                bottomRight: Radius.circular(bottomRight ?? 0),
                topLeft: Radius.circular(topLeft ?? 0),
                topRight: Radius.circular(topRight ?? 0),
              )
            : boaderRadius(borderRadius ?? 0),
        color: color ?? appConstants.white,
        boxShadow: shadow,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static gestureHideKeyboard(BuildContext context, {required Widget child}) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return GestureDetector(
      onVerticalDragDown: (_) {
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: SafeArea(child: child),
    );
  }

  static Widget commonBulletPoint({
    EdgeInsets? padding,
    Color? color,
    double size = 3,
  }) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: CircleAvatar(backgroundColor: color ?? appConstants.themeColor, radius: size),
    );
  }

  static Widget imageButton({
    required String svgPicturePath,
    VoidCallback? onTap,
    double? iconSize,
    BoxFit? boxFit,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: imageBuilder(
        imageUrl: svgPicturePath,
        fit: boxFit ?? BoxFit.contain,
        height: iconSize ?? 20.h,
        color: color,
      ),
    );
  }

  static Widget commonText({
    required String text,
    bool? bold = false,
    FontWeight? fontWeight,
    TextOverflow? textOverflow,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    bool? fontFamily,
    TextAlign? textAlign,
    int? maxLines,
    bool? lineThrough,
    Color? lineThroughColor,
    double? lineThroughthickness,
    bool? underline,
    TextStyle? style,
    double? height,
  }) {
    return Text(
      text,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            height: height,
            color: color ?? appConstants.textColor,
            fontSize: fontSize?.sp ?? 20.sp,
            fontWeight: bold == true ? FontWeight.bold : fontWeight,
            fontFamily: fontFamily == false ? null : 'Circular Std',
            letterSpacing: letterSpacing ?? 0.15,
            wordSpacing: wordSpacing ?? 0.1,
            decoration: lineThrough == true
                ? TextDecoration.lineThrough
                : underline == true
                    ? TextDecoration.underline
                    : TextDecoration.none,
            decorationColor: lineThroughColor ?? Colors.black38,
            decorationThickness: lineThroughthickness ?? 1.sp,
          ),
    );
  }

  static Widget commonDashLine({
    double? fontSize,
    double? height,
    double? width,
    FontWeight? fontWeight,
    Color? color,
    bool isLeft = true,
  }) {
    return Container(
      height: 2,
      width: width,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          color: index % 2 == 0 ? appConstants.black12 : color ?? Colors.transparent,
          // color: index % 2 == 0 ? Colors.transparent : color ?? appConstants.black12,
          height: 2,
          width: 6.w,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  static Widget commonIcon({
    double? iconSize,
    required IconData icon,
    Color? iconColor,
  }) {
    return Icon(
      icon,
      color: iconColor ?? appConstants.black,
      size: iconSize?.sp ?? 32.sp,
    );
  }

  static Widget materialButton({
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
    bool? bold = false,
    bool? isBorderOnlySide,
    FontWeight? fontWeight,
    double? borderRadius,
    double? minWidth,
    Radius? bottomLeft,
    Radius? bottomRight,
    Radius? topLeft,
    Radius? topRight,
    Color? splashColor,
    Color? color,
    Color? highlightColor,
    EdgeInsets? padding,
    double? fontSize,
    // bool? disableSplash,
    bool? paddingCustomized,
    double? height,
    Color? borderColor,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      height: height,
      color: color ?? appConstants.themeColor,
      padding: paddingCustomized == true ? padding : EdgeInsets.symmetric(vertical: 12.h),
      minWidth: minWidth ?? ScreenUtil().screenWidth,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: highlightColor ?? Colors.transparent,
      splashColor: splashColor ?? Colors.transparent,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: isBorderOnlySide == true
              ? BorderRadius.only(
                  bottomLeft: bottomLeft ?? const Radius.circular(0),
                  bottomRight: bottomRight ?? const Radius.circular(0),
                  topLeft: topLeft ?? const Radius.circular(0),
                  topRight: topRight ?? const Radius.circular(0),
                )
              : BorderRadius.circular(borderRadius ?? 10),
          side: BorderSide(color: borderColor ?? Colors.transparent)),
      child: commonText(
        text: text,
        color: textColor ?? appConstants.drawerTextColor,
        fontSize: fontSize ?? 16.sp,
        bold: bold,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }

  static void showAlertDialog({
    required BuildContext context,
    required VoidCallback onTap,
    required String text,
    String? titleText,
    Color? textColor,
    bool isTitle = false,
    VoidCallback? onNoTap,
    List<Widget>? actions,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    String? leftButtonText,
    String? rightButtonText,
    Color? leftColor,
    int? maxLines,
    Color? leftTextColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            surfaceTintColor: appConstants.white,
            backgroundColor: appConstants.white,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            actionsPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: SizedBox(
              width: ScreenUtil().screenWidth * 0.9,
              child: Column(
                children: [
                  CommonWidget.sizedBox(height: 20),
                  isTitle
                      ? Column(
                          children: [
                            Center(
                              child: commonText(
                                lineThrough: true,
                                style: titleTextStyle ??
                                    Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                                          color: appConstants.black,
                                          height: 1,
                                        ),
                                text: titleText ?? '',
                              ),
                            ),
                            CommonWidget.sizedBox(height: 15),
                          ],
                        )
                      : const SizedBox.shrink(),
                  CommonWidget.container(
                    child: CommonWidget.commonText(
                      maxLines: maxLines ?? 1,
                      style: contentTextStyle ??
                          Theme.of(context)
                              .textTheme
                              .body1BookHeading
                              .copyWith(color: textColor ?? appConstants.introScreenDescriptionText),
                      text: text,
                      fontSize: 13.sp,
                      textAlign: TextAlign.center,
                      color: textColor ?? appConstants.introScreenDescriptionText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Row(
                      children: [
                        Expanded(
                          child: commonButton(
                            context: context,
                            alignment: Alignment.center,
                            onTap: onNoTap ?? () => CommonRouter.pop(),
                            text: leftButtonText ?? TranslationConstants.no.translate(context),
                            textColor: leftTextColor ?? appConstants.themeColor,
                            color: leftColor ?? appConstants.orenge,
                            borderRadius: 8.r,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: commonButton(
                            context: context,
                            onTap: onTap,
                            alignment: Alignment.center,
                            text: rightButtonText ?? TranslationConstants.yes.translate(context),
                            textColor: appConstants.white,
                            color: appConstants.themeColor,
                            borderRadius: 8.r,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  static Widget textButton({
    required String text,
    required VoidCallback? onTap,
    Color? textColor,
    double? fontSize,
    bool? bold = false,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    EdgeInsets padding = EdgeInsets.zero,
    TextStyle? textStyle,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: commonText(
          text: text,
          bold: bold,
          color: textColor ?? appConstants.themeColor,
          fontSize: fontSize ?? 12.sp,
          fontWeight: bold == true ? fontWeight ?? FontWeight.w500 : FontWeight.normal,
          style: textStyle,
        ),
      ),
    );
  }

  static Widget textField({
    FocusNode? focusNode,
    Color? borderColor,
    Color? disabledBorderColor,
    Color? cursorColor,
    Color? textColor,
    TextEditingController? controller,
    TextStyle? hintTextStyle,
    bool? obscureText,
    bool? isPrefixIcon,
    bool? isPrefixWidget,
    Widget? prefixWidget,
    String? prefixIconPath,
    int? maxLength,
    double? fontSize,
    FontWeight? fontWeight,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    String? hintText,
    double? hintSize,
    double? prefixIconHeight,
    double? horizontalContentPadding,
    double? verticalContentPadding,
    double? borderRadius,
    FontWeight? hintWeight,
    Color? hintColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? fillColor,
    Color? suffixIconColor,
    bool? isfocusedBorderColor,
    VoidCallback? onPrefixIconTap,
    bool? issuffixWidget,
    Widget? suffixWidget,
    bool? issuffixIcon,
    String? suffixIconpath,
    double? suffixHight,
    VoidCallback? onsuffixIconTap,
    bool? autoFocus,
    double? cursorHight,
    TextAlignVertical? textAlignVertical,
    void Function(String)? onChanged,
    VoidCallback? onTap,
    ScrollController? scrollController,
    bool enabled = true,
    int? maxLines,
    bool autofocus = false,
    TextStyle? hintstyle,
    void Function(String)? onSubmitted,
    void Function()? onEditingComplete,
    Function(String, Map<String, dynamic>)? onAppPrivateCommand,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? hintStyle,
    TextStyle? style,
    bool? readOnly,
    List<TextInputFormatter>? inputFormatters,
    InputBorder? border,
    int? minLines,
  }) {
    return TextField(
      focusNode: focusNode,
      scrollController: scrollController,
      scrollPadding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      inputFormatters: inputFormatters,
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(buildContext);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onAppPrivateCommand: onAppPrivateCommand,
      maxLines: maxLines,
      minLines: minLines ?? 1,
      enabled: enabled,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction ?? TextInputAction.done,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.number,
      cursorColor: cursorColor ?? appConstants.grey,
      cursorHeight: cursorHight,
      autofocus: autoFocus ?? false,
      maxLength: maxLength ?? 150,
      readOnly: readOnly ?? false,
      style: style,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? appConstants.white,
        prefixIcon: prefixWidget ??
            (isPrefixIcon == true
                ? container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(13.r),
                    child: imageButton(
                      svgPicturePath: prefixIconPath ?? '',
                      iconSize: prefixIconHeight,
                      onTap: onPrefixIconTap,
                    ),
                  )
                : null),
        suffixIcon: issuffixWidget == true
            ? suffixWidget
            : issuffixIcon == true
                ? container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(13.r),
                    child: imageButton(
                      svgPicturePath: suffixIconpath ?? '',
                      iconSize: suffixHight,
                      onTap: onsuffixIconTap,
                      color: suffixIconColor,
                    ),
                  )
                : null,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor ?? focusedBorderColor ?? appConstants.neutral6Color),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor ?? appConstants.themeColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        disabledBorder: focusedBorderColor == null
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 10.r)),
        counterText: "",
        hintText: hintText,
        hintStyle: hintStyle ??
            hintstyle ??
            TextStyle(
              fontSize: hintSize ?? 16.sp,
              fontWeight: hintWeight ?? FontWeight.w400,
              color: hintColor ?? appConstants.black45,
            ),
      ),
    );
  }

  static Widget drawerListTile({
    required VoidCallback onTap,
    required String text,
    Color? textColor,
    double? iconSize,
    double? fontSize,
    FontWeight? fontWeight,
    bool? bold,
    String? imagePath,
    String? svgPicturePath,
    double? height,
    BoxFit? boxFit,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: ScreenUtil().screenWidth * 0.008),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        child: CommonWidget.imageButton(
          svgPicturePath: svgPicturePath ?? '',
          boxFit: boxFit,
          onTap: onTap,
          iconSize: iconSize,
        ),
      ),
      title: commonText(
          text: text,
          color: textColor ?? appConstants.drawerTextColor,
          fontSize: fontSize ?? 14.sp,
          bold: bold ?? false,
          fontWeight: fontWeight ?? FontWeight.w500),
      onTap: onTap,
    );
  }

  Widget numberOfnotification({
    required int number,
    double? fontSize,
  }) {
    return container(
      height: number > 99 ? 17.h : 16.h,
      width: number > 99 ? 17.h : 16.w,
      color: appConstants.red,
      borderRadius: 10.r,
      child: Center(
        child: commonText(
            text: "$number",
            color: appConstants.notificationTextColor,
            fontSize: number > 99 ? 8.sp : 10.sp,
            bold: true,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  static Widget warningIcon({double? width, double? height, Color? color, Alignment? alignment}) {
    return Center(
      child: SvgPicture.asset(
        "assets/photos/svg/common/warning.svg",
        width: width ?? 32.w,
        height: height ?? 32.h,
        colorFilter: ColorFilter.mode(color ?? appConstants.themeColor, BlendMode.srcIn),
        alignment: alignment ?? Alignment.center,
      ),
    );
  }

  static Widget loadingIos({Color? loaderColor}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: SizedBox(
          height: 46.r,
          width: 46.r,
          child: Center(
            child: 1 == 1
                ? Center(
                    child: CircularProgressIndicator(
                      color: appConstants.themeColor,
                      strokeWidth: 2,
                      backgroundColor: appConstants.black12,
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : Lottie.asset(
                    loaderColor == Colors.white
                        ? "assets/animation/loading_indicator_white.json"
                        : "assets/animation/loading_indicator_primary.json",
                    width: 46.r,
                    height: 46.r,
                  ),
          ),
        ),
      ),
    );
  }

  static Widget imageBuilder({
    required String imageUrl,
    double? height,
    double? width,
    double? borderRadius,
    int? cacheWidth,
    BoxFit? fit,
    Color? color,
    bool? isBorderOnlySide,
    Radius? bottomLeft,
    Radius? bottomRight,
    Radius? topLeft,
    Radius? topRight,
    EdgeInsets? padding,
    double? horizontalPadding,
    double? verticalPadding,
  }) {
    if (imageUrl.isEmpty) {
      return Center(child: warningIcon(color: color));
    } else if (imageUrl.startsWith('https')) {
      return ClipRRect(
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: bottomLeft ?? Radius.zero,
                bottomRight: bottomRight ?? Radius.zero,
                topLeft: topLeft ?? Radius.zero,
                topRight: topRight ?? Radius.zero,
              )
            : BorderRadius.circular(borderRadius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          memCacheWidth: cacheWidth,
          color: color,
          height: height,
          width: width,
          placeholder: (context, url) => SizedBox(
            height: height,
            width: width,
            child: loadingIos(loaderColor: color),
          ),
          errorWidget: (context, error, stackTrace) => warningIcon(color: color),
        ),
      );
    } else if (imageUrl.startsWith('assets') && imageUrl.endsWith('.svg')) {
      return ClipRRect(
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: bottomLeft ?? Radius.zero,
                bottomRight: bottomRight ?? Radius.zero,
                topLeft: topLeft ?? Radius.zero,
                topRight: topRight ?? Radius.zero,
              )
            : BorderRadius.circular(borderRadius ?? 0),
        child: SvgPicture.asset(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        ),
      );
    } else if (imageUrl.startsWith('assets')) {
      return ClipRRect(
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: bottomLeft ?? Radius.zero,
                bottomRight: bottomRight ?? Radius.zero,
                topLeft: topLeft ?? Radius.zero,
                topRight: topRight ?? Radius.zero,
              )
            : BorderRadius.circular(borderRadius ?? 0),
        child: Image.asset(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          color: color,
          cacheWidth: cacheWidth,
          errorBuilder: (context, error, stackTrace) => warningIcon(color: color),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: isBorderOnlySide == true
            ? BorderRadius.only(
                bottomLeft: bottomLeft ?? Radius.zero,
                bottomRight: bottomRight ?? Radius.zero,
                topLeft: topLeft ?? Radius.zero,
                topRight: topRight ?? Radius.zero,
              )
            : BorderRadius.circular(borderRadius ?? 0),
        child: Image.file(
          File(imageUrl),
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          color: color,
          cacheWidth: cacheWidth,
          errorBuilder: (context, error, stackTrace) => warningIcon(color: color),
        ),
      );
    }
  }

  static Widget cachedNetworkImage({
    required String imagePath,
    EdgeInsets? padding,
    double? height,
    double? width,
    double? horizontalPadding,
    double? verticalPadding,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 0.w,
              vertical: verticalPadding ?? 0.h,
            ),
        child: CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: imagePath,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? CommonWidget.boaderRadius(10.r),
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
              ),
            ),
          ),
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  static Widget commonSvgIconButton({
    required String svgPicturePath,
    double? height,
    double? containerWidth,
    double? containerHeight,
    VoidCallback? onTap,
    // double? iconSize,
    BoxFit? boxFit,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      height: containerHeight, // ?? 26.h,
      width: containerWidth,

      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: onTap,
        icon: SvgPicture.asset(
          svgPicturePath,
          fit: boxFit ?? BoxFit.contain,
          height: height ?? 20.h,
        ),
        // padding: const EdgeInsets.all(0),
      ),
    );
  }

  static Widget svgIconButton({
    required String svgPicturePath,
    VoidCallback? onTap,
    double? iconSize,
    BoxFit? boxFit,
    Color? color,
    // EdgeInsetsGeometry? padding,
    bool isChangeColor = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        svgPicturePath,
        fit: boxFit ?? BoxFit.contain,
        height: iconSize ?? 20.h,
        colorFilter: isChangeColor ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
      // padding: padding ?? const EdgeInsets.all(0),
    );
  }

  static SizedBox sizedBox({
    double? width,
    double? height,
    Widget? child,
  }) {
    return SizedBox(
      height: height != null ? height.h : height,
      width: width != null ? width.w : width,
      child: child,
    );
  }

  static ListTile commonListTile({
    required VoidCallback onTap,
    required String text,
    IconData? icon,
    Color? iconColor,
    Color? textColor,
    double? iconSize,
    double? fontSize,
    FontWeight? fontWeight,
    bool? bold,
    String? svgPicturePath,
    double? containerWidth,
    double? containerHeight,
    BoxFit? boxFit,
    EdgeInsets? padding,
  }) {
    return ListTile(
      contentPadding: padding,
      leading: svgPicturePath != ''
          ? CommonWidget.imageBuilder(
              imageUrl: svgPicturePath ?? '',
              fit: boxFit,
              height: containerHeight,
            )
          : Icon(
              icon,
              color: iconColor ?? appConstants.iconColor,
              size: iconSize ?? 20.sp,
              weight: 10,
            ),
      title: commonText(
          text: text,
          color: textColor ?? appConstants.drawerTextColor,
          fontSize: fontSize ?? 14.sp,
          bold: bold ?? false,
          fontWeight: fontWeight ?? FontWeight.w500),
      onTap: onTap,
    );
  }

  Widget iconWithNumber({
    required String svgPicturePath,
    required int number,
    double? height,
    double? containerHeight,
    VoidCallback? onTap,
    double? iconSize,
    BoxFit? boxFit,
    EdgeInsetsGeometry? padding,
    Widget? child,
    double? right,
    double? left,
    double? top,
    double? bottom,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: containerHeight ?? 30.h,
      child: Stack(children: [
        IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset(
            svgPicturePath,
            fit: boxFit ?? BoxFit.contain,
            height: height ?? 20.h,
          ),
          padding: padding ?? const EdgeInsets.all(0),
        ),
        Positioned(
          right: number > 99 ? 7.w : 9.w,
          top: number > 99 ? 0.h : 0.h,
          child: CommonWidget().numberOfnotification(number: number),
        ),
      ]),
    );
  }

  static Future<List<DateTime?>?> datePicker({
    required BuildContext context,
    Size? dialogSize,
    List<DateTime?>? value,
    CalendarDatePicker2Config? config,
    BorderRadius? borderRadius,
    Color? dialogBackgroundColor,
    bool isRangeDatePicker = false,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final configSy = CalendarDatePicker2Config(
      themeColor: appConstants.themeColor,
      calendarType: CalendarDatePicker2Type.single,
      applyButtonSize: Size(140.w, 45.h),
      cancleButtonTextColor: appConstants.white,
      weekNameTextStyle: Theme.of(context).textTheme.caption2BookHeading.copyWith(color: appConstants.black),
      notSelectedDataTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
            color: appConstants.black,
          ),
      selectedDataTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(color: appConstants.white),
      cancleButtonSize: Size(140.w, 45.h),
      spaceBetweenCalenderAndButtons: 15,
      firstDate: DateTime(1930),
    );
    final List<DateTime?>? dateTime = await showCalendarDatePicker2Dialog(
      context: context,
      config: config ?? configSy,
      dialogSize: dialogSize ?? const Size(500, 400),
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      value: value ?? [DateTime.now()],
      dialogBackgroundColor: dialogBackgroundColor ?? Colors.white,
      insetPadding: const EdgeInsets.all(10),
      padding: EdgeInsets.zero,
      isShowButton: false,
    );
    return dateTime;
  }

  static Widget svgPicture({
    required String svgPicturePath,
    BoxFit? boxFit,
    double? height,
    double? width,
    Color? color,
    bool isChangeColor = false,
  }) {
    return SvgPicture.asset(
      svgPicturePath,
      fit: boxFit ?? BoxFit.contain,
      height: height ?? 20.h,
      colorFilter: isChangeColor ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      width: width,
    );
  }

  static Widget pngPicture({
    required String pngPicturePath,
    BoxFit? boxFit,
    double? height,
    double? width,
  }) {
    return Image.asset(
      pngPicturePath,
      fit: boxFit ?? BoxFit.contain,
      height: height ?? 40.h,
      width: width,
    );
  }

  static Widget dataNotFound({
    required BuildContext context,
    String? imagePath,
    String? heading,
    String? subHeading,
    VoidCallback? onTap,
    String? buttonLabel,
    Color? buttonColor,
    EdgeInsetsGeometry? padding,
    Widget? actionButton,
    bool removeImage = false,
    Color? bgColor,
    Color? fontColor,
  }) {
    return container(
      color: bgColor ?? Colors.white,
      alignment: Alignment.center,
      // padding: padding ?? EdgeInsets.only(bottom: 80.h),
      width: ScreenUtil().screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          removeImage
              ? const SizedBox.shrink()
              : CommonWidget.imageBuilder(imageUrl: 'assets/photos/svg/common/no_data.svg', height: 100.h),
          CommonWidget.sizedBox(height: 20),
          CommonWidget.commonText(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            text: heading ?? TranslationConstants.no_data_found.translate(context),
          ),
          sizedBox(height: 10.h),
          CommonWidget.commonText(
            fontSize: 12.sp,
            color: appConstants.familyDetailContainerTextColor,
            text: subHeading?.replaceAll("==", "\n") ??
                TranslationConstants.there_is_no_data_to_show_you.translate(context),
          ),
          CommonWidget.sizedBox(height: 10),
          actionButton ??
              ActionChip(
                backgroundColor: buttonColor ?? appConstants.themeColor,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                label: Text(
                  buttonLabel ?? TranslationConstants.try_again.translate(context).toUpperCase(),
                  style: Theme.of(context).textTheme.body1BoldHeading.copyWith(color: Colors.white, fontSize: 14.sp),
                ),
                onPressed: onTap ?? () {},
              )
        ],
      ),
    );
  }

  static Widget commonButton({
    required BuildContext context,
    required VoidCallback onTap,
    String? text,
    Color? textColor,
    double? borderRadius,
    double? width,
    Color? color,
    EdgeInsets? padding,
    double? height,
    TextStyle? style,
    bool? isBorder = false,
    Color? borderColor,
    double? borderWidth,
    AlignmentGeometry? alignment,
    double? marginAllSide,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    bool? isBorderOnlySide,
    bool? isMarginAllSide = true,
    EdgeInsetsGeometry? margin,
    double? paddingAllSide,
    bool? ispaddingAllSide = false,
    Widget? child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: container(
        height: height,
        width: width,
        margin: margin,
        alignment: alignment,
        isBorder: isBorder,
        borderColor: borderColor,
        borderWidth: borderWidth,
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
        marginAllSide: marginAllSide,
        color: color ?? appConstants.themeColor,
        isBorderOnlySide: isBorderOnlySide,
        padding: padding,
        isMarginAllSide: isMarginAllSide,
        borderRadius: borderRadius ?? 10.r,
        paddingAllSide: paddingAllSide,
        ispaddingAllSide: ispaddingAllSide,
        child: child ??
            commonText(
              text: text ?? '',
              style: style ?? Theme.of(context).textTheme.body1MediumHeading.copyWith(color: textColor),
            ),
      ),
    );
  }

  static void commonImageDialog({required String path, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appConstants.transparent,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                splashColor: appConstants.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () => CommonRouter.pop(),
                child: Container(
                  alignment: Alignment.topRight,
                  height: 38.h,
                  width: double.infinity,
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/customer/cancle_button.svg",
                    color: appConstants.white,
                    height: 30.h,
                  ),
                ),
              ),
              CommonWidget.container(
                paddingAllSide: 2.5,
                borderRadius: 10.r,
                child: CommonWidget.imageBuilder(
                  imageUrl: path,
                  borderRadius: 10.r,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget locationTextFiled({
    required TextEditingController controller,
    required BuildContext context,
  }) {
    return CommonWidget.container(
      isBorder: true,
      borderRadius: 10.r,
      borderColor: appConstants.black12,
      padding: EdgeInsets.all(3.h),
      alignment: Alignment.center,
      child: CommonWidget.textField(
        enabled: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        textInputAction: TextInputAction.done,
        controller: controller,
        // style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
        //       color: appConstants.textColor,
        //     ),
        hintText: TranslationConstants.enter_area_loclity.translate(context),
        // hintStyle: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.neutral4Color),
        hintColor: appConstants.black45,
        issuffixWidget: true,
        suffixWidget: SizedBox(
          width: 70.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40.h,
                child: VerticalDivider(
                  width: 5,
                  color: appConstants.black26,
                  thickness: 1.5.r,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/edit_profile/location.svg",
                  ),
                  CommonWidget.commonText(
                    text: TranslationConstants.use_map.translate(context),
                    // style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(color: appConstants.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static void keyBoardClose({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length == 5 || text.length == 11) {
      final newText = '$text ';
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}
