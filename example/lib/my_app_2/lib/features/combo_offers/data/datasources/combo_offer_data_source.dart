import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/combo_offers/data/models/combo_offer_model.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/params/combo_offer_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class ComboOfferRemoteDataSource {
  Future<Either<AppError, ComboProductEntity>> getProductCategory({required ComboOfferParams params});
}

class ComboOfferDataSourceImpl extends ComboOfferRemoteDataSource {
  final ApiClient client;

  ComboOfferDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, ComboProductEntity>> getProductCategory({required ComboOfferParams params}) async {
    var param = {"page": params.page};
    final result = await commonApiApiCall<ComboOfferModel>(
      apiPath: 'products/combo',
      apiCallType: APICallType.GET,
      params: param,
      screenName: 'Combo Offer Screen',
      client: client,
      fromJson: (json) {
        final comboOfferModel = ComboOfferModel.fromJson(json);
        return comboOfferModel;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data!));
  }
}
