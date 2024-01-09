import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/setting_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPolicyData extends UseCase<PolicyEntity, String> {
  final SettingRemoteRepository settingRemoteRepository;

  GetPolicyData({required this.settingRemoteRepository});

  @override
  Future<Either<AppError, PolicyEntity>> call(String params) async {
    return await settingRemoteRepository.getPolicyData(slug: params);
  }
}
