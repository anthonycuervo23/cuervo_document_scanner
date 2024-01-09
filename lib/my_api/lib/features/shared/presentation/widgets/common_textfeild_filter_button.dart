import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget filterButton({required BuildContext context, required void Function() onTap}) {
  return InkWell(
    onTap: () {
      CommonWidget.keyBoardClose(context: context);
      onTap.call();
    },
    splashFactory: NoSplash.splashFactory,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xffD3E8FF),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            "Filter",
            style: newDeviceType == NewDeviceType.phone
                ? TextStyle(fontSize: 15.sp, color: Colors.black)
                : newDeviceType == NewDeviceType.tablet
                    ? TextStyle(fontSize: 20.sp, color: Colors.black)
                    : TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            height: newDeviceType == NewDeviceType.phone
                ? 15.h
                : newDeviceType == NewDeviceType.tablet
                    ? 20.h
                    : 20.h,
            width: newDeviceType == NewDeviceType.phone
                ? 18.w
                : newDeviceType == NewDeviceType.tablet
                    ? 25.w
                    : 18.w,
            child: CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/customer/filter.svg"),
          ),
        ],
      ),
    ),
  );
}

Widget textField({
  required BuildContext context,
  required void Function() onTap,
  required TextEditingController controller,
  required void Function(String)? onChanged,
  double? width,
  double? hight,
  double? borderRadius,
  bool isSufix = false,
}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
    height: newDeviceType == NewDeviceType.phone
        ? 60.h
        : newDeviceType == NewDeviceType.tablet
            ? 50.h
            : 40.h,
    width: newDeviceType == NewDeviceType.phone
        ? width ?? 230.w
        : newDeviceType == NewDeviceType.tablet
            ? 410.w
            : ScreenUtil().screenWidth / 1.2,
    child: TextField(
      onChanged: onChanged,
      controller: controller,
      onTapOutside: (e) {
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      cursorColor: const Color(0xff4392F1),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: newDeviceType == NewDeviceType.phone
              ? const EdgeInsets.all(15)
              : newDeviceType == NewDeviceType.tablet
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(10),
          child: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/customer/search.svg",
            height: hight ?? 20.h,
            width: 20.w,
          ),
        ),
        suffixIcon: isSufix
            ? InkWell(
                onTap: () {
                  CommonWidget.keyBoardClose(context: context);
                  onTap.call();
                },
                child: textFeildIcon(),
              )
            : const SizedBox.shrink(),
        hintText: TranslationConstants.search_here.translate(context),
        hintStyle: TextStyle(color: appConstants.hintTextColor),
        contentPadding: newDeviceType == NewDeviceType.phone
            ? EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h)
            : newDeviceType == NewDeviceType.tablet
                ? EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h)
                : EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(
            color: Color(0xffD3E8FF),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(
            color: Color(0xffD3E8FF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(
            color: Color(0xffD3E8FF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(
            color: Color(0xff4392F1),
          ),
        ),
      ),
    ),
  );
}

Widget commonSearchAndFilterField({
  required BuildContext context,
  required void Function() onTapSearchCalenderButton,
  required void Function() onTapForFilter,
  required void Function(String)? onChanged,
  required TextEditingController controller,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      textField(
        context: context,
        onTap: onTapSearchCalenderButton,
        controller: controller,
        onChanged: onChanged,
        isSufix: true,
      ),
      filterButton(context: context, onTap: onTapForFilter),
    ],
  );
}

Widget textFeildIcon() {
  return newDeviceType == NewDeviceType.phone
      ? imageView(padding: EdgeInsets.only(right: 1.w, top: 12.h, bottom: 12.h))
      : newDeviceType == NewDeviceType.tablet
          ? imageView(padding: EdgeInsets.only(right: 10.w, top: 5.h, bottom: 5.h))
          : imageView(padding: EdgeInsets.only(right: 5.w, top: 5.h, bottom: 5.h));
}

Widget imageView({required EdgeInsetsGeometry padding}) {
  return Padding(
    padding: padding,
    child: CommonWidget.imageBuilder(
      imageUrl: "assets/photos/svg/customer/calander.svg",
      height: 10.h,
      width: 10.w,
      fit: BoxFit.contain,
    ),
  );
}
