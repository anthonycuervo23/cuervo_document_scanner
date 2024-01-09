import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/customer_abd_supplier_card_model.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

Widget customerAndSupplierListBox({
  required CustomerAndSupplierCardModel details,
  required BuildContext context,
  required Function() onDeleteButtonTap,
  required Function() onCardTap,
  required Function() onEditButtonTap,
}) {
  return Card(
    elevation: 5,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    shadowColor: appConstants.theme8Color,
    child: InkWell(
      onTap: onCardTap,
      child: CommonWidget.container(
        borderRadius: 10.r,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            profileImageAndPhoneIcon(details: details, context: context),
            allInfo(
              customerAndSupplierCardModel: details,
              onEditButtonTap: onEditButtonTap,
              context: context,
              onDeleteButtonTap: onDeleteButtonTap,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget allInfo({
  required CustomerAndSupplierCardModel customerAndSupplierCardModel,
  required Function() onEditButtonTap,
  required BuildContext context,
  required Function() onDeleteButtonTap,
}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.only(bottom: 5.h, right: 11.w, left: 5.w, top: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainTitle(
            details: customerAndSupplierCardModel,
            onEditButtonTap: onEditButtonTap,
            context: context,
            onDeleteButtonTap: onDeleteButtonTap,
          ),
          CommonWidget.sizedBox(
            width: 130,
            child: CommonWidget.commonText(
              textAlign: TextAlign.start,
              text: customerAndSupplierCardModel.customerType != null
                  ? "${customerAndSupplierCardModel.customerType!.name} ${TranslationConstants.customer.translate(context)}"
                  : customerAndSupplierCardModel.mobileNumber,
              fontSize: 12,
              color:
                  customerAndSupplierCardModel.customerType != null ? appConstants.editbuttonColor : appConstants.black,
            ),
          ),
          mobileNumberAndDate(customerAndSupplierCardModel: customerAndSupplierCardModel, context: context),
          orderAmountBox(details: customerAndSupplierCardModel, context: context),
        ],
      ),
    ),
  );
}

Widget mainTitle({
  required CustomerAndSupplierCardModel details,
  required Function() onEditButtonTap,
  required BuildContext context,
  required Function() onDeleteButtonTap,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        constraints: BoxConstraints(maxWidth: details.isPending != null ? 80.w : 130.w),
        child: CommonWidget.commonText(
          textAlign: TextAlign.start,
          text: details.name,
          fontSize: 15,
          color: appConstants.black,
        ),
      ),
      Visibility(visible: details.isPending ?? false, child: CommonWidget.sizedBox(width: 20)),
      details.isPending == true ? pendingView(context: context) : const SizedBox.shrink(),
      const Spacer(),
      editAndDeleteButton(onEditButtonTap: onEditButtonTap, context: context, onDeleteButtonTap: onDeleteButtonTap),
    ],
  );
}

Widget mobileNumberAndDate(
    {required CustomerAndSupplierCardModel customerAndSupplierCardModel, required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(top: 5.h),
    child: Row(
      children: [
        customerAndSupplierCardModel.totalItem == null
            ? CommonWidget.sizedBox(
                width: 100.w,
                child: CommonWidget.commonText(
                    textAlign: TextAlign.start, text: customerAndSupplierCardModel.mobileNumber, fontSize: 12))
            : Row(
                children: [
                  CommonWidget.commonText(
                    text: "${TranslationConstants.total_item.translate(context)} : ",
                    fontSize: 10,
                    color: appConstants.grey,
                  ),
                  CommonWidget.sizedBox(
                    width: 60,
                    child: CommonWidget.commonText(
                      textAlign: TextAlign.start,
                      text:
                          "${customerAndSupplierCardModel.totalItem!} ${TranslationConstants.items.translate(context)}",
                      fontSize: 10,
                      color: appConstants.black,
                    ),
                  ),
                ],
              ),
        const Spacer(),
        CommonWidget.sizedBox(
          width: 120,
          child: CommonWidget.commonText(
            textAlign: TextAlign.end,
            text: customerAndSupplierCardModel.date,
            fontSize: 10,
            color: appConstants.grey,
          ),
        ),
      ],
    ),
  );
}

Widget pendingView({required BuildContext context}) {
  return CommonWidget.container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    color: appConstants.red.withOpacity(0.2),
    borderRadius: 15.r,
    child: CommonWidget.commonText(
      text: TranslationConstants.pending.translate(context),
      fontSize: 10,
      color: appConstants.red,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget editAndDeleteButton({
  required Function() onEditButtonTap,
  required BuildContext context,
  required Function() onDeleteButtonTap,
}) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 5.h, left: 15.w, right: 10.w, bottom: 1.h),
        child: InkWell(
          onTap: onEditButtonTap,
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
      ),
      Padding(
        padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 1.h),
        child: InkWell(
          onTap: () {
            showAlertDialog(
              noButtonColor: appConstants.theme7Color,
              context: context,
              isTitle: true,
              titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                    color: appConstants.themeColor,
                  ),
              contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                    color: appConstants.textColor,
                  ),
              width: 200.w,
              maxLine: 2,
              onTap: onDeleteButtonTap,
              titleText: TranslationConstants.confirm_delete.translate(context),
              text: TranslationConstants.sure_delete_supplier.translate(context),
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
      ),
    ],
  );
}

Widget profileImageAndPhoneIcon({required CustomerAndSupplierCardModel details, required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        profileImage(
          details: details,
          context: context,
        ),
        CommonWidget.sizedBox(height: 15),
        InkWell(
          onTap: () => makePhoneCall(phoneNumber: details.mobileNumber),
          child: Container(
            height: newDeviceType == NewDeviceType.phone ? 35.h : 45.h,
            width: newDeviceType == NewDeviceType.phone ? 35.w : 45.w,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appConstants.green,
            ),
            padding: newDeviceType == NewDeviceType.phone
                ? EdgeInsets.only(top: 11.h, left: 11.w, right: 11.w, bottom: 11.h)
                : newDeviceType == NewDeviceType.tablet
                    ? EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w, bottom: 15.h)
                    : EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 10.h),
            child: CommonWidget.imageBuilder(
              height: newDeviceType == NewDeviceType.phone ? 10.h : 30.h,
              width: newDeviceType == NewDeviceType.phone ? 10.w : 30.w,
              imageUrl: "assets/photos/svg/customer/call.svg",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    ),
  );
}

InkWell profileImage({
  required CustomerAndSupplierCardModel details,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      CommonWidget.commonImageDialog(
        path: details.image,
        context: context,
      );
    },
    child: Container(
      height: newDeviceType == NewDeviceType.phone ? 45.h : 50.h,
      width: newDeviceType == NewDeviceType.phone ? 45.w : 50.w,
      decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: CommonWidget.imageBuilder(
          height: 45.h,
          width: 45.h,
          imageUrl: details.image,
        ),
      ),
    ),
  );
}

// orde box
Widget orderAmountBox({
  required CustomerAndSupplierCardModel details,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 9.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.container(
          isBorder: true,
          width: 120,
          borderRadius: 5.r,
          borderColor: appConstants.neutral11Color,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w, bottom: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.total_amount_order.translate(context),
                  maxLines: 2,
                  fontSize: 10,
                  color: appConstants.lightGrey.withOpacity(0.5),
                ),
                CommonWidget.sizedBox(height: 4),
                Row(
                  children: [
                    CommonWidget.commonText(
                      text: "₹ ",
                      fontSize: 11,
                      color: appConstants.editbuttonColor,
                      fontWeight: FontWeight.w600,
                    ),
                    Expanded(
                      child: CommonWidget.commonText(
                        textAlign: TextAlign.start,
                        text: double.parse(details.orderAmount).formatCurrency().replaceAll("₹", ""),
                        fontSize: 10,
                        color: appConstants.theme1Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        balanceBox(details: details, context: context),
      ],
    ),
  );
}

// balance box
Widget balanceBox({required CustomerAndSupplierCardModel details, required BuildContext context}) {
  return CommonWidget.container(
    width: 120,
    color: details.balanceAmountType == CustomerBalanceType.ToCollect
        ? appConstants.parrotColor.withOpacity(0.2)
        : appConstants.red.withOpacity(0.1),
    borderRadius: 5.r,
    borderColor:
        details.balanceAmountType == CustomerBalanceType.ToCollect ? appConstants.parrotColor : appConstants.red,
    isBorder: true,
    child: Padding(
      padding: EdgeInsets.only(left: 6.w, top: 5.h, right: 10.w, bottom: 5.h),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.balance.translate(context),
                maxLines: 2,
                fontSize: 10,
                color: appConstants.neutral1Color.withOpacity(0.6),
              ),
              CommonWidget.sizedBox(
                width: 50,
                child: CommonWidget.commonText(
                  textAlign: TextAlign.start,
                  text: double.parse(details.balanceAmount).formatCurrency(),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 50.w),
            child: Column(
              children: [
                CommonWidget.commonText(
                  textAlign: TextAlign.end,
                  text: details.balanceAmountType == CustomerBalanceType.ToCollect
                      ? TranslationConstants.to_collect.translate(context)
                      : TranslationConstants.to_pay.translate(context),
                  color: details.balanceAmountType == CustomerBalanceType.ToCollect
                      ? appConstants.parrotColor
                      : appConstants.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
                details.balanceAmountType == CustomerBalanceType.ToCollect
                    ? Center(
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 15.sp,
                          color: appConstants.parrotColor,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 15.sp,
                          color: appConstants.red,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// common dialog
void showAlertDialog({
  required BuildContext context,
  required VoidCallback onTap,
  required String text,
  String? titleText,
  Color? textColor,
  Color? noButtonColor,
  bool isTitle = false,
  VoidCallback? onNoTap,
  List<Widget>? actions,
  TextStyle? titleTextStyle,
  TextStyle? contentTextStyle,
  double? width,
  int? maxLine,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: appConstants.white,
        backgroundColor: appConstants.white,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        actionsPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: SizedBox(
          width: newDeviceType != NewDeviceType.phone ? 350.w : ScreenUtil().screenWidth * 0.9,
          child: Column(
            children: [
              CommonWidget.sizedBox(height: 20),
              isTitle
                  ? titleView(titleTextStyle: titleTextStyle, context: context, titleText: titleText)
                  : const SizedBox.shrink(),
              CommonWidget.container(
                width: width ?? double.infinity,
                child: CommonWidget.commonText(
                  style: contentTextStyle ??
                      Theme.of(context)
                          .textTheme
                          .body1BookHeading
                          .copyWith(color: appConstants.introScreenDescriptionText),
                  text: text,
                  fontSize: 13,
                  textAlign: TextAlign.center,
                  color: textColor ?? appConstants.introScreenDescriptionText,
                  maxLines: maxLine ?? 1,
                ),
              ),
              noYesButton(context: context, onNoTap: onNoTap, noButtonColor: noButtonColor, onTap: onTap)
            ],
          ),
        ),
      );
    },
  );
}

Widget noYesButton({
  required BuildContext context,
  required VoidCallback? onNoTap,
  required Color? noButtonColor,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.all(20.r),
    child: Row(
      children: [
        Expanded(
          child: CommonWidget.commonButton(
            context: context,
            alignment: Alignment.center,
            onTap: onNoTap ?? () => CommonRouter.pop(),
            text: TranslationConstants.no.translate(context),
            textColor: appConstants.themeColor,
            color: noButtonColor ?? appConstants.orenge,
            borderRadius: 8.r,
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
        CommonWidget.sizedBox(width: 15),
        Expanded(
          child: CommonWidget.commonButton(
            context: context,
            onTap: onTap,
            alignment: Alignment.center,
            text: TranslationConstants.yes.translate(context),
            textColor: appConstants.white,
            color: appConstants.themeColor,
            borderRadius: 8.r,
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
      ],
    ),
  );
}

Column titleView({
  required TextStyle? titleTextStyle,
  required BuildContext context,
  required String? titleText,
}) {
  return Column(
    children: [
      Center(
        child: CommonWidget.commonText(
          lineThrough: true,
          style: titleTextStyle ??
              Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                    color: appConstants.black,
                    height: 1,
                  ),
          text: titleText ?? '',
        ),
      ),
      CommonWidget.sizedBox(height: 15),
    ],
  );
}

//method
Future<void> makePhoneCall({required String phoneNumber}) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}
