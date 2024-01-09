import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRemoteRepository {
  Future<Either<AppError, List<PolicyEntity>>> getPolicyData({required String slug});
}
