// ignore_for_file: avoid_renaming_method_parameters

import 'package:bakery_shop_flutter/features/settings/data/data_sources/setting_data_sources.dart';
import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/setting_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class SettingRepositoryImpl extends SettingRemoteRepository {
  final SettingDataSource settingDataSource;

  SettingRepositoryImpl({required this.settingDataSource});

  @override
  Future<Either<AppError, PolicyEntity>> getPolicyData({required String slug}) async {
    try {
      final result = await settingDataSource.getPolicyData(slug: slug);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
