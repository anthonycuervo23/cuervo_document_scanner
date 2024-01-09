import 'package:bakery_shop_flutter/features/offers/data/datasources/offer_data_sources.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/offers/domain/repositories/offer_remot_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

class OfferRemotRepositoriesImpl extends OfferRemotRepositories {
  final OfferDataSources offerDataSources;

  OfferRemotRepositoriesImpl({required this.offerDataSources});

  @override
  Future<Either<AppError, OfferDataEntity>> getCouponsData({required NoParams params}) async {
    try {
      final result = await offerDataSources.getCouponsData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, CouponApplyModel>> applyCouponsData({required ApplyCouponParms params}) async {
    try {
      final result = await offerDataSources.applyCouponsData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
