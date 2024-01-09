import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/params/login_params.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRemoteRepository {
  Future<Either<AppError, LoginEntity>> getlogin({required GetLoginParams getLoginParams});
}
