import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/return_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ReturnOrderWidget extends State<ReturnOrderScreen> {
  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.return_order.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget commonOrderBox({required int index}) {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.only(bottom: 7.h),
      shadow: [
        BoxShadow(
          color: appConstants.shadowColor1,
          blurRadius: 10,
          offset: const Offset(0, 6),
          spreadRadius: 0,
        )
      ],
      color: Colors.white,
      borderRadius: 15.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          orderDateAndId(index: index),
          customerDetail(),
          productDetails(),
          centerView(),
          SizedBox(height: 7.h),
          CommonWidget.commonDashLine(),
          SizedBox(height: 5.h),
          productPrice(),
        ],
      ),
    );
  }

  Widget orderDateAndId({required int index}) {
    return CommonWidget.container(
      height: 30.h,
      isBorderOnlySide: true,
      topLeft: 15.r,
      topRight: 15.r,
      color: const Color(0xffFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.container(
            height: 35.h,
            width: 25.w,
            isBorderOnlySide: true,
            topLeft: 15.r,
            color: const Color(0xffBBDAFF),
            alignment: Alignment.center,
            child: allText(text: "#${index + 1}", fontSize: 14.sp, bold: true),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            allText(text: TranslationConstants.order_ID.translate(context), bold: true),
                            Expanded(
                              child: allText(text: '5842687500758426875007', color: appConstants.lightGrey4),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            allText(text: TranslationConstants.order_date.translate(context), bold: true),
                            Expanded(child: allText(text: '10/12/2023', color: appConstants.lightGrey4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CommonWidget.commonDashLine(isLeft: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customerDetail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        children: [
          allText(text: TranslationConstants.customer_name.translate(context), fontSize: 12.sp),
          allText(text: ': Samir Patel', fontSize: 12.sp, bold: true),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CommonWidget.svgIconButton(
              onTap: () {},
              svgPicturePath: 'assets/photos/svg/common/edit.svg',
              color: appConstants.neutral1Color,
              iconSize: 16.sp,
            ),
          ),
          CommonWidget.svgIconButton(
            svgPicturePath: 'assets/photos/svg/common/trash.svg',
            color: appConstants.neutral1Color,
            iconSize: 16.sp,
            onTap: () {
              CommonWidget.showAlertDialog(
                maxLines: 2,
                leftColor: appConstants.theme1Color.withOpacity(0.2),
                context: context,
                onTap: () {},
                text: TranslationConstants.delete_warning.translate(context),
                textColor: appConstants.black,
                isTitle: true,
                titleText: TranslationConstants.confirm_delete.translate(context),
                titleTextStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: appConstants.theme1Color,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget productDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                3,
                (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.w),
                      SizedBox(width: 20.w, child: allText(text: "${index + 1}. ")),
                      Expanded(child: allText(text: 'Brown Breads', textAlign: TextAlign.start)),
                      SizedBox(width: 70.w, child: allText(text: '1Kg')),
                      allText(text: '₹170'),
                      SizedBox(width: 10.w),
                    ],
                  );
                },
              ),
            ),
          ),
          CommonWidget.container(
            height: 30.h,
            width: 70.w,
            color: const Color(0xff084277),
            isBorderOnlySide: true,
            topLeft: 20.r,
            bottomLeft: 20.r,
            alignment: Alignment.center,
            child: allText(text: "Bill Copy", color: Colors.white, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }

  Widget centerView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    allText(text: TranslationConstants.reason_of_return.translate(context), bold: true),
                    Expanded(child: allText(text: ": End of Expire Date", color: appConstants.lightGrey4)),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              Row(
                children: [
                  allText(text: TranslationConstants.return_amount.translate(context), bold: true),
                  allText(text: ": ₹170", bold: true, color: const Color(0xff4392F1)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  allText(text: TranslationConstants.return_date.translate(context), bold: true),
                  allText(text: ": 13/12/2023", color: appConstants.lightGrey4),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    allText(text: TranslationConstants.collected_by.translate(context), bold: true),
                    Expanded(child: allText(text: ": Rajendra Saho", color: appConstants.lightGrey4)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productPrice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          allText(text: TranslationConstants.total_amount.translate(context)),
          Expanded(
            child: allText(
              text: int.parse('10000').formatCurrency(),
              textAlign: TextAlign.start,
              bold: true,
            ),
          ),
          allText(text: TranslationConstants.delivery_status.translate(context)),
          allText(
            text: 'Done',
            color: appConstants.editbuttonColor,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget allText({bool? bold, double? fontSize, Color? color, required String text, TextAlign? textAlign}) {
    return CommonWidget.commonText(
      text: text,
      textAlign: textAlign,
      color: color ?? appConstants.neutral1Color,
      fontSize: fontSize ?? 11.sp,
      bold: bold ?? false,
    );
  }

  Container bottomBar() {
    return Container(
      height: 80.h,
      width: newDeviceType == NewDeviceType.phone
          ? ScreenUtil().screenWidth
          : newDeviceType == NewDeviceType.tablet
              ? ScreenUtil().screenWidth
              : double.infinity,
      color: Colors.white,
      child: Center(
        child: GestureDetector(
          onTap: () => CommonRouter.pushNamed(RouteList.add_return_order_screen),
          child: Container(
            height: 40.h,
            width: newDeviceType == NewDeviceType.phone
                ? 200.w
                : newDeviceType == NewDeviceType.tablet
                    ? ScreenUtil().screenWidth / 1.5
                    : ScreenUtil().screenWidth / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: const Color(0xff084277),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/customer/add_new.svg",
                  height: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  TranslationConstants.add_new.translate(context),
                  style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
