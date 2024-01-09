import 'package:bakery_shop_flutter/features/offers/data/datasources/offer_data_sources.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class ApplyCouponsData extends UseCase<CouponApplyModel, ApplyCouponParms> {
  final OfferDataSources offerDataSources;

  ApplyCouponsData({required this.offerDataSources});

  @override
  Future<Either<AppError, CouponApplyModel>> call(ApplyCouponParms params) async {
    return await offerDataSources.applyCouponsData(params: params);
  }
}
