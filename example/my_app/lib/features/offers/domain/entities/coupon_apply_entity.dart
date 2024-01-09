import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:equatable/equatable.dart';

class CouponApplyEntity extends Equatable {
  final CouponData coupon;

  const CouponApplyEntity({required this.coupon});
  @override
  List<Object?> get props => [];
}
