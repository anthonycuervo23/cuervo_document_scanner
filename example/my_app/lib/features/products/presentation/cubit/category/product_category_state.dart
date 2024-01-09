import 'package:bakery_shop_flutter/features/products/data/models/product_category_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

sealed class ProductCategoryState extends Equatable {
  const ProductCategoryState();

  @override
  List<Object?> get props => [];
}

final class ProductCategopryInitialState extends ProductCategoryState {
  const ProductCategopryInitialState();

  @override
  List<Object> get props => [];
}

final class ProductCategopryLoadingState extends ProductCategoryState {
  const ProductCategopryLoadingState();

  @override
  List<Object> get props => [];
}

final class ProductCategopryLoadedState extends ProductCategoryState {
  final List<CategoryModel> categoryList;

  const ProductCategopryLoadedState({required this.categoryList});

  ProductCategopryLoadedState copywith({List<CategoryModel>? categoryList}) {
    return ProductCategopryLoadedState(categoryList: categoryList ?? this.categoryList);
  }

  @override
  List<Object> get props => [categoryList];
}

final class ProductCategopryErrorState extends ProductCategoryState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductCategopryErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
