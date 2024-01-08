import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class ProductInventoryState extends Equatable {
  const ProductInventoryState();

  @override
  List<Object?> get props => [];
}

class ProductInventoryInitial extends ProductInventoryState {
  @override
  List<Object> get props => [];
}

class ProductInventoryLoadedState extends ProductInventoryState {
  final List<ProductInventoryModel> productInventoryModel;
  final double? random;

  const ProductInventoryLoadedState({required this.productInventoryModel, this.random});

  ProductInventoryLoadedState copyWith({
    List<ProductInventoryModel>? productInventoryModel,
    double? random,
  }) {
    return ProductInventoryLoadedState(
      productInventoryModel: productInventoryModel ?? this.productInventoryModel,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        productInventoryModel,
        random,
      ];
}

class ProductInventoryErrorState extends ProductInventoryState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductInventoryErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
