import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/data/models/purchase_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/screen/purchase_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class PurchaseListWidget extends State<PurchaseListScreen> {
  late PurchaseListCubit purchseListCubit;

  @override
  void initState() {
    purchseListCubit = getItInstance<PurchaseListCubit>();
    super.initState();
  }

  @override
  void dispose() {
    purchseListCubit.close();
    super.dispose();
  }

  Widget searchField() {
    return CommonWidget.container(
      height: 50,
      child: CommonWidget.textField(
        cursorColor: appConstants.themeColor,
        hintText: TranslationConstants.search_here.translate(context),
        prefixWidget: Padding(
          padding: EdgeInsets.all(15.r),
          child: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/customer/search.svg",
            height: 20.h,
            width: 20.w,
          ),
        ),
        contentPadding: EdgeInsets.only(
          right: 15.w,
        ),
        issuffixWidget: true,
        suffixWidget: Padding(
          padding: EdgeInsets.all(15.r),
          child: CommonWidget.imageButton(
            svgPicturePath: "assets/photos/svg/customer/calander.svg",
            iconSize: 20.r,
            boxFit: BoxFit.contain,
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget commonOrderBox(
      {required PurchaseModel purchaseModel,
      required int index,
      required Function() onTap,
      required PurchaseListLoadedState state}) {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.only(bottom: 7.h),
      color: appConstants.white,
      borderRadius: 15.r,
      child: Column(
        children: [
          orderDateAndId(purchaseModel: purchaseModel, index: index),
          Padding(
            padding: EdgeInsets.only(left: 25.w, right: 12.w),
            child: CommonWidget.commonDashLine(),
          ),
          CommonWidget.sizedBox(height: 7),
          suppliernameEditDelete(purchaseModel: purchaseModel, onTap: onTap),
          CommonWidget.sizedBox(height: 7),
          productDetails(purchaseModel: purchaseModel),
          CommonWidget.sizedBox(height: 10),
          discountOrGst(purchaseModel: purchaseModel),
          CommonWidget.sizedBox(height: 7),
          totalOrPayAmount(purchaseModel: purchaseModel),
          CommonWidget.sizedBox(height: 7),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 15.w),
            child: CommonWidget.commonDashLine(),
          ),
          CommonWidget.sizedBox(height: 5),
          pendingOrDeliveryStatus(purchaseModel: purchaseModel, toggleState: state),
        ],
      ),
    );
  }

  Widget suppliernameEditDelete({required PurchaseModel purchaseModel, required Function() onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.supplier_name.translate(context)}:",
                style: TextStyle(fontSize: 12.sp, color: appConstants.black),
              ),
              CommonWidget.commonText(
                text: purchaseModel.supplierName,
                style: TextStyle(fontSize: 12.sp, color: appConstants.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: CommonWidget.container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: CommonWidget.imageBuilder(
                height: 20.h,
                width: 20.w,
                imageUrl: "assets/photos/svg/customer/edit.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showAlertDialog(
                noButtonColor: appConstants.theme7Color,
                context: context,
                isTitle: true,
                titleText: TranslationConstants.confirm_delete.translate(context),
                text: TranslationConstants.sure_delete_purchase.translate(context),
                titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                      color: appConstants.themeColor,
                    ),
                contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                      color: appConstants.textColor,
                    ),
                width: 200.w,
                maxLine: 2,
                onNoTap: () {
                  CommonRouter.pop();
                },
                onTap: onTap,
              );
            },
            splashFactory: InkRipple.splashFactory,
            child: CommonWidget.container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              child: CommonWidget.imageBuilder(
                height: 20.h,
                width: 20.w,
                imageUrl: "assets/photos/svg/customer/delete.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget discountOrGst({required PurchaseModel purchaseModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsvalue(
              title: TranslationConstants.discount.translate(context),
              value: purchaseModel.discount,
              color: appConstants.paidColor),
          detailsvalue(
              title: TranslationConstants.gst_Tax.translate(context),
              value: purchaseModel.gstText,
              color: appConstants.black),
          detailsvalue(
            title: TranslationConstants.gst_amount.translate(context),
            value: purchaseModel.gstAmount.toString(),
            color: appConstants.black,
          ),
        ],
      ),
    );
  }

  Widget totalOrPayAmount({required PurchaseModel purchaseModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsvalue(
              title: TranslationConstants.total_amount.translate(context),
              value: purchaseModel.totalAmount,
              color: appConstants.black),
          detailsvalue(
              title: TranslationConstants.pay_amount.translate(context),
              value: purchaseModel.payAmount,
              color: appConstants.black),
        ],
      ),
    );
  }

  Widget pendingOrDeliveryStatus({required PurchaseModel purchaseModel, required PurchaseListLoadedState toggleState}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsvalue(
              title: TranslationConstants.pending_amount.translate(context),
              value: purchaseModel.pendingAmount,
              color: appConstants.black),
          const Spacer(),
          CommonWidget.commonText(
              text: TranslationConstants.delivery_status.translate(context), style: TextStyle(fontSize: 12.sp)),
          BlocBuilder<PurchaseListCubit, PurchaseListState>(
            bloc: purchseListCubit,
            builder: (context, state) {
              return BlocBuilder<ToggleCubit, bool>(
                bloc: purchseListCubit.deliverystatustoggle,
                builder: (context, state) {
                  return CommonWidget.sizedBox(
                    height: 30,
                    width: 40,
                    child: CommonWidget.toggleButton(
                      value: purchaseModel.deliveryStatus,
                      onChanged: (bool value) {
                        purchseListCubit.updatePurchaseDeliveryStatus(
                          purchaseModel: purchaseModel,
                          deliveryStatus: value,
                          state: toggleState,
                        );
                        purchseListCubit.deliverystatustoggle.setValue(value: value);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget detailsvalue({required String title, required String value, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidget.commonText(text: "$title: ", style: TextStyle(fontSize: 12.sp)),
        CommonWidget.commonText(
          text: value,
          style: TextStyle(fontWeight: FontWeight.w600, color: color, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget orderDateAndId({required PurchaseModel purchaseModel, required int index}) {
    return CommonWidget.container(
      height: 30,
      isBorderOnlySide: true,
      topLeft: 15.r,
      topRight: 15.r,
      color: appConstants.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.container(
            height: 30,
            width: 25,
            isBorderOnlySide: true,
            topLeft: 15.r,
            color: appConstants.editbuttonColor.withOpacity(0.4),
            alignment: Alignment.center,
            child: CommonWidget.commonText(text: "#${index + 1}", fontSize: 14.sp, bold: true),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                    text: TranslationConstants.order_ID.translate(context), bold: true, fontSize: 11.sp),
                CommonWidget.commonText(text: purchaseModel.orderId, color: appConstants.black54, fontSize: 11.sp),
              ],
            ),
          ),
          CommonWidget.sizedBox(width: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonWidget.commonText(
                    text: TranslationConstants.order_date.translate(context), bold: true, fontSize: 11.sp),
                CommonWidget.commonText(text: purchaseModel.orderDate, color: appConstants.black54, fontSize: 11.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetails({required PurchaseModel purchaseModel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            purchaseModel.productList.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(left: 15.r, bottom: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonWidget.commonText(
                      text: "${index + 1}.${purchaseModel.productList[index].productName}",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: CommonWidget.commonText(
                        text: purchaseModel.productList[index].productQuanitiy,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: CommonWidget.commonText(
                        text: purchaseModel.productList[index].productPrice,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Spacer(),
        CommonWidget.container(
          color: appConstants.themeColor,
          isBorderOnlySide: true,
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
          topLeft: 20.r,
          bottomLeft: 20.r,
          alignment: Alignment.center,
          child: CommonWidget.commonText(
            text: TranslationConstants.bill_copy.translate(context),
            color: appConstants.white,
            fontSize: 10.sp,
            bold: true,
          ),
        ),
      ],
    );
  }

  Widget addPurchaseButton() {
    return CommonWidget.container(
      height: 70,
      width: ScreenUtil().screenWidth,
      color: appConstants.white,
      shadow: [
        BoxShadow(
          blurRadius: 5.r,
          color: appConstants.dividerColor,
          offset: const Offset(0, -3),
        )
      ],
      child: Center(
        child: CommonWidget.container(
          height: 40,
          width: ScreenUtil().screenWidth / 1.8,
          borderRadius: 10.r,
          color: appConstants.themeColor,
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/customer/add_new.svg",
                  height: 20.h,
                ),
                CommonWidget.sizedBox(width: 10),
                CommonWidget.commonText(
                  text: TranslationConstants.add_purchase.translate(context),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: appConstants.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
