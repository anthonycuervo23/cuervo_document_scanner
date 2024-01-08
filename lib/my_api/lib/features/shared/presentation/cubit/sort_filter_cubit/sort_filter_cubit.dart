import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_filter_state.dart';

class SortFilterCubit extends Cubit<SortFilterState> {
  SortFilterCubit()
      : super(
          SortFilterLoadedState(
            selectedFilterByName: const [],
            random: Random().nextDouble(),
            selectedFilterByPrice: const [],
          ),
        );

  void applyFilterByName({required item}) {
    if (state is SortFilterLoadedState) {
      var loadedState = state as SortFilterLoadedState;

      List selectedFilter = [];

      if (item != null && !selectedFilter.contains(item)) {
        selectedFilter.add(item);
      }

      emit(
        loadedState.copyWith(selectedFilterByName: selectedFilter, random: Random().nextDouble()),
      );
    }
  }

  void applyFilterByPrice({
    required item,
    required SortFilterLoadedState state,
  }) {
    List selectedFilter = [];

    if (item != null && !selectedFilter.contains(item)) {
      selectedFilter.add(item);
    }

    emit(
      state.copyWith(selectedFilterByPrice: selectedFilter, random: Random().nextDouble()),
    );
  }

  void removeFilter({
    required item,
    required List selectedFilter,
    required bool checkRemove,
    required SortFilterLoadedState state,
  }) {
    if (checkRemove) {
      // name
      emit(state.copyWith(selectedFilterByName: [], random: Random().nextDouble()));
    } else {
      // price
      emit(state.copyWith(selectedFilterByPrice: [], random: Random().nextDouble()));
    }
  }
}



// sort filter cubit