import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRemoteRepository {
  Future<Either<AppError, PolicyEntity>> getPolicyData({required String slug});
}
