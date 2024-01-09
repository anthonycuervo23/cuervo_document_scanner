import 'package:bakery_shop_flutter/features/address/domain/model/address_detail_model.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

enum DeliveryDay { today, tomorrow, other }

enum DeliveryType { standard, midnight, fixtime }

enum CouponCode { apply, notApply }

enum RoutineOrder { cart, drawer }

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  // bool
  final bool routineOrdersForToggle;
  // model
  final MyCartEntity myCartData;
  final CouponData? appliedCouponData;
  final AddressDetailModel? addressDetailsModel;
  // enum
  final CouponCode couponCode;
  final RoutineOrder nevigateToDrawer;
  final DeliveryType deliveryType;
  final DeliveryDay deliveryTimeSlotDateType;
  // double
  final double deleveryCharge;
  final double totalPrice;
  final double discountPrice;
  final double? random;
  // String
  final String deliveryTimeDate;
  final String selectedTimeSlotTime;
  final String otherDateForTimeSlot;
  final String firstDateForRoutingOrder;
  final String lastDateForRoutingOrder;

  CartLoadedState({
    required this.routineOrdersForToggle,
    required this.firstDateForRoutingOrder,
    required this.lastDateForRoutingOrder,
    required this.myCartData,
    this.appliedCouponData,
    this.addressDetailsModel,
    required this.couponCode,
    required this.nevigateToDrawer,
    required this.deliveryType,
    required this.deliveryTimeSlotDateType,
    required this.deleveryCharge,
    required this.totalPrice,
    required this.discountPrice,
    this.random,
    required this.deliveryTimeDate,
    required this.selectedTimeSlotTime,
    required this.otherDateForTimeSlot,
  });

  CartLoadedState copyWith({
    bool? routineOrdersForToggle,
    String? firstDateForRoutingOrder,
    String? lastDateForRoutingOrder,
    MyCartEntity? myCartData,
    CouponData? appliedCouponData,
    AddressDetailModel? addressDetailsModel,
    CouponCode? couponCode,
    RoutineOrder? nevigateToDrawer,
    DeliveryType? deliveryType,
    DeliveryDay? deliveryTimeSlotDateType,
    double? deleveryCharge,
    double? totalPrice,
    double? discountPrice,
    double? random,
    String? deliveryTimeDate,
    String? selectedTimeSlotTime,
    String? otherDateForTimeSlot,
  }) {
    return CartLoadedState(
      routineOrdersForToggle: routineOrdersForToggle ?? this.routineOrdersForToggle,
      firstDateForRoutingOrder: firstDateForRoutingOrder ?? this.firstDateForRoutingOrder,
      lastDateForRoutingOrder: lastDateForRoutingOrder ?? this.lastDateForRoutingOrder,
      myCartData: myCartData ?? this.myCartData,
      appliedCouponData: appliedCouponData ?? this.appliedCouponData,
      addressDetailsModel: addressDetailsModel ?? this.addressDetailsModel,
      couponCode: couponCode ?? this.couponCode,
      nevigateToDrawer: nevigateToDrawer ?? this.nevigateToDrawer,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryTimeSlotDateType: deliveryTimeSlotDateType ?? this.deliveryTimeSlotDateType,
      deleveryCharge: deleveryCharge ?? this.deleveryCharge,
      totalPrice: totalPrice ?? this.totalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      random: random ?? this.random,
      deliveryTimeDate: deliveryTimeDate ?? this.deliveryTimeDate,
      selectedTimeSlotTime: selectedTimeSlotTime ?? this.selectedTimeSlotTime,
      otherDateForTimeSlot: otherDateForTimeSlot ?? this.otherDateForTimeSlot,
    );
  }

  @override
  List<Object?> get props => [
        myCartData,
        deliveryTimeSlotDateType,
        deliveryType,
        selectedTimeSlotTime,
        routineOrdersForToggle,
        firstDateForRoutingOrder,
        lastDateForRoutingOrder,
        nevigateToDrawer,
        addressDetailsModel,
        random,
        couponCode,
        appliedCouponData,
        deleveryCharge,
        totalPrice,
        deliveryTimeDate,
        discountPrice,
      ];
}

class CartErrorState extends CartState {
  final AppErrorType appErrorType;
  final String errorMessage;
  CartErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
