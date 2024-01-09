import 'package:bakery_shop_flutter/features/home/data/datasources/home_data_sources.dart';
import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/home/domain/repositorie/home_data_remort_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class HomeDataRemortRepositoriesImpl extends HomeDataRemortRepositories {
  final HomeDataSources homeDataSources;

  HomeDataRemortRepositoriesImpl({required this.homeDataSources});

  @override
  Future<Either<AppError, HomeEntity>> getHomeData() {
    return homeDataSources.getHomeData();
  }
}
