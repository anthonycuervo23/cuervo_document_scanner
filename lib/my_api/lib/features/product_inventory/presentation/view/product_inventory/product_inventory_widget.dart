import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/product_inventory/product_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/product_inventory/product_inventory_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductInventoryWidget extends State<ProductInventoryScreen> {
  late ProductInventoryCubit productInventoryCubit;
  dynamic selectedGroupValue;
  String? selectedValue;

  @override
  void initState() {
    productInventoryCubit = getItInstance<ProductInventoryCubit>();
    super.initState();
  }

  @override
  void dispose() {
    productInventoryCubit.close();
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

  Widget commonInventoryBox(
      {required ProductInventoryModel productInventoryModel, required int index, required Function() onTap}) {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.only(bottom: 7.h),
      color: appConstants.white,
      borderRadius: 15.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          orderDateAndId(productInventoryModel: productInventoryModel, index: index),
          SizedBox(height: 0.h),
          Container(
            width: ScreenUtil().screenWidth,
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: CommonWidget.commonDashLine(),
              ),
            ),
          ),
          SizedBox(height: 7.h),
          editDeleteAction(productInventoryModel: productInventoryModel, onTap: onTap),
          SizedBox(height: 10.h),
          buyingPriceOrStock(productInventoryModel: productInventoryModel),
          SizedBox(height: 7.h),
          gstTaxOrAmount(productInventoryModel: productInventoryModel),
        ],
      ),
    );
  }

  Widget orderDateAndId({required ProductInventoryModel productInventoryModel, required int index}) {
    return CommonWidget.container(
      height: 30,
      isBorderOnlySide: true,
      topLeft: 15.r,
      topRight: 15.r,
      color: appConstants.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                CommonWidget.commonText(
                    text: productInventoryModel.orderId ?? '', color: appConstants.black54, fontSize: 11.sp),
              ],
            ),
          ),
          CommonWidget.sizedBox(width: 5.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                      text: TranslationConstants.order_date.translate(context), bold: true, fontSize: 11.sp),
                  CommonWidget.commonText(
                      text: productInventoryModel.orderDate ?? '', color: appConstants.black54, fontSize: 11.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editDeleteAction({required ProductInventoryModel productInventoryModel, required Function() onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            text: productInventoryModel.productName ?? '',
            style: TextStyle(fontSize: 14.sp, color: appConstants.black),
          ),
          CommonWidget.sizedBox(width: 5),
          CommonWidget.commonText(
            text: productInventoryModel.productwait ?? '',
            style: TextStyle(fontSize: 14.sp, color: appConstants.grey),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              CommonRouter.pushNamed(RouteList.add_inventory_screen, arguments: productInventoryModel);
            },
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
                  text: TranslationConstants.sure_delete_product_inventory.translate(context),
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
                  onTap: onTap);
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

  Widget buyingPriceOrStock({required ProductInventoryModel productInventoryModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsvalue(
            title: TranslationConstants.buying_price.translate(context),
            value: productInventoryModel.buyingPrice ?? '',
            color: appConstants.black,
            titleStyle: TextStyle(fontSize: 14.sp),
            valueStyle: TextStyle(fontWeight: FontWeight.w600, color: appConstants.black, fontSize: 14.sp),
          ),
          detailsvalue(
            title: TranslationConstants.stock.translate(context),
            value: productInventoryModel.stock ?? '',
            color: appConstants.black,
            titleStyle: TextStyle(fontSize: 14.sp),
            valueStyle: TextStyle(fontWeight: FontWeight.w600, color: appConstants.black, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget gstTaxOrAmount({required ProductInventoryModel productInventoryModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          detailsvalue(
            title: TranslationConstants.gst_Tax.translate(context),
            value: productInventoryModel.gstText ?? '',
            color: appConstants.black,
            titleStyle: TextStyle(fontSize: 12.sp),
            valueStyle: TextStyle(fontWeight: FontWeight.w600, color: appConstants.black, fontSize: 12.sp),
          ),
          detailsvalue(
            title: TranslationConstants.gst_amount.translate(context),
            value: productInventoryModel.gstAmount.toString(),
            color: appConstants.black,
            titleStyle: TextStyle(fontSize: 12.sp),
            valueStyle: TextStyle(fontWeight: FontWeight.w600, color: appConstants.black, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget detailsvalue(
      {required String title,
      required String value,
      required Color color,
      TextStyle? titleStyle,
      TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidget.commonText(text: "$title: ", style: titleStyle),
        CommonWidget.commonText(
          text: value,
          style: valueStyle,
        ),
      ],
    );
  }

  Widget addInventoryButton() {
    return CommonWidget.container(
      height: 80,
      width: ScreenUtil().screenWidth,
      color: appConstants.white,
      padding: EdgeInsets.symmetric(horizontal: 70.w),
      shadow: [
        BoxShadow(
          blurRadius: 5.r,
          color: appConstants.dividerColor,
          offset: const Offset(0, -3),
        )
      ],
      child: Center(
        child: CommonWidget.container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          borderRadius: 10.r,
          color: appConstants.themeColor,
          child: GestureDetector(
            onTap: () {
              CommonRouter.pushNamed(RouteList.add_inventory_screen);
            },
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
                  text: TranslationConstants.add_inventory.translate(context),
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
