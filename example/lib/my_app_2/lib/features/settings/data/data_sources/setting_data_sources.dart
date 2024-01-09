import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/settings/data/models/policy_model.dart';
import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class SettingDataSource {
  Future<Either<AppError, PolicyEntity>> getPolicyData({required String slug});
}

class SettingDataSourceImpl extends SettingDataSource {
  final ApiClient client;

  SettingDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, PolicyEntity>> getPolicyData({required String slug}) async {
    final result = await commonApiApiCall<PolicyModel>(
      apiPath: 'page/$slug',
      apiCallType: APICallType.GET,
      client: client,
      screenName: 'Policy Screen',
      fromJson: (json) {
        final policyModel = PolicyModel.fromJson(json);
        return policyModel;
      },
    );

    return result.fold((appError) => Left(appError), (data) => Right(data.data!));
  }
}
