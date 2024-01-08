// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/product_inventory/product_inventory_state.dart';
import 'package:bloc/bloc.dart';

class ProductInventoryCubit extends Cubit<ProductInventoryState> {
  ProductInventoryCubit()
      : super(ProductInventoryLoadedState(productInventoryModel: productInventoryList, random: Random().nextDouble()));

  void deleteProduct({required ProductInventoryModel productInventoryModel}) {
    late ProductInventoryLoadedState productInventoryLoadedState;
    productInventoryLoadedState = state as ProductInventoryLoadedState;

    if (productInventoryLoadedState != null) {
      productInventoryLoadedState.productInventoryModel.remove(productInventoryModel);

      emit(productInventoryLoadedState.copyWith(
        productInventoryModel: productInventoryLoadedState.productInventoryModel,
        random: Random().nextDouble(),
      ));
    }
  }
}
