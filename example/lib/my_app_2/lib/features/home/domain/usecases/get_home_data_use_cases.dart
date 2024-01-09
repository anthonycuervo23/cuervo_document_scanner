import 'package:bakery_shop_flutter/features/home/data/datasources/home_data_sources.dart';
import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetHomeDatauseCases extends UseCase<HomeEntity, NoParams> {
  final HomeDataSources homeDataSources;

  GetHomeDatauseCases({required this.homeDataSources});

  @override
  Future<Either<AppError, HomeEntity>> call(NoParams params) {
    return homeDataSources.getHomeData();
  }
}
