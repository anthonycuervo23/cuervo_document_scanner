import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_filter_for_order_state.dart';

class SortFilterForOrderCubit extends Cubit<SortFilterForOrderState> {
  SortFilterForOrderCubit()
      : super(
          const SortFilterForOrderLoadedState(
            selectedFilterByName: [],
            selectedFilterByPrice: [],
            typeIndex: 0,
            deliveryTypeIndex: 0,
            paymentTypeIndex: 0,
          ),
        );

  void applyFilterByName({required item, required SortFilterForOrderLoadedState state}) {
    List<String> selectedFilter = [];

    if (item != null && !selectedFilter.contains(item)) {
      selectedFilter.add(item);
    }

    emit(
      state.copyWith(selectedFilterByName: selectedFilter, random: Random().nextDouble()),
    );
  }

  void applyFilterByPrice({
    required item,
    required,
    required SortFilterForOrderLoadedState state,
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
    required SortFilterForOrderLoadedState state,
  }) {
    if (checkRemove) {
      // name
      emit(state.copyWith(selectedFilterByName: [], random: Random().nextDouble()));
    } else {
      // price
      emit(state.copyWith(selectedFilterByPrice: [], random: Random().nextDouble()));
    }
  }

  void changeTypes({required SortFilterForOrderLoadedState state, required int index}) {
    emit(state.copyWith(typeIndex: index));
  }

  void deliveryChangeIndex({required int index, required SortFilterForOrderLoadedState state}) {
    emit(state.copyWith(deliveryTypeIndex: index, random: Random().nextDouble()));
  }

  void paymentChangeIndex({required int index, required SortFilterForOrderLoadedState state}) {
    emit(state.copyWith(paymentTypeIndex: index, random: Random().nextDouble()));
  }
}
