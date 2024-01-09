import 'package:bakery_shop_flutter/features/combo_offers/data/datasources/combo_offer_data_source.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/params/combo_offer_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetComboOfferData extends UseCase<ComboProductEntity, ComboOfferParams> {
  final ComboOfferRemoteDataSource comboOfferDataSource;

  GetComboOfferData({required this.comboOfferDataSource});

  @override
  Future<Either<AppError, ComboProductEntity>> call(ComboOfferParams params) async {
    return await comboOfferDataSource.getProductCategory(params: params);
  }
}
