import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/add_inventory/add_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/add_inventory_screen/add_inventory_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class AddProductInventoryWidget extends State<AddProductInventoryScreen> {
  late AddProductInventoryCubit addProductInventoryCubit;
  late ProductInventoryModel productInventoryModel;

  @override
  void initState() {
    addProductInventoryCubit = getItInstance<AddProductInventoryCubit>();
    productInventoryModel = widget.productInventoryModel;
    super.initState();
  }

  @override
  void dispose() {
    addProductInventoryCubit.close();
    super.dispose();
  }

  Widget orderDetails() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: commonTextField(
                title: TranslationConstants.order_date.translate(context).replaceAll(" :", ""),
                hinttext: formatter.format(DateTime.now()),
                controller: addProductInventoryCubit.orderDate,
                height: 50.r,
                readOnly: true,
                suffixWidget: Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                  child: CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/common/calender_icon.svg",
                    iconSize: 20.r,
                    boxFit: BoxFit.contain,
                    onTap: () async {
                      List<DateTime?>? selectedDate = await CommonWidget.datePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        String formattedDate = formatter.format(selectedDate.first!);
                        addProductInventoryCubit.orderDate.text = formattedDate;
                        addProductInventoryCubit.selectOrderDate = selectedDate.first;
                      }
                    },
                  ),
                ),
              ),
            ),
            CommonWidget.sizedBox(width: 15),
            Expanded(
              child: commonTextField(
                title: TranslationConstants.order_ID.translate(context).replaceAll(" :", ""),
                hinttext: productInventoryModel.orderId ?? TranslationConstants.enter_order_ID.translate(context),
                height: 50.r,
                hintStyle: widget.productInventoryModel.orderId == null
                    ? TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.grey,
                      )
                    : TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.black,
                      ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: commonTextField(
                  title: TranslationConstants.buying_price.translate(context),
                  hinttext: widget.productInventoryModel.buyingPrice?.replaceAll("₹", "") ??
                      TranslationConstants.enter_price.translate(context),
                  height: 50.r,
                  hintStyle: widget.productInventoryModel.buyingPrice == null
                      ? TextStyle(
                          fontSize: 13.sp,
                          color: appConstants.grey,
                        )
                      : TextStyle(
                          fontSize: 13.sp,
                          color: appConstants.black,
                        ),
                ),
              ),
              CommonWidget.sizedBox(width: 15),
              Expanded(
                child: commonTextField(
                  title: TranslationConstants.quantity_stock.translate(context),
                  hinttext:
                      widget.productInventoryModel.stock ?? TranslationConstants.enter_quantity.translate(context),
                  height: 50.r,
                  hintStyle: widget.productInventoryModel.stock == null
                      ? TextStyle(
                          fontSize: 13.sp,
                          color: appConstants.grey,
                        )
                      : TextStyle(
                          fontSize: 13.sp,
                          color: appConstants.black,
                        ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: commonTextField(
                title: TranslationConstants.tax.translate(context),
                hinttext: widget.productInventoryModel.gstText?.replaceAll("%", "") ??
                    TranslationConstants.enter_tax.translate(context),
                height: 50.r,
                hintStyle: widget.productInventoryModel.gstText == null
                    ? TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.grey,
                      )
                    : TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.black,
                      ),
              ),
            ),
            CommonWidget.sizedBox(width: 15),
            Expanded(
              child: commonTextField(
                title: TranslationConstants.total_amount.translate(context),
                hinttext: widget.productInventoryModel.gstAmount?.replaceAll("₹", "") ??
                    TranslationConstants.enter_total_amount.translate(context),
                height: 50.r,
                hintStyle: widget.productInventoryModel.gstAmount == null
                    ? TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.grey,
                      )
                    : TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.black,
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget categoryTextField({
    required String title,
    required String hinttext,
    double? height,
    double? width,
    int? maxline,
    TextEditingController? controller,
    TextStyle? hintStyle,
    Widget? suffixWidget,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: title,
          style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600),
        ),
        CommonWidget.sizedBox(height: 8),
        CommonWidget.sizedBox(
          height: height,
          width: width,
          child: InkWell(
            onTap: () {},
            child: CommonWidget.container(
              isBorder: true,
              borderColor: appConstants.neutral9Color,
              borderRadius: 8.r,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.commonText(text: hinttext, style: hintStyle),
                  CommonWidget.container(
                    height: 15.h,
                    width: 15.w,
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/down_filled_arrow.svg",
                      color: appConstants.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonTextField({
    required String title,
    required String hinttext,
    double? height,
    double? width,
    int? maxline,
    TextEditingController? controller,
    TextStyle? hintStyle,
    Widget? suffixWidget,
    VoidCallback? onTap,
    bool? readOnly,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: title,
          style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600),
        ),
        CommonWidget.sizedBox(height: 8),
        CommonWidget.sizedBox(
          height: height,
          width: width,
          child: CommonWidget.textField(
            maxLines: maxline ?? 1,
            enabled: true,
            controller: controller,
            cursorColor: appConstants.themeColor,
            hintText: hinttext,
            onTap: onTap,
            readOnly: readOnly,
            hintStyle: hintStyle ??
                TextStyle(
                  fontSize: 13.sp,
                  color: appConstants.grey,
                ),
            fillColor: appConstants.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            borderColor: appConstants.neutral9Color,
            disabledBorderColor: appConstants.neutral9Color,
            enabledBorderColor: appConstants.neutral9Color,
            focusedBorderColor: appConstants.neutral9Color,
            borderRadius: 8.r,
            issuffixWidget: true,
            suffixWidget: suffixWidget,
          ),
        ),
      ],
    );
  }
}
