import 'package:bakery_shop_flutter/features/offers/data/datasources/offer_data_sources.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetCouponsData extends UseCase<OfferDataEntity, NoParams> {
  final OfferDataSources offerDataSources;

  GetCouponsData({required this.offerDataSources});

  @override
  Future<Either<AppError, OfferDataEntity>> call(NoParams params) async {
    return await offerDataSources.getCouponsData(params: params);
  }
}
