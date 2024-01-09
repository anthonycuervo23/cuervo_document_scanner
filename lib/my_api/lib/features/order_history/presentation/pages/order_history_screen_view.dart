// ignore_for_file: library_private_types_in_public_api

import 'package:bakery_shop_admin_flutter/features/order_history/data/model/order_history_model.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/order_cubit/order_history_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/pages/order_history_screen_widget.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/widget/sort_filter_for_order.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends OrderHistoryScreenWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appConstants.backGroundColor,
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        bloc: orderHistoryCubit,
        builder: (context, state) {
          if (state is OrderHistoryLoadedState) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w),
                  color: Colors.white,
                  child: Column(
                    children: [
                      totalPrice(),
                      SizedBox(height: 5.h),
                      commonSearchAndFilterField(
                        onChanged: (v) {
                          orderHistoryCubit.commonFilter(state: state);
                        },
                        controller: orderHistoryCubit.searchHistoryController,
                        context: context,
                        onTapSearchCalenderButton: () async {
                          String value = await searchFilterDialog(
                                context: context,
                                searchFilterCubit: orderHistoryCubit.searchFilterCubit,
                              ) ??
                              "error";
                          orderHistoryCubit.filterForDate(value: value, state: state);
                        },
                        onTapForFilter: () async {
                          FocusScope.of(context).unfocus();
                          Future.delayed(
                            const Duration(milliseconds: 200),
                            () async {
                              String value = await sortFilterForOrderDialog(
                                    orderState: state,
                                    orderCubit: orderHistoryCubit,
                                    context: context,
                                    counterCubit: orderHistoryCubit.counterCubit,
                                    sortFilterForOrderCubit: orderHistoryCubit.sortFilterForOrderCubit,
                                  ) ??
                                  "All";
                              List<String> l1 = value.split(' ');
                              orderHistoryCubit.filterData(state: state, list: l1);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.filterList != null && state.filterList!.isEmpty
                      ? CommonWidget.dataNotFound(
                          context: context,
                          actionButton: const SizedBox.shrink(),
                          bgColor: Colors.transparent,
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(10.h),
                          primary: true,
                          itemCount: state.filterList == null ? state.orderList.length : state.filterList?.length,
                          itemBuilder: (context, index) {
                            OrderHistoryModel orderHistoryModel = state.filterList?[index] ?? state.orderList[index];
                            return commonOrderBox(
                              orderModel: orderHistoryModel,
                              state: state,
                              index: index,
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
