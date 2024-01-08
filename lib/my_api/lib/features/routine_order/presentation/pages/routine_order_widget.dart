import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/cubit/routine_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/routine_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class RoutinOrderWidget extends State<RotineOrderScreen> {
  late RoutineOrderCubit routineOrderCubit;

  @override
  void initState() {
    routineOrderCubit = getItInstance<RoutineOrderCubit>();
    super.initState();
  }

  @override
  void dispose() {
    routineOrderCubit.loadingCubit.close();
    routineOrderCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.routine_order.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget searchFieldAndFilter() {
    return CommonWidget.container(
      color: appConstants.white,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: commonSearchAndFilterField(
          context: context,
          controller: TextEditingController(),
          onChanged: (p0) {},
          onTapForFilter: () {},
          onTapSearchCalenderButton: () {},
        ),
      ),
    );
  }

  Widget commonBox({required int index}) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(RouteList.routine_order_detail_screen),
      child: CommonWidget.container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        shadow: [
          BoxShadow(
            color: appConstants.shadowColor1,
            blurRadius: 10,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          )
        ],
        borderRadius: 10.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            personalDetails(index: index),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CommonWidget.commonDashLine(),
            ),
            CommonWidget.sizedBox(height: 5),
            priceDetails(),
            CommonWidget.sizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget personalDetails({required int index}) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.container(
            isBorderOnlySide: true,
            topLeft: 10.r,
            height: 25.r,
            width: 25.r,
            color: appConstants.containerBgColor,
            alignment: Alignment.center,
            child: CommonWidget.commonText(
              text: '#${index + 1}',
              bold: true,
              fontSize: 11,
            ),
          ),
          CommonWidget.sizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.sizedBox(
                          height: 25.h,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CommonWidget.commonText(
                              text: 'Karan Parekh',
                              textAlign: TextAlign.start,
                              bold: true,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        CommonWidget.commonText(
                          text: 'Mo. +919876543210',
                          textAlign: TextAlign.start,
                          fontSize: 12,
                          color: appConstants.lightGrey4,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => CommonWidget.showAlertDialog(
                        maxLines: 2,
                        leftColor: appConstants.theme1Color.withOpacity(0.2),
                        context: context,
                        onTap: () => routineOrderCubit.deleteItem(index: index),
                        text: TranslationConstants.delete_warning.translate(context),
                        textColor: appConstants.black,
                        isTitle: true,
                        titleText: TranslationConstants.confirm_delete.translate(context),
                        titleTextStyle: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: appConstants.theme1Color,
                        ),
                      ),
                      child: CommonWidget.sizedBox(
                        height: 25.r,
                        child: Center(
                          child: CommonWidget.imageBuilder(
                            imageUrl: 'assets/photos/svg/common/trash.svg',
                            height: 16.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CommonWidget.sizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonWidget.commonText(
                        text: '4012, palladium Mall, Yogi Chowk,Surat-395010.',
                        textAlign: TextAlign.start,
                        fontSize: 12,
                      ),
                    ),
                    CommonWidget.commonText(
                      text: '15/10/2023',
                      fontSize: 12,
                      color: appConstants.lightGrey4,
                    )
                  ],
                ),
                CommonWidget.sizedBox(height: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDetails() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: totalAndPendingAmount(),
          ),
          CommonWidget.sizedBox(width: 20),
          payAmountAndBalance(),
          viewOrder(),
        ],
      ),
    );
  }

  Widget viewOrder() {
    return CommonWidget.container(
      alignment: Alignment.center,
      isBorderOnlySide: true,
      topLeft: 16.r,
      bottomLeft: 16.r,
      height: 26.h,
      width: 70.w,
      color: appConstants.themeColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: CommonWidget.commonText(
          text: TranslationConstants.view_order.translate(context),
          fontSize: 10,
          color: appConstants.white,
        ),
      ),
    );
  }

  Widget payAmountAndBalance() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.pay_amount.translate(context),
                fontSize: 12,
              ),
              textValue(text: '₹200'),
            ],
          ),
          Row(
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.balance.translate(context),
                fontSize: 12,
              ),
              textValue(text: ': ₹1000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalAndPendingAmount() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.total_amount.translate(context),
              fontSize: 12,
            ),
            textValue(text: '₹850'),
          ],
        ),
        Row(
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.pending_amount.translate(context),
              fontSize: 11,
            ),
            textValue(text: '₹650'),
          ],
        ),
      ],
    );
  }

  Widget textValue({required String text}) {
    return Expanded(
      child: CommonWidget.commonText(
        text: text,
        textAlign: TextAlign.start,
        bold: true,
        fontSize: 12,
      ),
    );
  }
}
