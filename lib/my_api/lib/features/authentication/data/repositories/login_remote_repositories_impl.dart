import 'package:bakery_shop_admin_flutter/features/authentication/data/datasources/login_remote_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/params/login_params.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/repositories/login_remote_repositories.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class LoginRemoteRepositoryImpl extends LoginRemoteRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRemoteRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<AppError, LoginEntity>> getlogin({required GetLoginParams getLoginParams}) async {
    try {
      final result = await loginRemoteDataSource.getlogin(getLoginParams: getLoginParams);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
