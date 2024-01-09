import 'package:bakery_shop_flutter/features/my_cart/data/models/my_cart_model.dart';
import 'package:equatable/equatable.dart';

class MyCartEntity extends Equatable {
  final List<CartProductData> cart;
  final List<PaymentMethodModel> paymentMethod;
  final List<DeliveryTypeModel> deliveryType;
  final Overview overview;

  const MyCartEntity({
    required this.cart,
    required this.deliveryType,
    required this.paymentMethod,
    required this.overview,
  });

  @override
  List<Object> get props => [cart, overview];
}
