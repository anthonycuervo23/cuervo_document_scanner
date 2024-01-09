import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_state.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/paymentCubit/payment_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';

Widget paymentView({
  required PaymentLoadedState state,
  required OrderLoadedState orderState,
  required BuildContext context,
  required PaymentCubit paymentCubit,
}) {
  return CommonWidget.container(
    width: double.infinity,
    color: appConstants.white,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
            text: TranslationConstants.select_payment.translate(context).toCamelcase(),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        CommonWidget.sizedBox(height: 10),
        selectPaymentType(state: state, context: context, paymentCubit: paymentCubit),
        CommonWidget.sizedBox(height: 10),
        state.paymentMethod.name == OrderPaymentMethod.cash.name
            ? payCash(state: state, orderState: orderState, context: context)
            : state.paymentMethod.name == OrderPaymentMethod.upi.name
                ? payWithUpi(context: context)
                : payWithCreditCard(context: context),
      ],
    ),
  );
}

Widget payWithCreditCard({
  required BuildContext context,
}) {
  return CommonWidget.container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: CommonWidget.commonButton(
            alignment: Alignment.center,
            text: TranslationConstants.generate_invoice.translate(context),
            style: TextStyle(color: appConstants.theme1Color, fontWeight: FontWeight.bold),
            color: appConstants.quantityManageContainerColor,
            height: 50,
            context: context,
            onTap: () {},
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        Expanded(
          flex: 1,
          child: CommonWidget.commonButton(
            alignment: Alignment.center,
            text: TranslationConstants.generate_summary.translate(context),
            style: TextStyle(color: appConstants.theme1Color, fontWeight: FontWeight.bold),
            color: appConstants.quantityManageContainerColor,
            height: 50,
            context: context,
            onTap: () {},
          ),
        ),
      ],
    ),
  );
}

Widget selectPaymentType({
  required PaymentLoadedState state,
  required BuildContext context,
  required PaymentCubit paymentCubit,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    InkWell(
      onTap: () => paymentCubit.changePaymentMethod(method: OrderPaymentMethod.cash, state: state),
      child: paymentMethodContainer(
          image: "assets/photos/svg/order_module/cash_icon.svg",
          text:
              "${TranslationConstants.pay.translate(context).toCamelcase()} ${OrderPaymentMethod.values[0].name.toCamelcase()}",
          isSelected: state.paymentMethod.name == OrderPaymentMethod.values[0].name ? true : false),
    ),
    InkWell(
      onTap: () => paymentCubit.changePaymentMethod(method: OrderPaymentMethod.upi, state: state),
      child: paymentMethodContainer(
          image: "assets/photos/svg/order_module/upi_icon.svg",
          text:
              "${TranslationConstants.pay.translate(context).toCamelcase()} ${OrderPaymentMethod.values[1].name.toCamelcase()}",
          isSelected: state.paymentMethod.name == OrderPaymentMethod.values[1].name ? true : false),
    ),
    InkWell(
      onTap: () => paymentCubit.changePaymentMethod(method: OrderPaymentMethod.creditCard, state: state),
      child: paymentMethodContainer(
          image: "assets/photos/svg/order_module/credit_card_icon.svg",
          text: TranslationConstants.credit_card.translate(context).toCamelcase(),
          isSelected: state.paymentMethod.name == OrderPaymentMethod.values[2].name ? true : false),
    ),
  ]);
}

Widget payCash({
  required PaymentLoadedState state,
  required OrderLoadedState orderState,
  required BuildContext context,
}) {
  return Column(
    children: [
      CustomDropdownButton(
        titleTextAlignment: Alignment.centerLeft,
        scrolllingHeight: 120.h,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        padding: EdgeInsets.all(10.h),
        useTextField: true,
        selectedOptions: 'Select Receiver name',
        dataList: List.generate(5, (index) => "User ${index + 1}"),
        onOptionSelected: (String option) {},
      ),
      Row(
        children: [
          Checkbox(
            value: true,
            activeColor: appConstants.orderScreenSelectedCategoryColor,
            onChanged: (value) {},
          ),
          CommonWidget.commonText(text: TranslationConstants.you_collect.translate(context), fontSize: 15),
          CommonWidget.commonText(
              text: " ${orderState.colloectedAmount..formatCurrency()} ", fontSize: 15, fontWeight: FontWeight.bold),
          CommonWidget.commonText(text: TranslationConstants.on_cash.translate(context), fontSize: 15),
        ],
      )
    ],
  );
}

Widget payWithUpi({required BuildContext context}) {
  return CommonWidget.sizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.sizedBox(height: 10),
        CommonWidget.commonText(text: TranslationConstants.scan_and_pay.translate(context), fontSize: 15),
        CommonWidget.sizedBox(height: 15),
        CommonWidget.sizedBox(
          child: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/order_module/qr_code.svg",
            height: 200.h,
          ),
        ),
        CommonWidget.sizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/gpay_logo.svg", height: 18.h),
            CommonWidget.sizedBox(width: 10),
            CommonWidget.container(height: 23, width: 1, color: appConstants.neutral6Color.withOpacity(0.5)),
            CommonWidget.sizedBox(width: 10),
            CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/phonepe_logo.svg", height: 18.h),
            CommonWidget.sizedBox(width: 10),
            CommonWidget.container(height: 23, width: 1, color: appConstants.neutral6Color.withOpacity(0.5)),
            CommonWidget.sizedBox(width: 10.w),
            CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/paytm_logo.svg", height: 17.h),
          ],
        ),
        CommonWidget.sizedBox(height: 60),
      ],
    ),
  );
}

Widget paymentMethodContainer({required String image, required String text, required bool isSelected}) {
  return CommonWidget.container(
    height: 120,
    width: 100,
    color: appConstants.white,
    borderColor:
        isSelected ? appConstants.orderScreenSelectedCategoryColor : appConstants.orderScreenSearchFieldBorderColor,
    borderWidth: isSelected ? 1.8 : 1.5,
    isBorder: true,
    borderRadius: 10.r,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(imageUrl: image, height: 48)),
        CommonWidget.sizedBox(height: 10),
        CommonWidget.commonText(text: text, fontSize: 12),
      ],
    ),
  );
}
