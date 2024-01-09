import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/customer_all_details/routine_order_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class RoutineOrderDetailsWidget extends State<RoutineOrderDetailsScreen> {
  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.order_details.translate(context),
      titleCenter: false,
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              appConstants.transparent,
            ),
          ),
          onPressed: () => CommonWidget.showAlertDialog(
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
          ),
          child: CommonWidget.commonText(
            text: TranslationConstants.delete.translate(context),
            color: appConstants.deletebuttonColor,
            fontSize: 16,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
      ],
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget totalPayPendiongAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.total_amount.translate(context),
              fontSize: 12,
            ),
            CommonWidget.commonText(
              text: ' ₹5000',
              fontSize: 12,
              bold: true,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.pay_amount.translate(context),
              fontSize: 12,
            ),
            CommonWidget.commonText(
              text: ' ₹5000',
              fontSize: 12,
              bold: true,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.pending_amount.translate(context),
              fontSize: 12,
            ),
            CommonWidget.commonText(
              text: ' ₹5000',
              fontSize: 12,
              bold: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget amountDateBalance() {
    return Column(
      children: [
        CommonWidget.commonText(
          text: "17 Oct 2023 | 12:23",
          fontSize: 12,
          color: appConstants.lightGrey4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CommonWidget.container(
            isBorder: true,
            borderColor: appConstants.textFiledColor,
            borderRadius: 3.r,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            child: CommonWidget.commonText(
              text: "₹ 10,000.00",
              fontSize: 14,
              color: appConstants.themeColor,
              bold: true,
            ),
          ),
        ),
        CommonWidget.commonText(
          text: TranslationConstants.balance.translate(context),
          fontSize: 12,
          color: appConstants.lightGrey4,
        ),
      ],
    );
  }

  Widget customerDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: "Karan Parekh",
          fontSize: 16,
          bold: true,
        ),
        CommonWidget.commonText(
          text: "karanparekh01@gmail.com",
          fontSize: 12,
          color: appConstants.lightGrey4,
        ),
        CommonWidget.commonText(
          text: "+91 9876543210",
          fontSize: 12,
          color: appConstants.lightGrey4,
        ),
        CommonWidget.commonText(
          text: TranslationConstants.new_customer.translate(context),
          fontSize: 12,
          color: appConstants.editbuttonColor,
          bold: true,
        ),
      ],
    );
  }

  Widget titleBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: CommonWidget.container(
        height: 40.h,
        color: appConstants.themeColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Row(
            children: [
              CommonWidget.commonText(
                text: '#',
                fontSize: 12,
                textAlign: TextAlign.start,
                color: appConstants.white,
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: TranslationConstants.date.translate(context),
                  fontSize: 12,
                  color: appConstants.white,
                ),
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: TranslationConstants.order_ID.translate(context).replaceAll(":", ""),
                  fontSize: 12,
                  color: appConstants.white,
                ),
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: TranslationConstants.delivery_status.translate(context).replaceAll(":", ""),
                  fontSize: 12,
                  color: appConstants.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget attributeQuantityAndRate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.variant.translate(context),
                  fontSize: 11,
                ),
                Expanded(
                  child: CommonWidget.commonText(
                    text: ' :500gm',
                    fontSize: 11,
                    textAlign: TextAlign.start,
                    bold: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.quantity.translate(context),
                  fontSize: 11,
                ),
                Expanded(
                  child: CommonWidget.commonText(
                    text: ' :01',
                    fontSize: 11,
                    textAlign: TextAlign.start,
                    bold: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.rate.translate(context),
                  fontSize: 11,
                ),
                Expanded(
                  child: CommonWidget.commonText(
                    text: ': ₹500',
                    fontSize: 11,
                    textAlign: TextAlign.start,
                    bold: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commonListView(int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Row(
            children: [
              CommonWidget.commonText(
                text: '${index + 1}',
                fontSize: 14,
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: '15/12/2023',
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: '98653201425',
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: CommonWidget.commonText(
                  text: 'Pending',
                  fontSize: 14,
                  color: appConstants.pendingColor,
                ),
              ),
            ],
          ),
        ),
        Divider(color: appConstants.shadowColor1),
      ],
    );
  }
}
