// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/sort_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CustomerCubit extends Cubit<CustomerState> {
  late CounterCubit counterCubit;
  late SortFilterCubit sortFilterCubit;
  late SearchFilterCubit searchFilterCubit;
  CustomerCubit({
    required this.counterCubit,
    required this.sortFilterCubit,
    required this.searchFilterCubit,
  }) : super(CustomerLoadedState(customerDetailList: customerDetails, random: Random().nextDouble()));

  TextEditingController searchController = TextEditingController();
  List<String> valueList = ['All', '', ''];
  void reset({required CustomerLoadedState state}) {
    valueList = ['All', '', ''];
    searchController.clear();
    emit(CustomerLoadedState(customerDetailList: customerDetails, random: Random().nextDouble()));
  }

  void deleteCustomer({required CustomerDetailModel customerDetailModel}) {
    late CustomerLoadedState customerLoadedState;
    customerLoadedState = state as CustomerLoadedState;

    if (customerLoadedState != null) {
      customerLoadedState.customerDetailList.remove(customerDetailModel);

      emit(customerLoadedState.copyWith(
        customerDetailList: customerLoadedState.customerDetailList,
        random: Random().nextDouble(),
      ));
    }
  }

  void filterDataForFilterButton({required String value, required CustomerLoadedState state}) {
    if (value != "error") {
      List split = value.split(' _ ');
      valueList[0] = split[0];
      if (split.length > 1) {
        valueList[1] = split[1];
      } else {
        valueList[1] = "";
      }
    }

    filters(state: state);
  }

  void filterForSearch({required String value, required CustomerLoadedState state}) {
    filters(state: state);
  }

  void filterForDate({required String value, required CustomerLoadedState state}) {
    if (value != 'error') {
      valueList[2] = value;
    }

    filters(state: state);
  }

  void filters({required CustomerLoadedState state}) {
    List<CustomerDetailModel> filterList = [];
    List<CustomerDetailModel> mainList = customerDetails;
    List<CustomerDetailModel> filterLists = mainList;

    if (searchController.text.isNotEmpty) {
      filterList = [];
      String value = searchController.text;
      filterLists = mainList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    } else {
      filterLists = mainList;
    }

    if (valueList.isNotEmpty) {
      if (valueList[0] == "clear") {
        filterList = filterLists;
      } else if (valueList[0] == "All") {
        filterList = filterLists;
      } else {
        List customerTypeList = valueList[0].split(' ');

        for (var e in filterLists) {
          if (e.customerType.name == customerTypeList[0]) {
            filterList.add(e);
          }
        }
      }
    } else {
      filterList = filterLists;
    }
    if (valueList[1].isNotEmpty) {
      if (valueList[1] == filterCategoryByName[0]) {
        filterList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else if (valueList[1] == filterCategoryByName[1]) {
        filterList.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      } else if (valueList[1] == filterCategoryByName[2]) {
        filterList.sort((a, b) => b.totalOrderAmount.compareTo(a.totalOrderAmount));
      } else if (valueList[1] == filterCategoryByName[3]) {
        filterList.sort((a, b) => a.totalOrderAmount.compareTo(b.totalOrderAmount));
      }
    }
    List<CustomerDetailModel> filtersec = filterList;
    List customDateList = valueList[2].split(' - ');
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
          data: filtersec,
          filter: searchCategory,
          customEndDate: customDateList[2],
          customStartDate: customDateList[1],
        );
      }
    } else {
      filterList = [];
      filterList = filterDataByDate(
        data: filtersec,
        filter: searchCategory ?? SearchCategory.All,
      );
    }
    emit(state.copyWith(random: Random().nextDouble(), filterList: filterList));
  }

  List<CustomerDetailModel> filterDataByDate({
    required List<CustomerDetailModel> data,
    required SearchCategory filter,
    String? customStartDate,
    String? customEndDate,
  }) {
    DateTime dateTime = DateTime.now();
    DateTime currentDate = parseDate("${dateTime.day}/${dateTime.month}/${dateTime.year}");
    switch (filter) {
      case SearchCategory.Today:
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          if (e.date == "${dateTime.day}/${dateTime.month}/${dateTime.year}") {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Yesterday:
        DateTime yesterday = currentDate.add(const Duration(days: -1));
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          if (yesterday.day < 10) {
            if (e.date == "0${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          } else {
            if (e.date == "${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          }
        }
        return l1;
      case SearchCategory.Last_7_Days:
        DateTime last7DaysStart = currentDate.subtract(const Duration(days: 6));
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.date);
          if (tempDate.isAfter(last7DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_30_Days:
        DateTime last30DaysStart = currentDate.subtract(const Duration(days: 30));
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.date);
          if (tempDate.isAfter(last30DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.This_Month:
        DateTime dateTime = DateTime.now();
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          if (dateTime.month == int.parse(e.date.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_Month:
        DateTime dateTime = DateTime.now();
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          if (dateTime.month - 1 == int.parse(e.date.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Custom_Range:
        DateTime startDate = DateTime.parse(customStartDate ?? "");
        DateTime endDate = DateTime.parse(customEndDate ?? "");
        List<CustomerDetailModel> l1 = [];
        for (var e in data) {
          DateTime dateTime = DateTime.parse(
            "${e.date.substring(6, 10)}-${e.date.substring(3, 5)}-${e.date.substring(0, 2)}",
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
