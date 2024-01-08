import 'dart:async';
import 'dart:math';
import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/order_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/paymentCubit/payment_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/timeSlotCubit/time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final OrderCubit orderCubit;
  final CounterCubit counterCubit;
  final TimeSLotCubit timeSlotCubit;
  final PaymentCubit paymentCubit;

  ProductsCubit({
    required this.orderCubit,
    required this.counterCubit,
    required this.timeSlotCubit,
    required this.paymentCubit,
  }) : super(ProductsLoadingState());

  ProductsLoadedState? data;

  void fetchingInitialData({required String cate}) {
    List<ProductModel> data = [];

    for (var elemet in dummyProductsData) {
      if (elemet.category == cate) {
        data.add(elemet);
      }
    }

    ProductsLoadedState? productsLoadedState;

    if (state is ProductsLoadedState) {
      productsLoadedState = state as ProductsLoadedState;
      emit(productsLoadedState.copyWith(
        isSearchIsActive: false,
        random: Random().nextDouble(),
        filterdeData: data,
        productData: dummyProductsData,
        searchedData: dummyProductsData,
        selectedProduct: productsLoadedState.selectedProduct,
        checkScreenIndex: CheckScreen.product,
      ));
    } else {
      emit(
        ProductsLoadedState(
          isSearchIsActive: false,
          random: Random().nextDouble(),
          filterdeData: data,
          productData: dummyProductsData,
          searchedData: dummyProductsData,
          selectedProduct: const [],
          checkScreenIndex: CheckScreen.product,
        ),
      );
    }
  }

  void filterDataProcess({
    required String categoryType,
    required ProductsLoadedState state,
  }) {
    List<ProductModel> data = [];

    for (var elemet in dummyProductsData) {
      if (elemet.category == categoryType) {
        data.add(elemet);
      }
    }
    emit(state.copyWith(filterdeData: data));
  }

  void searchFromProducts({
    required FocusNode searchBarFocusNode,
    String? search,
    required ProductsLoadedState state,
  }) {
    searchBarFocusNode.addListener(
      () {
        if (searchBarFocusNode.hasFocus) {
          emit(state.copyWith(isSearchIsActive: true, searchedData: dummyProductsData));
        } else {
          Timer(
            const Duration(milliseconds: 700),
            () {
              emit(state.copyWith(
                  isSearchIsActive: false, searchedData: dummyProductsData, checkScreenIndex: CheckScreen.addProduct));
            },
          );
        }
      },
    );
    if (search != null) {
      List<ProductModel> searchedProducts = [];
      for (int i = 0; i < dummyProductsData.length; i++) {
        if (((dummyProductsData[i].category).contains(search.toLowerCase().trim()) == true) ||
            ((dummyProductsData[i].name).contains(search.toLowerCase().trim()) == true) ||
            ((dummyProductsData[i].flavour).contains(search.toLowerCase().trim()) == true)) {
          searchedProducts.add(dummyProductsData[i]);
        }
      }
      emit(state.copyWith(isSearchIsActive: true, random: Random().nextDouble(), searchedData: searchedProducts));
    }
  }

  bool sendSelectedDate({
    required ProductModel product,
    required ProductsLoadedState state,
    required CheckScreen checkScreen,
    required ProductsCubit productCubit,
    required OpeneingOrderScreenFrom openeingOrderScreenFrom,
    CustomerDetailModel? customerDetailModel,
  }) {
    bool adddata = false;
    List<ProductModel> selectedDate = [];
    selectedDate.addAll(state.selectedProduct);
    if (selectedDate.isEmpty) {
      selectedDate.add(product);
      for (var x in selectedDate) {
        if (x.selectedQuantity.isEmpty) {
          x.selectedQuantity.add(x.availableQuantity[0]);
        }
      }
    } else {
      adddata = true;
      for (var element in selectedDate) {
        if (element.productId == product.productId) {
          adddata = false;
          break;
        }
      }
      if (adddata) {
        selectedDate.add(product);
        for (var x in selectedDate) {
          if (x.selectedQuantity.isEmpty) {
            x.selectedQuantity.add(x.availableQuantity[0]);
          }
        }
      }
    }
    emit(state.copyWith(selectedProduct: selectedDate, checkScreenIndex: checkScreen));
    if (openeingOrderScreenFrom == OpeneingOrderScreenFrom.customerDetails) {
      CommonRouter.pushNamed(RouteList.order_screen,
          arguments: OrderScreenArgs(
            productCubit: productCubit,
            selectedProduct: selectedDate,
            openeingOrderScreenFrom: openeingOrderScreenFrom,
            displayAppBar: true,
            customerDetailModel: customerDetailModel,
          ));
    }
    return true;
  }

  void changePage({required CheckScreen checkScreen, required OpeneingOrderScreenFrom openeingOrderScreenFrom}) {
    ProductsLoadedState? state1 = getState();
    emit(state1!.copyWith(checkScreenIndex: checkScreen, random: Random().nextDouble()));
    if (openeingOrderScreenFrom == OpeneingOrderScreenFrom.customerDetails) {
      CommonRouter.pop();
    }
  }

  void clearAllSelectedDate() {
    ProductsLoadedState? state = getState();
    emit(state!.copyWith(selectedProduct: [], random: Random().nextDouble()));
  }

  ProductsLoadedState? getState() {
    if (state is ProductsLoadedState) {
      return state as ProductsLoadedState;
    } else {
      return null;
    }
  }
}
