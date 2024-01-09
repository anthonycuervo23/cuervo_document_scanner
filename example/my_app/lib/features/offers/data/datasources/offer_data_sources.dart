import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/offer_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class OfferDataSources {
  Future<Either<AppError, OfferDataEntity>> getCouponsData({required NoParams params});
  Future<Either<AppError, CouponApplyModel>> applyCouponsData({required ApplyCouponParms params});
}

class OfferDataSourcesImpl extends OfferDataSources {
  final ApiClient client;

  OfferDataSourcesImpl({required this.client});

  @override
  Future<Either<AppError, OfferDataEntity>> getCouponsData({required NoParams params}) async {
    final result = await commonApiApiCall<OfferModel>(
      apiPath: 'coupons',
      apiCallType: APICallType.GET,
      screenName: 'Offer Screen',
      client: client,
      fromJson: (json) {
        final data = OfferModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data!));
  }

  @override
  Future<Either<AppError, CouponApplyModel>> applyCouponsData({required ApplyCouponParms params}) async {
    final result = await commonApiApiCall<CouponApplyModel>(
      apiPath: 'coupons/apply',
      apiCallType: APICallType.POST,
      screenName: 'Offer Apply Screen',
      client: client,
      params: {'coupon': params.couponCode},
      fromJson: (json) {
        final data = CouponApplyModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list));
  }
}
