import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_state.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum OrderDiliveryMode { now, delivary }

class OrderCubit extends Cubit<OrderState> {
  final LoadingCubit loadingCubit;
  OrderCubit({
    required this.loadingCubit,
  }) : super(OrderLoadingState());

  TextEditingController txtCookingInstructionsController = TextEditingController();
  List<DropdownMenuItem<String>> quantityDropDownItems = [];
  List<DropdownMenuItem<String>> cuponsDropDownItems = [];
  int bottomSheetRadioButtonIndex = 0;

  void initialFetchData({required List<ProductModel> selectedProducts}) {
    loadingCubit.show();
    emit(
      OrderLoadedState(
        selectedProducts: selectedProducts,
        isMenuOpen: false,
        availableCupons: cupons,
        selectedCupon: CupponModel(offerPersentage: 0, savedAmount: 0, maxAmt: 0),
        random: Random().nextDouble(),
        balanceAmount: 200,
        coupenDiscount: 0,
        discount: 0,
        colloectedAmount: 0,
        gstCharge: 0,
        itemTotal: 0,
        total: 0,
        walletPoints: 0,
        delivaryCharge: 50,
        delivaryMode: OrderDiliveryMode.now,
      ),
    );
    itemTotal(productData: selectedProducts);
    loadingCubit.hide();
  }

  void increasQuantity({required QuantityModel product, required OrderLoadedState state}) {
    product.piecs = product.piecs + 1;
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void decreaseQuantity(
      {required QuantityModel product,
      required List<ProductModel> rawProducts,
      required int productIndex,
      required int quantityIndex,
      required OrderLoadedState state}) {
    if (product.piecs > 1) {
      product.piecs = product.piecs - 1;
      emit(state.copyWith(random: Random().nextDouble()));
    } else {
      romoveProduct(rawProduct: rawProducts, productIndex: productIndex, quantityIndex: quantityIndex, state: state);
    }
  }

  void romoveProduct(
      {required List<ProductModel> rawProduct,
      required int productIndex,
      required int quantityIndex,
      required OrderLoadedState state}) {
    rawProduct[productIndex].selectedQuantity[quantityIndex].piecs = 1;
    rawProduct[productIndex].selectedQuantity.removeAt(quantityIndex);

    if (rawProduct[productIndex].selectedQuantity.isEmpty) {
      rawProduct.removeAt(productIndex);
    }
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void addQuantityOfProduct({
    required List<ProductModel> productsData,
    required int productIndex,
    required QuantityModel selectedQuantity,
    required OrderLoadedState state,
  }) {
    loadingCubit.show();
    bool addData = true;
    for (int i = 0; i < productsData[productIndex].selectedQuantity.length; i++) {
      addData = true;
      if ((selectedQuantity.quantity == productsData[productIndex].selectedQuantity[i].quantity) &&
          (selectedQuantity.price == productsData[productIndex].selectedQuantity[i].price) &&
          (selectedQuantity.quantityType == productsData[productIndex].selectedQuantity[i].quantityType)) {
        addData = false;
        increasQuantity(product: productsData[productIndex].selectedQuantity[i], state: state);
        break;
      }
    }
    if (addData == true) {
      productsData[productIndex].selectedQuantity.add(selectedQuantity);
      emit(state.copyWith(selectedProducts: productsData, random: Random().nextDouble()));
    }
    loadingCubit.hide();
  }

  void amountCompilationProcess({
    required OrderLoadedState state,
    double? delivaryCharge,
    double? cupponDiscount,
    double? walletPoints,
    double? balanceAmount,
    double? itemTotal,
    OrderDiliveryMode? delivaryMode,
    CupponModel? cuppon,
    bool? isDropDownActive,
  }) {
    double gstCharge = 0;
    double discount = 0;
    double total = 0;
    double collectedAmount = 0;

    itemTotal = itemTotal ?? state.itemTotal;
    discount = walletPoints ?? state.walletPoints + (cupponDiscount ?? state.coupenDiscount);
    gstCharge = itemTotal * (18 / 100);
    if (state.delivaryMode.name == OrderDiliveryMode.delivary.name) {
      total = ((itemTotal + gstCharge) + (delivaryCharge ?? state.delivaryCharge)) - discount;
    } else {
      total = ((itemTotal + gstCharge) - discount);
    }
    collectedAmount = total - state.balanceAmount;

    emit(state.copyWith(
      balanceAmount: balanceAmount,
      colloectedAmount: collectedAmount,
      coupenDiscount: cupponDiscount,
      delivaryCharge: delivaryCharge,
      discount: discount,
      gstCharge: gstCharge,
      itemTotal: itemTotal,
      total: total,
      walletPoints: walletPoints,
      delivaryMode: delivaryMode,
      selectedCupon: cuppon,
      isMenuOpen: isDropDownActive,
    ));
  }

//! below all methods is totaly based on amountCompilationProcess
  void addCuppon({
    required CupponModel cuppon,
    required OrderLoadedState state,
    required double cuponDiscount,
  }) {
    amountCompilationProcess(
        state: state, cupponDiscount: cuponDiscount, cuppon: cuppon, isDropDownActive: false, walletPoints: 20);
  }

  void isDropDownActive({required bool isDropDownActive, required OrderLoadedState state}) {
    amountCompilationProcess(state: state, isDropDownActive: isDropDownActive);
  }

  void itemTotal({required List<ProductModel> productData}) {
    OrderLoadedState? state = getState();
    double quantityTotal = 0;
    double itemTotal = 0;
    for (var x in productData) {
      for (var y in x.selectedQuantity) {
        quantityTotal = (y.price * y.piecs).toDouble();
        itemTotal = itemTotal + quantityTotal;
      }
    }
    amountCompilationProcess(state: state!, itemTotal: itemTotal);
  }

  void countDiscount({required double cuponDiscount, required double wallenPoints, required OrderLoadedState state}) {
    amountCompilationProcess(state: state, cupponDiscount: cuponDiscount, walletPoints: wallenPoints);
  }

  void changeDelivaryMode({required OrderLoadedState state, required OrderDiliveryMode mode}) {
    amountCompilationProcess(state: state, delivaryMode: mode);
  }

//! below mwthhod is used when there is need to add orders

  CustomerDetailModel addSelectedOrder({
    required OrderLoadedState state,
    required CustomerDetailModel customerDetailModel,
  }) {
    String dateTime = "";
    for (var value in state.selectedProducts) {
      dateTime =
          "${DateTime.now().day} ${DateFormat('MMM').format(DateTime(0, DateTime.now().month)).toString()} ${DateTime.now().year} | ${DateTime.now().hour}:${DateTime.now().minute}";
      OrderDetailModel order = OrderDetailModel(
        productName: value.name,
        quantity: value.selectedQuantity[0].quantity,
        quantityType: value.selectedQuantity[0].quantityType,
        orderDataTime: dateTime,
        price: double.parse("${value.selectedQuantity[0].price}"),
        ispanding: true,
      );
      customerDetailModel.orders.add(order);
    }
    return customerDetailModel;
  }

  OrderLoadedState? getState() {
    OrderLoadedState? loadedState;
    if (state is OrderLoadedState) {
      loadedState = state as OrderLoadedState;
    }
    return loadedState;
  }

  void update({required OrderLoadedState state}) {
    emit(state.copyWith(random: Random().nextDouble()));
  }
}
