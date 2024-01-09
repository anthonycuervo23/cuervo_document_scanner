import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

sealed class AddNewProductState extends Equatable {
  const AddNewProductState();

  @override
  List<Object?> get props => [];
}

class AddNewProductInitialState extends AddNewProductState {
  @override
  List<Object?> get props => [];
}

class AddNewProductLoadingState extends AddNewProductState {
  @override
  List<Object?> get props => [];
}

class AddNewProductLoadedState extends AddNewProductState {
  final int? selectedCategoryIndex;
  final String? selectedcategory;
  final int? selectedBrandIndex;
  final String? selectedBrand;
  final double? random;
  final bool? chooseAttributeshow;
  final String? chooseAttributesOption;
  final bool? isSelect;
  final int? index;
  final int? selectedTaxValue;
  final int? selectedDiscountValue;
  final int? itemCount;

  const AddNewProductLoadedState({
    this.selectedCategoryIndex,
    this.selectedcategory,
    this.selectedBrand,
    this.selectedBrandIndex,
    this.random,
    this.chooseAttributesOption,
    this.chooseAttributeshow,
    this.index,
    this.isSelect,
    this.selectedTaxValue,
    this.selectedDiscountValue,
    this.itemCount,
  });

  AddNewProductLoadedState copyWith({
    int? selectedCategoryIndex,
    String? selectedcategory,
    int? selectedBrandIndex,
    String? selectedBrand,
    double? random,
    bool? chooseAttributeshow,
    String? chooseAttributesOption,
    bool? isSelect,
    int? index,
    int? selectedTaxValue,
    int? selectedDiscountValue,
    int? itemCount,
  }) {
    return AddNewProductLoadedState(
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedcategory: selectedcategory ?? this.selectedcategory,
      selectedBrandIndex: selectedBrandIndex ?? this.selectedBrandIndex,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      random: random ?? this.random,
      chooseAttributesOption: chooseAttributesOption ?? this.chooseAttributesOption,
      chooseAttributeshow: chooseAttributeshow ?? this.chooseAttributeshow,
      index: index ?? this.index,
      isSelect: isSelect ?? this.isSelect,
      selectedTaxValue: selectedTaxValue ?? this.selectedTaxValue,
      selectedDiscountValue: selectedDiscountValue ?? this.selectedDiscountValue,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  List<Object?> get props => [
        selectedcategory,
        selectedBrand,
        selectedBrandIndex,
        selectedCategoryIndex,
        random,
        chooseAttributeshow,
        chooseAttributesOption,
        index,
        isSelect,
        selectedTaxValue,
        selectedDiscountValue,
        itemCount,
      ];
}

class AddNewProductErrorState extends AddNewProductState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AddNewProductErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
