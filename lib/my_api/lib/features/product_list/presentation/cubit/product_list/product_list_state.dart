import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitialState extends ProductListState {
  const ProductListInitialState();

  @override
  List<Object> get props => [];
}

class ProductListLodingState extends ProductListState {
  const ProductListLodingState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ProductListLodedState extends ProductListState {
  final bool? isSortFilterSelect;
  final int? sortFilterIndex;
  final bool? isCatagorySelect;
  final int? catagoryIndex;
  final int? selectedGroupValue;
  bool? isActive;
  final String? selectedVariantValue;

  final List<ProductListModel>? productModelList;

  ProductListLodedState({
    this.isSortFilterSelect,
    this.sortFilterIndex,
    this.isCatagorySelect,
    this.catagoryIndex,
    this.selectedGroupValue,
    this.isActive,
    this.selectedVariantValue,
    this.productModelList,
  });

  ProductListLodedState copyWith({
    bool? isSortFilterSelect,
    int? sortFilterIndex,
    bool? isCatagorySelect,
    int? catagoryIndex,
    int? selectedGroupValue,
    String? selectedVariantValue,
    bool? isActive,
    ProductListModel? productListModel,
    List<ProductListModel>? productModelList,
  }) {
    return ProductListLodedState(
      isSortFilterSelect: isSortFilterSelect ?? this.isSortFilterSelect,
      sortFilterIndex: sortFilterIndex ?? this.sortFilterIndex,
      isCatagorySelect: isCatagorySelect ?? this.isCatagorySelect,
      catagoryIndex: catagoryIndex ?? this.catagoryIndex,
      selectedGroupValue: selectedGroupValue ?? this.selectedGroupValue,
      isActive: isActive ?? this.isActive,
      selectedVariantValue: selectedVariantValue ?? this.selectedVariantValue,
      productModelList: productModelList ?? this.productModelList,
    );
  }

  @override
  List<Object?> get props => [
        isSortFilterSelect,
        sortFilterIndex,
        isCatagorySelect,
        catagoryIndex,
        selectedGroupValue,
        isActive,
        selectedVariantValue,
        productModelList,
      ];
}

class ProductListErrorState extends ProductListState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductListErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
