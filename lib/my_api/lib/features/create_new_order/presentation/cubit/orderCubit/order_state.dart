import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoadedState extends OrderState {
  final List<ProductModel> selectedProducts;
  final List<CupponModel> availableCupons;
  final CupponModel selectedCupon;
  final bool isMenuOpen;
  final double random;
  final double itemTotal;
  final double gstCharge;
  final double delivaryCharge;
  final double discount;
  final double coupenDiscount;
  final double walletPoints;
  final double balanceAmount;
  final double total;
  final double colloectedAmount;
  final OrderDiliveryMode delivaryMode;

  const OrderLoadedState({
    required this.selectedProducts,
    required this.availableCupons,
    required this.selectedCupon,
    required this.isMenuOpen,
    required this.random,
    required this.itemTotal,
    required this.coupenDiscount,
    required this.discount,
    required this.walletPoints,
    required this.balanceAmount,
    required this.gstCharge,
    required this.colloectedAmount,
    required this.total,
    required this.delivaryCharge,
    required this.delivaryMode,
  });

  OrderLoadedState copyWith({
    List<ProductModel>? selectedProducts,
    List<CupponModel>? availableCupons,
    CupponModel? selectedCupon,
    bool? isMenuOpen,
    double? random,
    double? itemTotal,
    double? gstCharge,
    double? discount,
    double? coupenDiscount,
    double? walletPoints,
    double? total,
    double? colloectedAmount,
    double? balanceAmount,
    double? delivaryCharge,
    OrderDiliveryMode? delivaryMode,
  }) {
    return OrderLoadedState(
      selectedProducts: selectedProducts ?? this.selectedProducts,
      delivaryCharge: delivaryCharge ?? this.delivaryCharge,
      availableCupons: availableCupons ?? this.availableCupons,
      selectedCupon: selectedCupon ?? this.selectedCupon,
      isMenuOpen: isMenuOpen ?? this.isMenuOpen,
      coupenDiscount: coupenDiscount ?? this.coupenDiscount,
      discount: discount ?? this.discount,
      gstCharge: gstCharge ?? this.gstCharge,
      walletPoints: walletPoints ?? this.walletPoints,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      itemTotal: itemTotal ?? this.itemTotal,
      colloectedAmount: colloectedAmount ?? this.colloectedAmount,
      total: total ?? this.total,
      random: random ?? this.random,
      delivaryMode: delivaryMode ?? this.delivaryMode,
    );
  }

  @override
  List<Object> get props => [
        selectedProducts,
        availableCupons,
        selectedCupon,
        random,
        itemTotal,
        isMenuOpen,
        gstCharge,
        discount,
        coupenDiscount,
        walletPoints,
        balanceAmount,
        colloectedAmount,
        total,
        delivaryCharge,
        delivaryMode,
      ];
}

class OrderErrorState extends OrderState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const OrderErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
