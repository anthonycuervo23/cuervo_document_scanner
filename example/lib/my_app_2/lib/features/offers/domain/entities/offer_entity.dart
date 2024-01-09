import 'package:bakery_shop_flutter/features/offers/data/models/offer_model.dart';
import 'package:equatable/equatable.dart';

class OfferDataEntity extends Equatable {
  final List<SingleCouponData> coupons;

  const OfferDataEntity({required this.coupons});

  @override
  List<Object?> get props => [coupons];
}
