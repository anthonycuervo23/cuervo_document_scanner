import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AddNewProductCubit extends Cubit<AddNewProductState> {
  final ToggleCubit customizetoggleCubit;
  final ToggleCubit pinPriorityCubit;
  final ToggleCubit appliveCubit;
  final ToggleCubit showCatelogeCubit;
  final PickImageCubit pickCatelogImagCubit;
  final PickImageCubit pickUploadImagCubit;
  AddNewProductCubit({
    required this.customizetoggleCubit,
    required this.pinPriorityCubit,
    required this.appliveCubit,
    required this.showCatelogeCubit,
    required this.pickCatelogImagCubit,
    required this.pickUploadImagCubit,
  }) : super(const AddNewProductLoadedState());

  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController selfPointController = TextEditingController();
  TextEditingController autoPriceController = TextEditingController();
  TextEditingController autoDiscountController = TextEditingController();
  TextEditingController autoSellingPriceController = TextEditingController();
  TextEditingController autoQuantityController = TextEditingController();
  TextEditingController autoSelfPointController = TextEditingController();

  ScrollController scrollController = ScrollController();
  List<String> chooseattributeList = [];
  int itemCount = 1;
  int selectedTaxValue = 1;
  int selectedDiscountValue = 1;

// referral pont:
  void incrementItemCount({required AddNewProductLoadedState state}) {
    emit(
      state.copyWith(itemCount: itemCount++),
    );
  }

// tax and dicount:
  void updateSelectedTaxValue({required AddNewProductLoadedState state, required int value}) {
    selectedTaxValue = value;
    emit(
      state.copyWith(selectedTaxValue: value),
    );
  }

  void updateDiscountValue({required AddNewProductLoadedState state, required int value}) {
    selectedDiscountValue = value;
    emit(
      state.copyWith(selectedDiscountValue: value),
    );
  }

// category and brand:

  void changeCategory({
    required int index,
    required String category,
    required AddNewProductLoadedState state,
  }) {
    final newState = state.copyWith(
      selectedCategoryIndex: index,
      selectedcategory: category,
    );
    emit(newState);
  }

  void changeBrand({
    required int index,
    required String brand,
    required AddNewProductLoadedState state,
  }) {
    final newState = state.copyWith(
      selectedBrandIndex: index,
      selectedBrand: brand,
    );
    emit(newState);
  }

// choose attributes:

  void changeChooseAttributesOptions({
    required String chooseAttributesOption,
    required AddNewProductLoadedState state,
  }) {
    emit(
      state.copyWith(
        chooseAttributesOption: chooseAttributesOption,
        random: Random().nextDouble(),
      ),
    );
  }

  void selectChooseAttributesoption({
    required AddNewProductLoadedState state,
    required bool value,
  }) {
    emit(state.copyWith(chooseAttributeshow: value));
  }

  void removeAttribute({
    required int index,
    required AddNewProductLoadedState state,
    required bool isSelect,
  }) {
    if (isSelect) {
      chooseattributeList.removeAt(index);
      emit(state.copyWith(
        isSelect: isSelect,
        index: index,
        random: Random().nextDouble(),
      ));
    }
  }
}
