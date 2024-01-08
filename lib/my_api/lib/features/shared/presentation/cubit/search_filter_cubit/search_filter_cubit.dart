import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchFilterCubit extends Cubit<SearchFilterState> {
  SearchFilterCubit() : super(const SearchFilterLoadedState(selectedFilter: []));

  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();

  void applyFilter({required String item}) {
    if (state is SearchFilterLoadedState) {
      var loadedState = state as SearchFilterLoadedState;

      List selectedFilter = [];
      bool isCustomRange = true;
      if (item.isNotEmpty && !selectedFilter.contains(item)) {
        selectedFilter.add(item);
        if (item == SearchCategory.Custom_Range.name) {
          isCustomRange = true;
        } else {
          isCustomRange = false;
        }
      }
      emit(
        loadedState.copyWith(
          selectedFilter: selectedFilter,
          isCustomRange: isCustomRange,
          random: Random().nextDouble(),
        ),
      );
    }
  }

  void removeFilter({required item, required List selectedFilter, bool? isCustomRange}) {
    if (state is SearchFilterLoadedState) {
      var loadedState = state as SearchFilterLoadedState;

      if (item != null && selectedFilter.contains(item)) {
        selectedFilter.remove(item);
        if (item == 'Custom Range') {
          isCustomRange = false;
        }
      }

      emit(
        loadedState.copyWith(
          selectedFilter: selectedFilter,
          isCustomRange: isCustomRange,
          random: Random().nextDouble(),
        ),
      );
    }
  }

  void getDate({required List<DateTime?> value}) {
    List<String> formattedDates = value.map((date) {
      return DateFormat('yyyy-MM-dd').format(date!);
    }).toList();

    if (formattedDates.length == 1) {
      String fromDate = formattedDates[0];

      fromdateController.text = fromDate;
      todateController.text = "";
    } else {
      String fromDate = formattedDates[0];
      String toDate = formattedDates[1];

      fromdateController.text = fromDate;
      todateController.text = toDate;
    }
  }
}
