import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class HomeDataRemortRepositories {
  Future<Either<AppError, HomeEntity>> getHomeData();
}
