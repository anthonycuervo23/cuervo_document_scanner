import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/common/extention/theme_extension.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

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
    Color? thumbColor,
    Color? activeTrackColor,
    required bool value,
    required void Function(bool)? onChanged,
  }) {
    return Transform.scale(
      scaleX: 0.8.r,
      scaleY: 0.75.r,
      child: Switch(
        thumbColor: value
            ? MaterialStatePropertyAll<Color>(appConstants.whiteBackgroundColor)
            : MaterialStatePropertyAll<Color>(appConstants.default6Color),
        activeTrackColor: appConstants.primary1Color,
        onFocusChange: (value) {},
        splashRadius: 1,
        inactiveTrackColor: appConstants.default10Color,
        trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
        value: value,
        onChanged: onChanged,
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
    BoxConstraints? constraints,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin ?? EdgeInsets.all(marginAllSide ?? 0),
      padding: padding ?? EdgeInsets.all(paddingAllSide ?? 0),
      alignment: alignment,
      constraints: constraints,
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border.all(
                color: borderColor ?? appConstants.default1Color,
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
        color: color ?? appConstants.whiteBackgroundColor,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static gestureHideKeyboard(BuildContext context, {required Widget child}) {
    return GestureDetector(
      onVerticalDragDown: (_) {
        keyboardClose(context: context);
      },
      behavior: HitTestBehavior.opaque,
      onTap: () {
        keyboardClose(context: context);
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
      child: CircleAvatar(backgroundColor: color ?? appConstants.primary1Color, radius: size),
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
      textAlign: textAlign,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            height: height,
            color: color ?? appConstants.textColor,
            fontSize: fontSize?.sp ?? 14.sp,
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
          color: index % 2 == 0 ? Colors.transparent : color ?? appConstants.default7Color,
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
      color: iconColor ?? appConstants.default1Color,
      size: iconSize?.sp ?? 32.sp,
    );
  }

  static Future<bool> showAlertDialog({
    required BuildContext context,
    required String text,
    String? titleText,
    Color? textColor,
    bool isTitle = false,
    List<Widget>? actions,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
  }) async {
    bool data = false;
    await showDialog(
      context: context,
      barrierColor: appConstants.default2Color,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          surfaceTintColor: appConstants.greyBackgroundColor,
          backgroundColor: appConstants.greyBackgroundColor,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actionsPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: sizedBox(
            width: ScreenUtil().screenWidth * 0.9,
            child: Column(
              children: [
                sizedBox(height: 20),
                isTitle
                    ? Column(
                        children: [
                          Center(
                            child: commonText(
                              lineThrough: true,
                              style: titleTextStyle ??
                                  Theme.of(context)
                                      .textTheme
                                      .subTitle2BoldHeading
                                      .copyWith(color: appConstants.default1Color, height: 1),
                              text: titleText ?? '',
                            ),
                          ),
                          sizedBox(height: 15),
                        ],
                      )
                    : const SizedBox.shrink(),
                commonText(
                  textAlign: TextAlign.center,
                  text: text,
                  style: contentTextStyle ?? Theme.of(context).textTheme.body1MediumHeading.copyWith(color: textColor),
                ),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CommonWidget.commonLinearGradient(
                            child: commonButton(
                              context: context,
                              alignment: Alignment.center,
                              onTap: () {
                                data = false;
                                return CommonRouter.pop(args: false);
                              },
                              text: TranslationConstants.no.translate(context),
                              textColor: appConstants.whiteBackgroundColor,
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                            ),
                          ),
                        ),
                      ),
                      sizedBox(width: 15),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CommonWidget.commonLinearGradient(
                            child: commonButton(
                              context: context,
                              alignment: Alignment.center,
                              onTap: () {
                                data = true;
                                return CommonRouter.pop(args: true);
                              },
                              text: TranslationConstants.yes.translate(context),
                              textColor: appConstants.whiteBackgroundColor,
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    return data;
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
          color: textColor ?? appConstants.primary1Color,
          fontSize: fontSize ?? 12.sp,
          fontWeight: bold == true ? fontWeight ?? FontWeight.w500 : FontWeight.normal,
          style: textStyle,
        ),
      ),
    );
  }

  static Widget textField({
    FocusNode? focusNode,
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
    int? minLines,
    double? fontSize,
    FontWeight? fontWeight,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    String? hintText,
    double? hintSize,
    double? prefixIconHeight,
    double? horizontalContentPadding,
    double? verticalContentPadding,
    FontWeight? hintWeight,
    Color? hintColor,
    Color? focusedBorderColor,
    Color? fillColor,
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
    // void Function(String)? onChange,
    void Function(String)? onSubmitted,
    void Function()? onEditingComplete,
    Function(String, Map<String, dynamic>)? onAppPrivateCommand,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? hintStyle,
    TextStyle? style,
    List<TextInputFormatter>? inputFormatters,
    required BuildContext context,
  }) {
    return TextField(
      focusNode: focusNode,
      scrollController: scrollController,
      scrollPadding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
      inputFormatters: inputFormatters,
      onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onAppPrivateCommand: onAppPrivateCommand,
      maxLines: maxLines,
      enabled: enabled,
      onChanged: onChanged,

      obscureText: obscureText ?? false,
      textInputAction: textInputAction ?? TextInputAction.done,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.number,
      cursorColor: cursorColor ?? appConstants.primary1Color,
      cursorHeight: cursorHight,
      autofocus: autoFocus ?? false,
      maxLength: maxLength ?? 150,
      minLines: minLines ?? 1,
      style: style,
      // TextStyle(
      //   color: textColor ?? appConstants.black,
      //   fontSize: fontSize ?? 16.sp,
      //   fontWeight: fontWeight ?? FontWeight.w400,
      //   fontFamily: 'Circular Std',
      // ),
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? appConstants.default1Color,
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
                    ),
                  )
                : null,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.default6Color),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor ?? appConstants.primary1Color),
          borderRadius: BorderRadius.circular(10.r),
        ),
        disabledBorder: InputBorder.none,
        counterText: "",
        hintText: hintText,
        hintStyle: hintStyle ??
            hintstyle ??
            TextStyle(
              fontSize: hintSize ?? 16.sp,
              fontWeight: hintWeight ?? FontWeight.w400,
              color: hintColor ?? appConstants.default6Color,
            ),
      ),
    );
  }

  static Widget warningIcon({double? width, double? height, Color? color, Alignment? alignment, Color? bgColor}) {
    return Container(
      color: bgColor,
      child: Center(
        child: SvgPicture.asset(
          "assets/photos/svg/common/warning.svg",
          width: width ?? 32.w,
          height: height ?? 32.h,
          colorFilter: ColorFilter.mode(color ?? appConstants.primary1Color, BlendMode.srcIn),
          alignment: alignment ?? Alignment.center,
        ),
      ),
    );
  }

  static Widget loadingIos({Color? loaderColor}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: sizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: 1 == 1
                ? Lottie.asset('assets/animation/loading.json')
                : 1 == 1
                    ? Center(
                        child: CircularProgressIndicator(
                          color: appConstants.primary1Color,
                          strokeWidth: 2,
                          backgroundColor: appConstants.default6Color,
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
      if (imageUrl.endsWith('svg')) {
        return SvgPicture.network(
          imageUrl,
          fit: fit ?? BoxFit.fitWidth,
          width: width,
          height: height,
          colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
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
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit ?? BoxFit.cover,
            memCacheWidth: cacheWidth,
            color: color,
            height: height,
            width: width,
            placeholder: (context, url) => sizedBox(
              height: height,
              width: width,
              child: loadingIos(loaderColor: color),
            ),
            errorWidget: (context, error, stackTrace) => warningIcon(
              color: color,
              bgColor: Colors.grey.withOpacity(0.15),
            ),
          ),
        );
      }
    } else if (imageUrl.startsWith('assets') && imageUrl.endsWith('.svg')) {
      return SvgPicture.asset(
        imageUrl,
        fit: fit ?? BoxFit.fitWidth,
        width: width,
        height: height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    } else if (imageUrl.startsWith('assets')) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
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
      return Image.file(
        File(imageUrl),
        fit: fit ?? BoxFit.fitWidth,
        width: width,
        height: height,
        color: color,
        cacheWidth: cacheWidth,
        errorBuilder: (context, error, stackTrace) => warningIcon(color: color),
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
              borderRadius: borderRadius ?? boaderRadius(10.r),
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
              ),
            ),
          ),
          placeholder: (context, url) => Center(child: CommonWidget.loadingIos()),
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
    return sizedBox(
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

  static Widget sizedBox({
    double? width,
    double? height,
    Widget? child,
  }) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: child,
    );
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
      color: bgColor ?? appConstants.greyBackgroundColor,
      alignment: Alignment.center,
      // padding: padding ?? EdgeInsets.only(bottom: 80.h),
      width: ScreenUtil().screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          removeImage
              ? const SizedBox.shrink()
              : imageBuilder(imageUrl: 'assets/photos/svg/common/no_data.svg', height: 100.h),
          sizedBox(height: 20),
          commonText(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            text: heading ?? TranslationConstants.no_data_found.translate(context),
          ),
          sizedBox(height: 10),
          commonText(
            fontSize: 12.sp,
            color: appConstants.default4Color,
            text: subHeading?.replaceAll("==", "\n") ??
                TranslationConstants.there_is_no_data_to_show_you.translate(context),
            textAlign: TextAlign.center,
          ),
          sizedBox(height: 12),
          actionButton ??
              CommonWidget.commonButton(
                height: 38.h,
                width: 120.w,
                borderRadius: 10,
                context: context,
                alignment: Alignment.center,
                onTap: onTap ?? () {},
                text: buttonLabel ?? TranslationConstants.try_again.translate(context),
                style: Theme.of(context).textTheme.body1RegularHeading.copyWith(color: appConstants.primary1Color),
              ),
        ],
      ),
    );
  }

  static Widget commonButton({
    required String text,
    required BuildContext context,
    required VoidCallback onTap,
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
        color: color ?? appConstants.primary1Color,
        isBorderOnlySide: isBorderOnlySide,
        padding: padding,
        isMarginAllSide: isMarginAllSide,
        borderRadius: borderRadius ?? 12.r,
        paddingAllSide: paddingAllSide,
        ispaddingAllSide: ispaddingAllSide,
        child: child ??
            commonText(
              text: text,
              style: style ?? Theme.of(context).textTheme.body1MediumHeading.copyWith(color: textColor),
            ),
      ),
    );
  }

  static void keyboardClose({required BuildContext context}) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusScope.of(context).unfocus();
    }
    currentFocus.focusedChild;
  }

  // flexibleSpace: CommonWidget.commonLinearGradient(),
  static Container commonLinearGradient({Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: const [0.01, 0.9],
          colors: <Color>[
            appConstants.gradiantColor1,
            appConstants.gradiantColor2,
          ],
        ),
      ),
      child: child,
    );
  }

  static Container commonPoint({Widget? child}) {
    return Container(
      height: 10.r,
      width: 10.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: const [0.01, 0.9],
          colors: <Color>[
            appConstants.gradiantColor1,
            appConstants.gradiantColor2,
          ],
        ),
      ),
      child: child,
    );
  }
}
