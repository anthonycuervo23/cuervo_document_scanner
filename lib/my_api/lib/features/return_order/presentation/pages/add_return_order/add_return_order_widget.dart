import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/cubit/add_return_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/add_return_order/add_return_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AddReturnOrderWidget extends State<AddReturnOrderScreen> {
  late AddReturnOrderCubit addReturnOrderCubit;

  @override
  void initState() {
    addReturnOrderCubit = getItInstance<AddReturnOrderCubit>();
    super.initState();
  }

  @override
  void dispose() {
    addReturnOrderCubit.close();
    addReturnOrderCubit.loadingCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.add_return_order.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
      trailing: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CommonWidget.commonButton(
          borderRadius: 20.r,
          text: TranslationConstants.save.translate(context),
          color: appConstants.theme1Color,
          context: context,
          textColor: appConstants.white,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          alignment: Alignment.center,
          onTap: () => CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: "Saved"),
        ),
      ),
    );
  }

  Widget orderIdAndDateOfPurchase() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: commonTextField(
            titleText: TranslationConstants.order_ID.translate(context).replaceAll(":", ""),
            hintText: TranslationConstants.enter_order_id.translate(context),
            controller: addReturnOrderCubit.orderIdController,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        Expanded(
          child: commonTextField(
            onTap: () async {
              List<DateTime?>? date = await CommonWidget.datePicker(
                context: context,
                lastDate: DateTime.now(),
              );
              if (date != null) {
                addReturnOrderCubit.selectDateofPurchase(date: date[0]);
              }
            },
            readOnly: true,
            isSuffixIcon: true,
            suffixIconpath: 'assets/photos/svg/common/calender_icon.svg',
            titleText: TranslationConstants.date_of_purchases.translate(context),
            hintText: TranslationConstants.enter_date.translate(context),
            controller: addReturnOrderCubit.dateOfPurchasesController,
          ),
        ),
      ],
    );
  }

  Widget customerNameField() {
    return commonTextField(
      titleText: TranslationConstants.customer_name.translate(context),
      hintText: TranslationConstants.enter_customer_name.translate(context),
      controller: addReturnOrderCubit.customerNameController,
    );
  }

  Widget productList({required AddReturnOrderLoadedState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: TranslationConstants.product_list.translate(context),
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CommonWidget.container(
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 12.h),
          isBorder: true,
          borderRadius: 5.r,
          borderColor: appConstants.borderColor2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              productTitle(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) => commonItemBox(),
              ),
              Align(alignment: Alignment.centerRight, child: CommonWidget.commonDashLine(width: 170.w)),
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonWidget.commonText(
                      text: TranslationConstants.sub_amount.translate(context),
                      fontSize: 12.sp,
                      bold: true,
                      color: appConstants.themeColor,
                    ),
                    SizedBox(width: 30.w),
                    CommonWidget.commonText(
                      text: '₹ 1190',
                      fontSize: 12.sp,
                      bold: true,
                      color: appConstants.themeColor,
                    ),
                  ],
                ),
              ),
              Divider(color: appConstants.dividerColor),
              returnItem(state: state),
            ],
          ),
        ),
      ],
    );
  }

  Widget returnItem({required AddReturnOrderLoadedState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.return_item.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
            CommonWidget.sizedBox(width: 20),
            GestureDetector(
              onTap: () {
                addReturnOrderCubit.addReturnItem();
              },
              child: CommonWidget.imageBuilder(
                imageUrl: 'assets/photos/svg/common/add_icon.svg',
                height: 16.h,
                color: appConstants.themeColor,
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.removeItemList!.length,
          itemBuilder: (context, index) => commonReturnItemBox(),
        ),
        Row(
          children: [
            CommonWidget.commonDashLine(width: 70),
            SizedBox(width: 20.w),
            CommonWidget.commonDashLine(width: 30),
            SizedBox(width: 20.w),
            CommonWidget.commonDashLine(width: 50),
            SizedBox(width: 30.w),
            Expanded(
                child: Divider(
              color: appConstants.dividerColor,
              thickness: 2,
            )),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.sub_amount.translate(context),
                fontSize: 9.sp,
              ),
              SizedBox(width: 30.w),
              CommonWidget.commonText(
                text: '₹ 1190',
                fontSize: 9.sp,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.return_amount.translate(context),
                fontSize: 9.sp,
              ),
              SizedBox(width: 30.w),
              CommonWidget.commonText(
                text: '₹ 170',
                fontSize: 9.sp,
              ),
            ],
          ),
        ),
        Align(alignment: Alignment.centerRight, child: CommonWidget.commonDashLine(width: 170.w)),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.total_amount.translate(context),
                fontSize: 12.sp,
                bold: true,
                color: appConstants.themeColor,
              ),
              SizedBox(width: 30.w),
              CommonWidget.commonText(
                text: '₹ 1190',
                fontSize: 12.sp,
                bold: true,
                color: appConstants.themeColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget commonItemBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.commonText(
                  textAlign: TextAlign.start,
                  text: 'Black Froestxzxzxzxzxzxxzxscscssssdsdssddsdssdsdsddsd',
                  fontSize: 9.sp,
                ),
                CommonWidget.commonText(
                  textAlign: TextAlign.start,
                  text: '500 gm',
                  fontSize: 9.sp,
                  color: appConstants.lightGrey4,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: '04',
              fontSize: 9.sp,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: '₹200',
              fontSize: 9.sp,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: '₹20',
              fontSize: 9.sp,
            ),
          ),
          SizedBox(
            width: 50.w,
            child: CommonWidget.commonText(
              text: '₹120',
              fontSize: 9.sp,
            ),
          ),
          SizedBox(
            width: 50.w,
            child: CommonWidget.commonText(
              text: '₹900000000000',
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget commonReturnItemBox() {
    return Row(
      children: [
        Expanded(
          child: CommonWidget.textField(
            controller: addReturnOrderCubit.itemNameController,
            contentPadding: EdgeInsets.zero,
            textInputType: TextInputType.text,
            hintText: TranslationConstants.item_name.translate(context),
            hintSize: 11.sp,
            hintColor: appConstants.lightGrey4,
            focusedBorderColor: appConstants.transparent,
            style: TextStyle(
              fontSize: 11.sp,
              color: appConstants.neutral1Color,
            ),
          ),
        ),
        SizedBox(
          width: 40.w,
          child: CommonWidget.textField(
            controller: addReturnOrderCubit.itemQtyController,
            contentPadding: EdgeInsets.zero,
            textInputType: TextInputType.number,
            hintText: '0.0',
            hintSize: 11.sp,
            hintColor: appConstants.lightGrey4,
            focusedBorderColor: appConstants.transparent,
            style: TextStyle(
              fontSize: 11.sp,
              color: appConstants.neutral1Color,
            ),
          ),
        ),
        SizedBox(
          width: 30.w,
          child: CommonWidget.textField(
            controller: addReturnOrderCubit.amountController,
            contentPadding: EdgeInsets.zero,
            textInputType: TextInputType.number,
            hintText: '₹00',
            hintSize: 11.sp,
            hintColor: appConstants.lightGrey4,
            focusedBorderColor: appConstants.transparent,
            style: TextStyle(
              fontSize: 11.sp,
              color: appConstants.neutral1Color,
            ),
          ),
        ),
        SizedBox(
          width: 45.w,
          child: CommonWidget.commonText(
            text: '₹20',
            fontSize: 9.sp,
            color: appConstants.lightGrey4,
          ),
        ),
        SizedBox(
          width: 45.w,
          child: CommonWidget.commonText(
            text: '₹120',
            fontSize: 9.sp,
            color: appConstants.lightGrey4,
          ),
        ),
        SizedBox(
          width: 45.w,
          child: CommonWidget.commonText(
            text: '₹900000000000',
            fontSize: 9.sp,
            color: appConstants.lightGrey4,
          ),
        ),
      ],
    );
  }

  Widget productTitle() {
    return SizedBox(
      height: 20.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommonWidget.commonText(
              textAlign: TextAlign.start,
              text: TranslationConstants.item.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: TranslationConstants.qty.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: TranslationConstants.rate.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonWidget.commonText(
              text: TranslationConstants.dis.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
          SizedBox(
            width: 50.w,
            child: CommonWidget.commonText(
              text: TranslationConstants.tax.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
          SizedBox(
            width: 50.w,
            child: CommonWidget.commonText(
              text: TranslationConstants.amt.translate(context),
              fontSize: 12.sp,
              bold: true,
              color: appConstants.themeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget returnDateField() {
    return commonTextField(
      onTap: () async {
        List<DateTime?>? date = await CommonWidget.datePicker(
          context: context,
          lastDate: DateTime.now(),
        );
        if (date != null) {
          addReturnOrderCubit.selectReturnDate(date: date[0]);
        }
      },
      readOnly: true,
      isSuffixIcon: true,
      suffixIconpath: 'assets/photos/svg/common/calender_icon.svg',
      titleText: TranslationConstants.return_date.translate(context),
      hintText: TranslationConstants.enter_return_date.translate(context),
      controller: addReturnOrderCubit.returnDateController,
    );
  }

  Widget reasonOfReturnField() {
    return commonTextField(
      titleText: TranslationConstants.reason_of_return.translate(context),
      hintText: TranslationConstants.enter_reason_of_return.translate(context),
      controller: addReturnOrderCubit.customerNameController,
    );
  }

  Widget collectByDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: TranslationConstants.collected_by.translate(context),
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CustomDropdownButton(
          padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
          useTextField: true,
          mainContainerRadius: 5.r,
          titleTextAlignment: Alignment.centerLeft,
          selectedOptions: "Select Name",
          dataList: const [
            "Mitesh Patel",
            "Rajendra Sahu",
            "Ajay Katariya",
          ],
          size: 40.r,
          height: 150.h,
          scrolllingHeight: 80.h,
          onOptionSelected: (v) {},
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget commonTextField({
    required String titleText,
    required String hintText,
    required TextEditingController controller,
    TextInputType? textInputType,
    double? borderRadius,
    Widget? prefixWidget,
    bool? isPrefixWidget,
    bool? isSuffixIcon,
    bool? readOnly,
    String? suffixIconpath,
    void Function()? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: titleText,
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        CommonWidget.textField(
          issuffixIcon: isSuffixIcon,
          readOnly: readOnly,
          prefixWidget: prefixWidget,
          isPrefixWidget: isPrefixWidget,
          borderRadius: borderRadius ?? 5.0,
          controller: controller,
          textInputType: textInputType ?? TextInputType.text,
          fillColor: appConstants.drawerBackgroundColor,
          hintText: hintText,
          hintSize: 12.sp,
          contentPadding: EdgeInsets.only(left: 12.w),
          borderColor: appConstants.textFiledColor,
          suffixIconpath: suffixIconpath,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget status() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.status.translate(context),
          fontSize: 12.sp,
          bold: true,
        ),
        BlocBuilder<CounterCubit, int>(
          bloc: addReturnOrderCubit.counterCubit,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) {
                  return commonStatusButton(
                    index: index,
                    state: state,
                    text: index == 0
                        ? TranslationConstants.active.translate(context)
                        : TranslationConstants.inactive.translate(context).toCamelcase(),
                    onTap: () => addReturnOrderCubit.counterCubit.chanagePageIndex(index: index),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget commonStatusButton({
    required int index,
    required String text,
    required VoidCallback onTap,
    required int state,
  }) {
    bool isSelected = (state == index);
    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h),
      child: CommonWidget.commonButton(
        height: 35.h,
        width: 90.w,
        color: isSelected ? appConstants.lightBlue : appConstants.backGroundColor,
        borderColor: isSelected ? appConstants.editbuttonColor : appConstants.transparent,
        isBorder: true,
        borderRadius: 5.r,
        borderWidth: 1.5,
        context: context,
        onTap: onTap,
        child: Center(
          child: CommonWidget.commonText(
            text: text,
            color: isSelected ? appConstants.editbuttonColor : appConstants.neutral1Color,
            fontSize: 12.sp,
            bold: true,
          ),
        ),
      ),
    );
  }

  Widget commonSizeBox() => SizedBox(height: 10.h);
}
