// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'supplier_state.dart';

class SupplierCubit extends Cubit<SupplierState> {
  late CounterCubit counterCubit;
  late SortFilterCubit sortFilterCubit;
  late SearchFilterCubit searchFilterCubit;
  SupplierCubit({
    required this.counterCubit,
    required this.sortFilterCubit,
    required this.searchFilterCubit,
  }) : super(SupplierLoadingState());

  TextEditingController searchController = TextEditingController();
  int filterIndex = 0;
  List<String> valueList = ['', ''];

  void loadSupplierData() {
    emit(SupplierLoadedState(
      supplierDetailList: supplierList,
      random: Random().nextDouble(),
    ));
  }

  void deleteSupplier({required SupplierDetailModel supplierDetailModel}) {
    SupplierLoadedState supplierLoadedState;
    supplierLoadedState = state as SupplierLoadedState;

    if (supplierLoadedState != null) {
      supplierLoadedState.supplierDetailList.remove(supplierDetailModel);
      emit(supplierLoadedState.copyWith(
        supplierDetailList: supplierLoadedState.supplierDetailList,
        random: Random().nextDouble(),
      ));
    }
  }

  void filterDataForFilterButton({required int value, required SupplierLoadedState state}) {
    if (value == -1) {
      valueList[0] = "clear";
    } else if (value == -2) {
    } else {
      valueList[0] = value.toString();
    }

    filters(state: state);
  }

  void filterForSearch({required String value, required SupplierLoadedState state}) {
    filters(state: state);
  }

  void filterForDate({required String value, required SupplierLoadedState state}) {
    if (value != 'error') {
      valueList[1] = value;
    }

    filters(state: state);
  }

  void filters({required SupplierLoadedState state}) {
    List<SupplierDetailModel> mainList = supplierList;
    List<SupplierDetailModel> filterLists = mainList;

    if (searchController.text.isNotEmpty) {
      filterLists = [];
      String value = searchController.text;
      filterLists = mainList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    } else {
      filterLists = mainList;
    }

    if (valueList[0].isNotEmpty) {
      if (valueList[0] == "0") {
        filterLists.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else if (valueList[0] == "1") {
        filterLists.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      } else if (valueList[0] == "2") {
        filterLists.sort((a, b) => b.totalOrderAmount?.compareTo(a.totalOrderAmount ?? 0) ?? 0);
      } else if (valueList[0] == "3") {
        filterLists.sort((a, b) => a.totalOrderAmount?.compareTo(b.totalOrderAmount ?? 0) ?? 0);
      }
    }

    List<SupplierDetailModel> filtersec = filterLists;

    if (valueList[1].isNotEmpty) {
      filterLists = [];
      String formattedDate = '';
      if (valueList[1] == SearchCategory.Today.name) {
        DateTime dateTime = DateTime.now();

        DateFormat formatter = DateFormat('dd MMM yyyy');
        formattedDate = formatter.format(dateTime);

        for (var e in filtersec) {
          if (e.dateTime.substring(0, 11) == formattedDate) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1] == SearchCategory.Yesterday.name) {
        DateTime dateTime = DateTime.now().add(const Duration(days: -1));

        DateFormat formatter = DateFormat('dd MMM yyyy');
        formattedDate = formatter.format(dateTime);
        for (var e in filtersec) {
          if (e.dateTime.substring(0, 11) == formattedDate) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1] == SearchCategory.Last_7_Days.name) {
        DateTime dateTime = DateTime.now().add(const Duration(days: -7));
        for (var e in filtersec) {
          if (dateTime.isBefore(DateFormat("dd MMM yyyy").parse(e.dateTime))) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1] == SearchCategory.Last_30_Days.name) {
        DateTime dateTime = DateTime.now().add(const Duration(days: -30));
        for (var e in filtersec) {
          if (dateTime.isBefore(DateFormat("dd MMM yyyy").parse(e.dateTime))) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1] == SearchCategory.This_Month.name) {
        DateTime dateTime = DateTime.now();
        for (var e in filtersec) {
          if (dateTime.month == int.parse(DateFormat("dd MMM yyyy").parse(e.dateTime).toString().substring(5, 7))) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1] == SearchCategory.Last_Month.name) {
        DateTime dateTime = DateTime.now();
        for (var e in filtersec) {
          if (dateTime.month - 1 == int.parse(DateFormat("dd MMM yyyy").parse(e.dateTime).toString().substring(5, 7))) {
            filterLists.add(e);
          }
        }
      } else if (valueList[1].startsWith("Custom")) {
        List l1 = valueList[1].split(' - ');
        DateTime startDate = DateTime.parse(l1[1]);
        DateTime endDate = DateTime.parse(l1[2]);
        for (var e in mainList) {
          DateTime dateTime = DateFormat("dd MMM yyyy").parse(e.dateTime);
          if (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)) {
            filterLists.add(e);
          }
        }
      }
    }

    emit(state.copyWith(filterList: filterLists, random: Random().nextDouble()));
  }

  reset() {
    searchController.clear();
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    emit(SupplierLoadedState(supplierDetailList: supplierList, random: Random().nextDouble()));
  }
}
