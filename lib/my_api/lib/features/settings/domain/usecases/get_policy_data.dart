import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/repositories/setting_repostiory.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPolicyData extends UseCase<List<PolicyEntity>, String> {
  final SettingRemoteRepository settingRemoteRepository;

  GetPolicyData({required this.settingRemoteRepository});

  @override
  Future<Either<AppError, List<PolicyEntity>>> call(String params) async {
    return await settingRemoteRepository.getPolicyData(slug: params);
  }
}
