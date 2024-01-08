import 'dart:math';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'marketing_state.dart';

enum SelectedTab { banner, popUp, notification }

class MarketingCubit extends Cubit<MarketingState> {
  late AddDeataisCubit addDeataisCubit;
  final SearchFilterCubit searchFilterCubit;
  final LoadingCubit loadingCubit;
  MarketingCubit({
    required this.addDeataisCubit,
    required this.searchFilterCubit,
    required this.loadingCubit,
  }) : super(
          MarketingLoadedState(
            selectedTab: SelectedTab.banner,
            marketingData: demoData,
            displayFilter: false,
          ),
        );

  List allDataList = ['All', ''];

  List dataArangeFilter = [
    "All",
    "Title (A to Z)",
    "Title (Z to A)",
    "Start Date (Increasing)",
    "Start Date (decreasing)",
  ];

  List<MarketingDataModel> oldFiltersData = [];
  TextEditingController searchField = TextEditingController();

  void changeMarketingMode({required MarketingLoadedState state, required int value}) {
    if (value == 0) {
      emit(state.copyWith(selectedTab: SelectedTab.banner));
    } else if (value == 1) {
      emit(state.copyWith(selectedTab: SelectedTab.popUp));
    } else if (value == 2) {
      emit(state.copyWith(selectedTab: SelectedTab.notification));
    }
  }

  void toggleSwitch({
    required MarketingLoadedState state,
    required List<MarketingDataModel> productData,
    required int index,
    required bool value,
  }) {
    productData[index].liveStatus = value;
    emit(state.copyWith(marketingData: productData, random: Random().nextDouble()));
  }

  void addData({required MarketingLoadedState state, required MarketingDataModel value}) {
    List<MarketingDataModel> addData = [];
    addData.addAll(state.marketingData);
    addData.add(value);
    emit(state.copyWith(random: Random().nextDouble(), marketingData: addData));
  }

  void deleteItem({required MarketingLoadedState state, required int index}) {
    List<MarketingDataModel> data = state.marketingData;
    data.removeAt(index);
    emit(state.copyWith(random: Random().nextDouble(), marketingData: data));
    CommonRouter.pop();
  }

  void resetData({required MarketingLoadedState state}) {
    emit(state.copyWith(displayFilter: false, marketingData: demoData, random: Random().nextDouble()));
  }

  void filterData({required MarketingLoadedState state, required String value}) {
    allDataList[0] = value;

    commonFilter(state: state);
  }

  void filterForDate({required String value, required MarketingLoadedState state}) {
    if (value != 'error') {
      allDataList[1] = value;
    }
    commonFilter(state: state);
  }

  void commonFilter({required MarketingLoadedState state}) {
    List<MarketingDataModel> tempList = demoData;
    List<MarketingDataModel> filterList = [];
    if (searchField.text.isNotEmpty) {
      filterList = [];
      filterList = tempList
          .where(
            (element) => element.title.toLowerCase().contains(searchField.text.toLowerCase()),
          )
          .toList();
    } else {
      filterList = tempList;
    }

    List<MarketingDataModel> filterLists = filterList;

    if (allDataList.isNotEmpty) {
      if (allDataList[0] != dataArangeFilter[0]) {
        if (allDataList[0] == dataArangeFilter[1]) {
          filterLists.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        } else if (allDataList[0] == dataArangeFilter[2]) {
          filterLists.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        } else if (allDataList[0] == dataArangeFilter[3]) {
          filterLists.sort((a, b) => parseDate(a.startDate).compareTo(parseDate(b.startDate)));
        } else if (allDataList[0] == dataArangeFilter[4]) {
          filterLists.sort((a, b) => parseDate(b.startDate).compareTo(parseDate(a.startDate)));
        }
      } else {
        filterLists = filterList;
      }
    }

    List<String> customDateList = allDataList[1].split(' - ');
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
          data: filterLists,
          filter: searchCategory,
          customEndDate: customDateList[2],
          customStartDate: customDateList[1],
        );
      }
    } else {
      filterList = [];
      filterList = filterDataByDate(
        data: filterLists,
        filter: searchCategory ?? SearchCategory.All,
      );
    }

    emit(state.copyWith(displayFilter: true, filteredAndSearchedData: filterList, random: Random().nextDouble()));
  }

  List<MarketingDataModel> filterDataByDate({
    required List<MarketingDataModel> data,
    required SearchCategory filter,
    String? customStartDate,
    String? customEndDate,
  }) {
    DateTime dateTime = DateTime.now();
    DateTime currentDate = parseDate("${dateTime.day}/${dateTime.month}/${dateTime.year}");
    switch (filter) {
      case SearchCategory.Today:
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          if (e.startDate == "${dateTime.day}/${dateTime.month}/${dateTime.year}") {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Yesterday:
        DateTime yesterday = currentDate.add(const Duration(days: -1));
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          if (yesterday.day < 10) {
            if (e.startDate == "0${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          } else {
            if (e.startDate == "${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          }
        }
        return l1;
      case SearchCategory.Last_7_Days:
        DateTime last7DaysStart = currentDate.subtract(const Duration(days: 6));
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.startDate);
          if (tempDate.isAfter(last7DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_30_Days:
        DateTime last30DaysStart = currentDate.subtract(const Duration(days: 30));
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.startDate);
          if (tempDate.isAfter(last30DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.This_Month:
        DateTime dateTime = DateTime.now();
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          List<String> list = e.startDate.split('/');
          if (dateTime.month == int.parse(list[1])) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_Month:
        DateTime dateTime = DateTime.now();
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          List<String> list = e.startDate.split('/');
          if (dateTime.month - 1 == int.parse(list[1])) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Custom_Range:
        DateTime startDate = DateTime.parse(customStartDate ?? "");
        DateTime endDate = DateTime.parse(customEndDate ?? "");
        List<MarketingDataModel> l1 = [];
        for (var e in data) {
          List<String> list = e.startDate.split('/');
          DateTime dateTime = parseDate("${list[0]}/${list[1]}/${list[2]}");
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
