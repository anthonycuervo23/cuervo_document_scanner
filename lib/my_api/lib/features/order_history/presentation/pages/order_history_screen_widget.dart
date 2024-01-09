import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/data/model/order_history_model.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/order_cubit/order_history_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/pages/order_history_screen_view.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OrderHistoryScreenWidget extends State<OrderHistoryScreen> {
  late BottomNavigationCubit bottomNavigationCubit;

  @override
  void initState() {
    bottomNavigationCubit = BlocProvider.of<BottomNavigationCubit>(context);
    super.initState();
  }

  Widget totalPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            allText(text: "${TranslationConstants.total_order.translate(context)} : ", color: const Color(0xff4392F1)),
            allText(text: "1000000"),
          ],
        ),
        Row(
          children: [
            allText(
              text: "${TranslationConstants.total_pending_order.translate(context)} : ",
              color: const Color(0xffFF4343),
            ),
            allText(text: "100"),
          ],
        ),
      ],
    );
  }

  Widget commonOrderBox({
    required OrderHistoryModel orderModel,
    required OrderHistoryLoadedState state,
    required int index,
  }) {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.only(bottom: 7.h),
      color: Colors.white,
      borderRadius: 15.r,
      child: Column(
        children: [
          orderDateAndId(orderModel: orderModel, state: state, index: index),
          SizedBox(height: 0.h),
          Container(
            width: ScreenUtil().screenWidth,
            alignment: Alignment.centerRight,
            child: Container(
              alignment: Alignment.centerLeft,
              width: ScreenUtil().screenWidth * 0.83,
              child: CommonWidget.commonDashLine(),
            ),
          ),
          customerDetail(orderModel: orderModel, state: state),
          productDetails(orderModel: orderModel, state: state),
          SizedBox(height: 7.h),
          centerView(orderModel: orderModel, state: state),
          SizedBox(height: 7.h),
          CommonWidget.commonDashLine(),
          SizedBox(height: 5.h),
          productPrice(orderModel: orderModel, state: state),
        ],
      ),
    );
  }

  Widget centerView({required OrderHistoryModel orderModel, required OrderHistoryLoadedState state}) {
    if (orderModel.customerType == CustomerType.customer) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            allText(text: "${TranslationConstants.cooking_instructions.translate(context)}: ", bold: true),
            SizedBox(
              width: ScreenUtil().screenWidth * 0.50,
              child: allText(text: "Write “Happy Birthday Shivani” on cake."),
            ),
          ],
        ),
      );
    } else if (orderModel.customerType == CustomerType.supplier) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Row(
              children: [
                allText(text: TranslationConstants.gst_tax.translate(context)),
                allText(text: "@18%", bold: true),
              ],
            ),
            SizedBox(width: 15.w),
            Row(
              children: [
                allText(text: TranslationConstants.gst_amount.translate(context)),
                allText(text: "₹135", bold: true, color: const Color(0xff4392F1)),
              ],
            ),
          ],
        ),
      );
      // Return Order Taken Name
    } else if (orderModel.customerType == CustomerType.supplierReturnList) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            allText(text: TranslationConstants.return_order_taken_name.translate(context)),
            allText(text: "Sahil Mavani", bold: true),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget orderDateAndId({
    required OrderHistoryModel orderModel,
    required OrderHistoryLoadedState state,
    required int index,
  }) {
    return CommonWidget.container(
      height: 35.h,
      isBorderOnlySide: true,
      topLeft: 15.r,
      topRight: 15.r,
      color: const Color(0xffFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.container(
            height: 35.h,
            width: 25.w,
            isBorderOnlySide: true,
            topLeft: 15.r,
            color: const Color(0xffBBDAFF),
            alignment: Alignment.center,
            child: allText(text: "#${index + 1}", fontSize: 14.sp, bold: true),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                allText(text: TranslationConstants.order_ID.translate(context), bold: true),
                allText(text: orderModel.orderId),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                allText(text: TranslationConstants.order_date.translate(context), bold: true),
                allText(text: orderModel.orderDate),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customerDetail({required OrderHistoryModel orderModel, required OrderHistoryLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        children: [
          allText(text: orderModel.customerName, fontSize: 14.sp, bold: true),
          const Spacer(),
          SizedBox(
            width: ScreenUtil().screenWidth * 0.5,
            child: allText(text: orderModel.address),
          ),
        ],
      ),
    );
  }

  Widget productDetails({required OrderHistoryModel orderModel, required OrderHistoryLoadedState state}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            orderModel.productList.length,
            (index) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10.w),
                allText(text: "${index + 1}. "),
                SizedBox(
                  width: 130.w,
                  child: allText(text: orderModel.productList[index].productName),
                ),
                SizedBox(
                  width: 70.w,
                  child: allText(text: orderModel.productList[index].productQuanitiy),
                ),
                allText(text: orderModel.productList[index].productPrice),
              ],
            ),
          ),
        ),
        const Spacer(),
        CommonWidget.container(
          height: 35.h,
          width: 70.w,
          color: const Color(0xff084277),
          isBorderOnlySide: true,
          topLeft: 20.r,
          bottomLeft: 20.r,
          alignment: Alignment.center,
          child: allText(text: "Bill Copy", color: Colors.white, fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget productPrice({required OrderHistoryModel orderModel, required OrderHistoryLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  allText(text: TranslationConstants.total_amount.translate(context)),
                  allText(
                    text: int.parse(orderModel.amountDetailList.totalAmount!).formatCurrency(),
                    bold: true,
                    color: const Color(0xff4392F1),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  allText(text: TranslationConstants.payment_status.translate(context)),
                  Visibility(
                    visible: orderModel.amountDetailList.orderPaid == OrderPaid.Paid,
                    child: allText(
                      text: orderModel.amountDetailList.orderPaid?.name.toCamelcase() ?? "",
                      color: const Color(0xff4392F1),
                      bold: true,
                    ),
                  ),
                  Visibility(
                    visible: orderModel.amountDetailList.orderPaid == OrderPaid.Paid,
                    child: allText(
                      text: orderModel.amountDetailList.paymentStatus == OrderPaymentMethod.CreditCard
                          ? "(${orderModel.amountDetailList.paymentStatus?.name})"
                          : "(${orderModel.amountDetailList.paymentStatus?.name.toUpperCase()})",
                      color: const Color(0xff084277),
                      bold: true,
                    ),
                  ),
                  Visibility(
                    visible: orderModel.amountDetailList.orderPaid == OrderPaid.Unpaid,
                    child: allText(
                      text: orderModel.amountDetailList.orderPaid?.name.toCamelcase() ?? "",
                      color: const Color(0xff4392F1),
                      bold: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  allText(text: TranslationConstants.balance.translate(context)),
                  allText(text: orderModel.amountDetailList.totalAmount ?? "", bold: true),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Visibility(
                    visible: orderModel.amountDetailList.orderPaid != OrderPaid.Unpaid,
                    child: allText(
                      text: TranslationConstants.delivery_status.translate(context),
                    ),
                  ),
                  allText(
                    text: orderModel.amountDetailList.deliveryStatus?.name.toCamelcase() ?? "",
                    color: const Color(0xffFF4343),
                    bold: true,
                  )
                ],
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
}
