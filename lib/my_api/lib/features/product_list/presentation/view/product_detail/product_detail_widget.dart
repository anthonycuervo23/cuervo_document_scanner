import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_detail/product_detail_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_detail/product_detail_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductDetailWidget extends State<ProductDetailScreen> {
  late ProductDetailCubit productDetailCubit;

  @override
  void initState() {
    productDetailCubit = getItInstance<ProductDetailCubit>();
    super.initState();
  }

  @override
  void dispose() {
    productDetailCubit.close();
    super.dispose();
  }

  Widget productDetails() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 18.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.imageBuilder(
            imageUrl: widget.productModel.image,
            height: 110.r,
            width: 110.r,
            borderRadius: 8.r,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: widget.productModel.itemName,
                    style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w500, fontSize: 15.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: "(500gm)",
                        style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: CommonWidget.container(
                          borderRadius: 15.r,
                          color: appConstants.hotfavouritColor,
                          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                          child: CommonWidget.commonText(
                            text: TranslationConstants.new_arrival.translate(context),
                            style: TextStyle(
                                fontSize: 9.sp, fontWeight: FontWeight.w500, color: appConstants.editbuttonColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonWidget.commonText(
                          text: "${TranslationConstants.category.translate(context)}:",
                          style:
                              TextStyle(color: appConstants.appliveColor, fontWeight: FontWeight.w400, fontSize: 11.sp),
                        ),
                        CommonWidget.sizedBox(width: 3),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: CommonWidget.commonText(
                            text: "Cakes",
                            style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600, fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: "${TranslationConstants.brand.translate(context)}:",
                        style:
                            TextStyle(color: appConstants.appliveColor, fontWeight: FontWeight.w400, fontSize: 11.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: CommonWidget.commonText(
                          text: "Bakingo",
                          style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600, fontSize: 11.sp),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/star_icon.svg",
                        height: 12.h,
                        width: 12.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: CommonWidget.commonText(
                          text: widget.productModel.rating.toString(),
                          style: TextStyle(fontSize: 12.sp, color: appConstants.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          //CommonRouter.pushNamed(RouteList.catalogue_screen);
                        },
                        child: CommonWidget.container(
                          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
                          borderRadius: 5.r,
                          borderColor: appConstants.editbuttonColor,
                          isBorder: true,
                          child: CommonWidget.commonText(
                            text: TranslationConstants.view_catalogue.translate(context),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: appConstants.editbuttonColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productDiscription() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 4.h, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.selling_price.translate(context),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
                  ),
                  CommonWidget.commonText(
                    text: widget.productModel.sellingPrice.toString(),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.discount.translate(context),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
                  ),
                  CommonWidget.commonText(
                    text: widget.productModel.discount.toString(),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.after_discount_price.translate(context),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
                  ),
                  CommonWidget.commonText(
                    text: widget.productModel.price.toString(),
                    style: TextStyle(fontSize: 13.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CommonWidget.commonDashLine(),
          ),
          weightQuantityPoint(
            title: TranslationConstants.product_attributes.translate(context),
            details: "Weight",
            textStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: appConstants.black),
          ),
          weightQuantityPoint(
            title: TranslationConstants.stock_quantity.translate(context),
            details: "100 PCS",
            textStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: appConstants.black),
          ),
          weightQuantityPoint(
            title: TranslationConstants.stock_value.translate(context),
            details: "₹ 5,000",
            textStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: appConstants.black),
          ),
          weightQuantityPoint(
            title: TranslationConstants.self_point.translate(context),
            details: widget.productModel.selfPoint.toString(),
            textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: appConstants.selfpointColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.referral_point.translate(context),
                  style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    referralPointDialog(context: context);
                  },
                  child: CommonWidget.container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 2.h),
                    borderRadius: 15.r,
                    color: appConstants.viewContainerBackGroundColor,
                    child: CommonWidget.commonText(
                      text: TranslationConstants.view.translate(context),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: appConstants.editbuttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.pin_priority.translate(context),
                style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
              ),
              CommonWidget.imageButton(
                svgPicturePath: "assets/photos/svg/product_details/pin.svg",
                color: appConstants.pinColor,
                iconSize: 17.r,
                boxFit: BoxFit.contain,
                onTap: () {},
              ),
            ],
          ),
          weightQuantityPoint(
            title: TranslationConstants.app_live_status.translate(context),
            details: widget.productModel.isActive ? "ON" : "OFF",
            textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: widget.productModel.isActive ? appConstants.black : appConstants.appliveColor,
            ),
          ),
          weightQuantityPoint(
            title: TranslationConstants.selling_status_detail.translate(context),
            details: widget.productModel.sellingStatus.toString(),
            textStyle: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: appConstants.appliveColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CommonWidget.commonDashLine(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.discriptions.translate(context),
                style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return bulletPoint(text: "This delicacy is made of three mushy layers of Black forest cake.");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget weightQuantityPoint({
    required String title,
    required String details,
    required TextStyle textStyle,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: title,
            style: TextStyle(fontSize: 13.sp, color: appConstants.appliveColor, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          CommonWidget.commonText(text: details, style: textStyle),
        ],
      ),
    );
  }

  Widget bulletPoint({required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 6.w, left: 8.w),
            child: CommonWidget.commonBulletPoint(size: 2.h, color: appConstants.black),
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 292.w),
            child: CommonWidget.commonText(
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: appConstants.black,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.start,
              text: text,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  referralPointDialog({required BuildContext context}) {
    showDialog(
        context: context,
        barrierColor: appConstants.barriarColor,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
            surfaceTintColor: appConstants.white,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.referral_points.translate(context),
                        style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 13.sp),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          CommonRouter.pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 25.r,
                          color: appConstants.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 10.h),
                    child: buildTable(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildTable() {
    return FittedBox(
      alignment: Alignment.center,
      child: DataTable(
        headingTextStyle: TextStyle(color: appConstants.white),
        headingRowColor: MaterialStatePropertyAll(appConstants.theme1Color),
        dataRowColor: MaterialStatePropertyAll(appConstants.white),
        columnSpacing: 0,
        horizontalMargin: 0,
        clipBehavior: Clip.antiAlias,
        border: TableBorder(borderRadius: BorderRadius.circular(10.r)),
        headingRowHeight: 50.h,
        dataRowMaxHeight: 50.h,
        columns: [
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "#",
              boxColor: appConstants.theme1Color,
              width: 50.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "Level",
              boxColor: appConstants.theme1Color,
              width: 200.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "Point",
              boxColor: appConstants.theme1Color,
              width: 100.w,
              textColor: appConstants.white,
            ),
          ),
        ],
        rows: referPointModel
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.count,
                      boxColor: appConstants.white,
                      width: 50.w,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.levels,
                      boxColor: appConstants.white,
                      width: 200.w,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.point.toString(),
                      boxColor: appConstants.white,
                      width: 100.w,
                      textColor: appConstants.black,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget containtBox({
    required Color boxColor,
    required String text,
    required Color borderColor,
    required double width,
    required Color textColor,
    List<ReferPointModel>? list,
    bool isOpenDialog = false,
    double? padding,
  }) {
    return InkWell(
      onTap: () {},
      child: CommonWidget.container(
        width: width,
        isBorder: true,
        padding: EdgeInsets.only(left: padding ?? 0),
        borderColor: borderColor,
        borderWidth: 1,
        isBorderOnlySide: true,
        color: boxColor,
        alignment: padding == null ? Alignment.center : Alignment.centerLeft,
        child: CommonWidget.commonText(
          color: textColor,
          fontSize: 15.sp,
          textAlign: TextAlign.center,
          text: text,
          maxLines: 2,
        ),
      ),
    );
  }
}
