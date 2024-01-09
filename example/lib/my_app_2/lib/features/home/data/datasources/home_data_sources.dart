import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/home/data/models/home_model.dart';
import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class HomeDataSources {
  Future<Either<AppError, HomeEntity>> getHomeData();
}

class HomeDataSourcesImpl extends HomeDataSources {
  final ApiClient client;

  HomeDataSourcesImpl({required this.client});

  @override
  Future<Either<AppError, HomeEntity>> getHomeData() async {
    final result = await commonApiApiCall<HomeModel>(
      apiPath: 'home',
      apiCallType: APICallType.GET,
      screenName: 'Home Screen',
      client: client,
      fromJson: (json) {
        final comboOfferModel = HomeModel.fromJson(json);
        return comboOfferModel;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data!));
  }
}
