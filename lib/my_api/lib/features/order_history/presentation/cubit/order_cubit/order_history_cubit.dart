import 'dart:math';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/data/model/order_history_model.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/sort_filter_for_order/sort_filter_for_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final SortFilterForOrderCubit sortFilterForOrderCubit;
  final SearchFilterCubit searchFilterCubit;
  final CounterCubit counterCubit;
  OrderHistoryCubit({
    required this.sortFilterForOrderCubit,
    required this.counterCubit,
    required this.searchFilterCubit,
  }) : super(OrderHistoryLoadingState());

  List<String> allDataList = ['All', 'All', '', ''];

  TextEditingController searchHistoryController = TextEditingController();

  void loadOrderData() {
    List<OrderHistoryModel> tempList = [];
    for (int i = 0; i < listOfOrder.length; i++) {
      if (listOfOrder[i].customerType.name.compareTo("customer") == 0) {
        tempList.add(listOfOrder[i]);
      }
    }
    emit(
      OrderHistoryLoadedState(
        orderList: tempList,
        random: Random().nextDouble(),
        filterValue: "customer",
      ),
    );
  }

  void changeData({required OrderHistoryLoadedState state, required String value}) {
    List<OrderHistoryModel> tempList = [];
    for (int i = 0; i < listOfOrder.length; i++) {
      if (value.compareTo(listOfOrder[i].customerType.name) == 0) {
        tempList.add(listOfOrder[i]);
      }
    }
    emit(state.copyWith(filterList: tempList, random: Random().nextDouble(), filterValue: value));
  }

  void filterData({required OrderHistoryLoadedState state, required List<String> list}) {
    if (list.length <= 1) {
    } else {
      allDataList[0] = list[0];
      allDataList[1] = list[1];
      allDataList[2] = list[2];
    }
    commonFilter(state: state);
  }

  void filterForDate({required String value, required OrderHistoryLoadedState state}) {
    if (value != 'error') {
      allDataList[3] = value;
    }
    commonFilter(state: state);
  }

  void commonFilter({required OrderHistoryLoadedState state}) {
    List<OrderHistoryModel> tempList = listOfOrder;
    List<OrderHistoryModel> filterList = [];
    List<OrderHistoryModel> finalFilterList = [];
    if (searchHistoryController.text.isNotEmpty) {
      filterList = [];
      filterList = tempList
          .where(
            (element) => element.customerName.toLowerCase().contains(searchHistoryController.text.toLowerCase()),
          )
          .toList();
    } else {
      filterList = tempList;
    }

    List<OrderHistoryModel> filterLists = filterList;

    if (allDataList[0].isNotEmpty) {
      filterList = [];
      if (allDataList[0] == 'All') {
        filterList = filterLists;
      } else {
        for (var e in filterLists) {
          if (allDataList[0] == e.amountDetailList.deliveryStatus?.name) {
            filterList.add(e);
          }
        }
      }
    } else {
      filterList = tempList;
    }
    List<OrderHistoryModel> filter1List = filterList;
    if (allDataList[1].isNotEmpty) {
      filterList = [];
      if (allDataList[1] == 'All') {
        filterList = filter1List;
      } else if (allDataList[1] == OrderPaymentMethod.Upi.name ||
          allDataList[1] == OrderPaymentMethod.CreditCard.name ||
          allDataList[1] == OrderPaymentMethod.Cash.name) {
        for (var e in filter1List) {
          if (allDataList[1] == e.amountDetailList.paymentStatus?.name) {
            filterList.add(e);
          }
        }
      } else if (allDataList[1] == OrderPaid.Paid.name || allDataList[1].toCamelcase() == OrderPaid.Unpaid.name) {
        for (var e in filter1List) {
          if (allDataList[1].toCamelcase() == e.amountDetailList.orderPaid?.name.toCamelcase()) {
            filterList.add(e);
          }
        }
      }
    }
    List<OrderHistoryModel> filter2List = filterList;
    if (allDataList[2].isNotEmpty) {
      filterList = [];
      if (allDataList[2] == 'Name:AtoZ') {
        filter2List.sort((a, b) => a.customerName.toLowerCase().compareTo(b.customerName.toLowerCase()));
        filterList = filter2List;
      } else if (allDataList[2] == 'Name:ZtoA') {
        filter2List.sort((a, b) => b.customerName.toLowerCase().compareTo(a.customerName.toLowerCase()));
        filterList = filter2List;
      } else if (allDataList[2] == 'Amount:HightoLow') {
        filter2List.sort(
          (a, b) => b.amountDetailList.totalAmount.toString().toLowerCase().compareTo(
                a.amountDetailList.totalAmount.toString().toLowerCase(),
              ),
        );
        filterList = filter2List;
      } else if (allDataList[2] == 'Amount:LowtoHigh') {
        filter2List.sort(
          (a, b) => a.amountDetailList.totalAmount.toString().toLowerCase().compareTo(
                b.amountDetailList.totalAmount.toString().toLowerCase(),
              ),
        );
        filterList = filter2List;
      }
    }
    List<OrderHistoryModel> filter3List = filterList;
    List<String> customDateList = allDataList[3].split(' - ');
    SearchCategory? searchCategory;
    for (var e in SearchCategory.values) {
      if (customDateList[0] == e.name) {
        searchCategory = e;
      }
    }
    if (customDateList[0] == SearchCategory.Custom_Range.name) {
      filterList = [];
      if (searchCategory != null) {
        filterList = filterDataByDate(
          data: filter3List,
          filter: searchCategory,
          customEndDate: customDateList[2],
          customStartDate: customDateList[1],
        );
      }
    } else {
      filterList = [];
      filterList = filterDataByDate(
        data: filter3List,
        filter: searchCategory ?? SearchCategory.All,
      );
    }

    for (var e in filterList) {
      if (e.customerType.name == state.filterValue) {
        finalFilterList.add(e);
      }
    }
    emit(state.copyWith(filterList: finalFilterList, random: Random().nextDouble()));
  }

  List<OrderHistoryModel> filterDataByDate({
    required List<OrderHistoryModel> data,
    required SearchCategory filter,
    String? customStartDate,
    String? customEndDate,
  }) {
    DateTime dateTime = DateTime.now();
    DateTime currentDate = parseDate("${dateTime.day}/${dateTime.month}/${dateTime.year}");
    switch (filter) {
      case SearchCategory.Today:
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          if (e.orderDate == "${dateTime.day}/${dateTime.month}/${dateTime.year}") {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Yesterday:
        DateTime yesterday = currentDate.add(const Duration(days: -1));
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          if (yesterday.day < 10) {
            if (e.orderDate == "0${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          } else {
            if (e.orderDate == "${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          }
        }
        return l1;
      case SearchCategory.Last_7_Days:
        DateTime last7DaysStart = currentDate.subtract(const Duration(days: 6));
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.orderDate);
          if (tempDate.isAfter(last7DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_30_Days:
        DateTime last30DaysStart = currentDate.subtract(const Duration(days: 30));
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.orderDate);
          if (tempDate.isAfter(last30DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.This_Month:
        DateTime dateTime = DateTime.now();
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          if (dateTime.month == int.parse(e.orderDate.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_Month:
        DateTime dateTime = DateTime.now();
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          if (dateTime.month - 1 == int.parse(e.orderDate.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Custom_Range:
        DateTime startDate = DateTime.parse(customStartDate ?? "");
        DateTime endDate = DateTime.parse(customEndDate ?? "");
        List<OrderHistoryModel> l1 = [];
        for (var e in data) {
          DateTime dateTime = DateTime.parse(
            "${e.orderDate.substring(6, 10)}-${e.orderDate.substring(3, 5)}-${e.orderDate.substring(0, 2)}",
          );
          if (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)) {
            l1.add(e);
          }
        }
        return l1;
      default:
        return data;
    }
  }
}
