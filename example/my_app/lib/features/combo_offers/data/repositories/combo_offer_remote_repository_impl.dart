import 'package:bakery_shop_flutter/features/combo_offers/data/datasources/combo_offer_data_source.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/params/combo_offer_params.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/repositories/product_remote_repository.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class ComboOfferRemoteRepositoriesImpl extends ComboOfferRemoteRepository {
  final ComboOfferRemoteDataSource comboOfferRemoteDataSource;

  ComboOfferRemoteRepositoriesImpl({required this.comboOfferRemoteDataSource});

  @override
  Future<Either<AppError, ComboProductEntity>> getProductCategory({required ComboOfferParams params}) async {
    try {
      final result = await comboOfferRemoteDataSource.getProductCategory(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
