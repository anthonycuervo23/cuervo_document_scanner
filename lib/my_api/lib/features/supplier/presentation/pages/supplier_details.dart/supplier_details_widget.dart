import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/suplier_details_cubit/supplierdetails_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_details.dart/supplier_details_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class SupplierDetailsWidget extends State<SupplierDetailsScreen> {
  late SupplierdetailsCubit supplierdetailsCubit;
  @override
  void initState() {
    super.initState();
    supplierdetailsCubit = getItInstance<SupplierdetailsCubit>();
  }

  Widget supplierBasic({required SupplierDetailModel supplierDetailModel}) {
    return Container(
      color: appConstants.white,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w, left: 12.w, top: 12.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonText(
                      text: supplierDetailModel.name,
                      style: Theme.of(context).textTheme.subTitle3MediumHeading.copyWith(color: appConstants.textColor),
                    ),
                    SizedBox(height: 2.h),
                    CommonWidget.commonText(
                      text: supplierDetailModel.email,
                      style:
                          Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.neutral5Color),
                    ),
                    CommonWidget.commonText(
                      text: supplierDetailModel.mobileNumber,
                      style:
                          Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.neutral5Color),
                    ),
                    SizedBox(
                      width: 210.w,
                      child: CommonWidget.commonText(
                        text: supplierDetailModel.address,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .caption2LightHeading
                            .copyWith(color: appConstants.neutral5Color),
                      ),
                    ),
                  ],
                ),
                balanceOrdate(supplierDetailModel),
              ],
            ),
            CommonWidget.sizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleAndValue(title: TranslationConstants.gst_no.translate(context), value: supplierDetailModel.gstNo),
                titleAndValue(title: TranslationConstants.pan_no.translate(context), value: supplierDetailModel.panNo),
                Visibility(
                  visible: supplierDetailModel.totalOrderAmount != null,
                  child: titleAndValue(
                      title: TranslationConstants.total_order_amount.translate(context),
                      value: supplierDetailModel.totalOrderAmount?.formatCurrency() ?? ""),
                ),
              ],
            ),
            CommonWidget.sizedBox(height: 7.h),
            Row(
              children: [
                CommonWidget.commonText(
                  text: "${TranslationConstants.item_of_supplier.translate(context)}: ",
                  style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.neutral5Color),
                ),
                CommonWidget.commonText(
                  text: "${supplierDetailModel.productList.length} ${TranslationConstants.items.translate(context)}",
                  style: Theme.of(context).textTheme.caption2MediumHeading.copyWith(color: appConstants.textColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column titleAndValue({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: title,
          style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.neutral5Color),
        ),
        CommonWidget.commonText(
          text: value,
          style: Theme.of(context).textTheme.caption2MediumHeading.copyWith(color: appConstants.textColor),
        ),
      ],
    );
  }

  Widget balanceOrdate(SupplierDetailModel supplierDetailModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: supplierDetailModel.dateTime,
          style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.neutral5Color),
        ),
        SizedBox(height: 13.h),
        Visibility(
            visible: supplierDetailModel.balance != null,
            child: balanceBox(supplierDetailModel: supplierDetailModel, context: context)),
      ],
    );
  }

  Widget balanceBox({required SupplierDetailModel supplierDetailModel, required BuildContext context}) {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
        color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
            ? const Color(0xffF2FBF0)
            : const Color(0xffFFEFEF),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
              ? const Color(0xff86D173)
              : const Color(0xffFF8888),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, top: 5.h, right: 10.w, bottom: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Balance",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: appConstants.themeColor,
                  ),
                ),
                const Spacer(),
                Text(
                  supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                      ? TranslationConstants.to_collect.translate(context)
                      : TranslationConstants.to_pay.translate(context),
                  style: TextStyle(
                    color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                        ? const Color(0xff25B800)
                        : Colors.red,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(
                  text: supplierDetailModel.balance?.formatCurrency() ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: appConstants.themeColor,
                  ),
                ),
                const Spacer(),
                supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 17.sp,
                          color: appConstants.green,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 17.sp,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tabbar({required SupplierDetailsLoadedState state, required SupplierdetailsCubit supplierdetailsCubit}) {
    return Container(
      decoration: BoxDecoration(
        color: appConstants.white,
        boxShadow: [
          BoxShadow(color: appConstants.black12, blurRadius: 5, spreadRadius: -5, offset: const Offset(0, 5)),
        ],
      ),
      child: TabBar(
        onTap: (value) {
          Future.delayed(const Duration(milliseconds: 100), () {
            supplierdetailsCubit.changeTab(tabValue: value);
          });
        },
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: appConstants.editbuttonColor,
        tabs: [
          tab(index: 0, state: state, tabName: TranslationConstants.order_history.translate(context)),
          tab(index: 1, state: state, tabName: "Item Related Margin"),
        ],
      ),
    );
  }

  Tab tab({required SupplierDetailsLoadedState state, required int index, required String tabName}) {
    return Tab(
      child: CommonWidget.commonText(
        text: tabName,
        style: state.tab == index
            ? Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.editbuttonColor)
            : Theme.of(context).textTheme.body2BookHeading.copyWith(color: appConstants.black26),
      ),
    );
  }

  Widget firstTab({required SupplierDetailModel supplierDetailModel}) {
    return supplierDetailModel.productList.isEmpty
        ? CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink())
        : CommonWidget.container(
            color: appConstants.backGroundColor,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ListView.builder(
              padding: REdgeInsets.only(top: 10.h),
              itemCount: supplierDetailModel.productList.length,
              itemBuilder: (contex, index) => commonOrderBox(supplierDetailModel: supplierDetailModel, index: index),
            ),
          );
  }

  Widget secondTab({required SupplierDetailModel supplierDetailModel}) {
    return Align(
      alignment: Alignment.topCenter,
      child: buildTable(),
    );
  }

  Widget commonOrderBox({required SupplierDetailModel supplierDetailModel, required int index}) {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(vertical: 7.h),
      padding: EdgeInsets.only(bottom: 7.h),
      color: Colors.white,
      borderRadius: 15.r,
      child: Column(
        children: [
          orderDateAndId(supplierDetailModel: supplierDetailModel, index: index),
          SizedBox(height: 0.h),
          Container(
            width: ScreenUtil().screenWidth,
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().screenWidth * 0.88,
              child: CommonWidget.commonDashLine(),
            ),
          ),
          SizedBox(height: 7.h),
          productDetails(supplierDetailModel: supplierDetailModel),
          SizedBox(height: 10.h),
          centerView(supplierDetailModel: supplierDetailModel),
          SizedBox(height: 7.h),
          CommonWidget.commonDashLine(),
          SizedBox(height: 5.h),
          productPrice(supplierDetailModel: supplierDetailModel),
        ],
      ),
    );
  }

  Widget centerView({required SupplierDetailModel supplierDetailModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          detailsvalue(title: "GST Tax", value: "@${supplierDetailModel.gst}%", color: Colors.black),
          detailsvalue(
            title: "GST Amount",
            value: supplierDetailModel.gstAmount.toString(),
            color: appConstants.paidColor,
          ),
          detailsvalue(
            title: "Total Amount",
            value: supplierDetailModel.totalAmount.toString(),
            color: appConstants.paidColor,
          ),
        ],
      ),
    );
  }

  Widget detailsvalue({required String title, required String value, required Color color}) {
    return Row(
      children: [
        CommonWidget.commonText(text: "$title: ", style: TextStyle(fontSize: 10.sp)),
        CommonWidget.commonText(
          text: value,
          style: TextStyle(fontWeight: FontWeight.w600, color: color, fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget orderDateAndId({required SupplierDetailModel supplierDetailModel, required int index}) {
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
            height: 30.h,
            width: 25.w,
            isBorderOnlySide: true,
            topLeft: 15.r,
            color: const Color(0xffBBDAFF),
            alignment: Alignment.center,
            child: allText(text: "#${index + 1}", fontSize: 14.sp, bold: true),
          ),
          SizedBox(width: 5.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              allText(text: TranslationConstants.order_ID.translate(context), bold: true),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.25,
                child: allText(text: supplierDetailModel.orderId!, color: appConstants.black54),
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              allText(text: TranslationConstants.order_date.translate(context), bold: true),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.20,
                child: allText(text: supplierDetailModel.orderDate!, color: appConstants.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productDetails({required SupplierDetailModel supplierDetailModel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            supplierDetailModel.productList.length,
            (index) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10.w),
                allText(text: "${supplierDetailModel.productList[index]}. "),
                SizedBox(
                  width: 130.w,
                  child: allText(text: supplierDetailModel.productList[index].productName),
                ),
                SizedBox(
                  width: 70.w,
                  child: allText(text: supplierDetailModel.productList[index].productQuanitiy),
                ),
                allText(text: supplierDetailModel.productList[index].productPrice, bold: true),
              ],
            ),
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
          child: allText(
            text: TranslationConstants.bill_copy.translate(context),
            color: Colors.white,
            fontSize: 10.sp,
            bold: true,
          ),
        ),
      ],
    );
  }

  Widget productPrice({required SupplierDetailModel supplierDetailModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Row(
            children: [
              allText(text: TranslationConstants.delivery_status.translate(context)),
              allText(
                text: supplierDetailModel.amountStatusModel!.deliveryStatus!.name.toCamelcase(),
                bold: true,
                color: appConstants.red,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              allText(text: TranslationConstants.payment_status.translate(context)),
              allText(
                text: supplierDetailModel.amountStatusModel!.orderPaid!.name.toCamelcase(),
                color: appConstants.paidColor,
                bold: true,
              ),
              allText(
                text: " (${supplierDetailModel.amountStatusModel!.paymentStatus!.name.toUpperCase()})",
                color: appConstants.themeColor,
                bold: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget allText({bool? bold, double? fontSize, Color? color, required String text}) {
    return CommonWidget.commonText(
      text: text,
      color: color ?? const Color(0xff293847),
      fontSize: fontSize ?? 11.sp,
      bold: bold ?? false,
    );
  }

  Widget buildTable() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
              borderColor: const Color.fromRGBO(47, 101, 151, 1),
              text: "#",
              boxColor: appConstants.theme1Color,
              width: 25.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: const Color.fromRGBO(47, 101, 151, 1),
              text: "Date",
              boxColor: appConstants.theme1Color,
              width: 60.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: const Color.fromRGBO(47, 101, 151, 1),
              text: "Name",
              padding: 10.w,
              boxColor: appConstants.theme1Color,
              width: 115.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: const Color.fromRGBO(47, 101, 151, 1),
              text: "Amount",
              boxColor: appConstants.theme1Color,
              width: 50.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: const Color.fromRGBO(47, 101, 151, 1),
              text: "Margin",
              boxColor: appConstants.theme1Color,
              width: 50.w,
              textColor: appConstants.white,
            ),
          ),
        ],
        rows: supplierdetailsCubit.itemRelatedMarginList
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    containtBox(
                      borderColor: const Color.fromRGBO(240, 240, 240, 1),
                      text: e.id.toString(),
                      boxColor: appConstants.white,
                      width: 25.w,
                      isOpenDialog: true,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: const Color.fromRGBO(240, 240, 240, 1),
                      text: e.date,
                      boxColor: appConstants.white,
                      width: 60.w,
                      isOpenDialog: true,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: const Color.fromRGBO(240, 240, 240, 1),
                      text: e.item,
                      boxColor: appConstants.white,
                      width: 115.w,
                      padding: 10,
                      isOpenDialog: true,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: const Color.fromRGBO(240, 240, 240, 1),
                      text: e.amount.formatCurrency(),
                      boxColor: appConstants.white,
                      textColor: appConstants.black,
                      isOpenDialog: true,
                      width: 50.w,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: const Color.fromRGBO(240, 240, 240, 1),
                      text: "${e.margin}%",
                      boxColor: appConstants.white,
                      width: 50.w,
                      isOpenDialog: true,
                      textColor: appConstants.editbuttonColor,
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
    bool isOpenDialog = false,
    double? padding,
  }) {
    return CommonWidget.container(
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
        fontSize: 10.sp,
        textAlign: TextAlign.center,
        text: text,
        maxLines: 2,
      ),
    );
  }
}
