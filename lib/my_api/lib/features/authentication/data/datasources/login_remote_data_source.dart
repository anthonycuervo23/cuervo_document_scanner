import 'package:bakery_shop_admin_flutter/core/api_client.dart';
import 'package:bakery_shop_admin_flutter/core/api_constants.dart';
import 'package:bakery_shop_admin_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/data/models/login_model.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/params/login_params.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRemoteDataSource {
  Future<Either<AppError, LoginEntity>> getlogin({required GetLoginParams getLoginParams});
}

class LoginDataSourceImpl extends LoginRemoteDataSource {
  final ApiClient client;

  LoginDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, LoginEntity>> getlogin({required GetLoginParams getLoginParams}) async {
    String endPoint = '';
    try {
      Map<String, String?> params;

      endPoint = 'login';
      params = {
        'email': getLoginParams.email,
        'password':getLoginParams.password,
      };

      final result = await commonApiApiCall<LoginModel>(
        apiPath: endPoint,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        params: params,
        screenName: 'Login Screen',
        client: client,
        fromJson: (json) {
          final loginModel = LoginModel.fromJson(json);
          return loginModel;
        },
      );

      return result.fold((appError) => Left(appError), (list) => Right(list.data));
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }
}
