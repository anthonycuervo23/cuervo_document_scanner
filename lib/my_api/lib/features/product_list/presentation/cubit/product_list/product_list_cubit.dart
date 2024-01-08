import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/sort_filter_for_order/sort_filter_for_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ToggleCubit productToggle;
  final SearchFilterCubit searchFilterCubit;
  final SortFilterForOrderCubit sortFilterForOrderCubit;
  final CounterCubit counterCubit;
  ProductListCubit(
      {required this.searchFilterCubit,
      required this.productToggle,
      required this.sortFilterForOrderCubit,
      required this.counterCubit})
      : super(ProductListLodedState());

  int selectedGroupValue = 1;
  String selectedVariantValue = "";
  TextEditingController searchController = TextEditingController();

  void updateSelectedGroupValue({required int value, required ProductListLodedState state}) {
    selectedGroupValue = value;
    emit(state.copyWith(selectedGroupValue: value));
  }

  void updateSelectedVariantValue({required String value, required ProductListLodedState state}) {
    selectedVariantValue = value;
    emit(state.copyWith(selectedVariantValue: value));
  }

  void sortFiter({required int index, required ProductListLodedState state}) {
    if (state.sortFilterIndex != index) {
      emit(state.copyWith(isSortFilterSelect: true, sortFilterIndex: index));
    } else {
      emit(state.copyWith(isSortFilterSelect: false, sortFilterIndex: index));
    }
  }

  void categoriesBrandSelling({required int index, required ProductListLodedState state}) {
    if (state.catagoryIndex != index) {
      emit(state.copyWith(isCatagorySelect: true, catagoryIndex: index));
    } else {
      emit(state.copyWith(isCatagorySelect: false, catagoryIndex: index));
    }
  }

  void updateProductActiveStatus({
    required ProductListModel productListModel,
    required bool isActive,
    required ProductListLodedState state,
  }) {
    productListModel.isActive = isActive;
    emit(state.copyWith(productModelList: List.from(state.productModelList ?? []), isActive: isActive));
  }
}
