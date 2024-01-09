import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

abstract class OfferRemotRepositories {
  Future<Either<AppError, OfferDataEntity>> getCouponsData({required NoParams params});
  Future<Either<AppError, CouponApplyModel>> applyCouponsData({required ApplyCouponParms params});
}
