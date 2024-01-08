import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/params/login_params.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/repositories/login_remote_repositories.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetLoginData extends UseCase<LoginEntity, GetLoginParams> {
  final LoginRemoteRepository authenticationRemoteRepository;

  GetLoginData({required this.authenticationRemoteRepository});

  @override
  Future<Either<AppError, LoginEntity>> call(GetLoginParams params) async {
    return await authenticationRemoteRepository.getlogin(getLoginParams: params);
  }
}
