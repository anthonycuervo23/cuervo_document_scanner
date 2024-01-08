import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/order_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_state.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/paymentCubit/payment_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/timeSlotCubit/time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/orderScreen/order_widget.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/widgets/payment_widgets.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends StatefulWidget {
  final OrderScreenArgs product;
  const OrderScreen({super.key, required this.product});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends OrderScreenWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: orderCubit,
      builder: (context, state) {
        if (state is OrderLoadedState) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color(0xffEDF6FF),
            appBar: widget.product.displayAppBar
                ? CustomAppBar(
                    context,
                    title: TranslationConstants.order.translate(context),
                    titleCenter: false,
                    onTap: () => CommonRouter.pop(),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CommonWidget.commonButton(
                        height: 40.h,
                        width: 80.w,
                        borderRadius: 20.r,
                        alignment: Alignment.center,
                        context: context,
                        text: TranslationConstants.save.translate(context),
                        textColor: appConstants.white,
                        onTap: () {
                          CustomerDetailModel customerDetailModel = orderCubit.addSelectedOrder(
                            state: state,
                            customerDetailModel: widget.product.customerDetailModel!,
                          );
                          CommonRouter.pushNamedAndRemoveUntil(
                            RouteList.customer_details_screen,
                            arguments: customerDetailModel,
                          );
                        },
                      ),
                    ),
                  )
                : null,
            body: state.selectedProducts.isEmpty
                ? CommonWidget.dataNotFound(
                    context: context,
                    actionButton: CommonWidget.commonButton(
                      context: context,
                      onTap: () => productsCubit.changePage(
                        checkScreen: CheckScreen.product,
                        openeingOrderScreenFrom: widget.product.openeingOrderScreenFrom,
                      ),
                      text: TranslationConstants.add_product.translate(context),
                      textColor: appConstants.white,
                      height: 45,
                      alignment: Alignment.center,
                      width: 150,
                    ),
                  )
                : ListView(
                    primary: true,
                    children: [
                      CommonWidget.container(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          color: appConstants.white,
                          alignment: Alignment.centerLeft,
                          child: CommonWidget.commonText(
                              text: TranslationConstants.item.toCamelcase(),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      productedView(state: state),
                      CommonWidget.sizedBox(height: 15),
                      addMoreItemsButton(),
                      CommonWidget.sizedBox(height: 15),
                      addInstructionsButton(),
                      CommonWidget.sizedBox(height: 15),
                      cupenDropDownView(state: state),
                      CommonWidget.sizedBox(height: 15),
                      diliveryMode(state: state),
                      CommonWidget.sizedBox(height: 15),
                      Visibility(
                        visible: state.delivaryMode.name == OrderDiliveryMode.delivary.name ? true : false,
                        child: BlocBuilder<TimeSLotCubit, TimeSLotState>(
                          bloc: timeSLotCubit,
                          builder: (context, timeSlotState) {
                            if (timeSlotState is TimeSLotCubitLoadedState) {
                              return Column(
                                children: [
                                  deliveryTimeSlot(state: timeSlotState),
                                  CommonWidget.sizedBox(height: 15),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      invoiceView(state: state),
                      CommonWidget.sizedBox(height: 15),
                      BlocBuilder<PaymentCubit, PaymentState>(
                        bloc: paymentCubit,
                        builder: (context, paymentState) {
                          if (paymentState is PaymentLoadedState) {
                            return paymentView(
                              state: paymentState,
                              orderState: state,
                              context: context,
                              paymentCubit: paymentCubit,
                            );
                          } else if (paymentState is PaymentLoadingState) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (paymentState is PaymentErrorState) {
                            return Center(child: CommonWidget.commonText(text: paymentState.errorMessage));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
          );
        } else if (state is OrderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderErrorState) {
          return Center(child: CommonWidget.commonText(text: state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
