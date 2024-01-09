import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/params/combo_offer_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart'; 
import 'package:dartz/dartz.dart';

abstract class ComboOfferRemoteRepository {
  Future<Either<AppError, ComboProductEntity>> getProductCategory({required ComboOfferParams params});
}
