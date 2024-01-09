import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_profile_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/upload_file_params.dart';
import 'package:bakery_shop_flutter/features/shared/data/data_sources/user_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRemoteRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<AppError, AccountInfoEntity>> getAccountInfo() async {
    try {
      final result = await userDataSource.getAccountInfo();
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, UserEntity>> getUserDetails() async {
    try {
      final result = await userDataSource.getUserDetails();
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, UploadFileEntity>> uploadFile({required UploadFileParams params}) async {
    try {
      final result = await userDataSource.uploadFile(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateUserDetail({required UpdateUserDetailParams params}) async {
    try {
      final result = await userDataSource.updateUserDetail(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteFamilyDetail({required int id}) async {
    try {
      final result = await userDataSource.deleteFamilyDetail(id: id);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateLoginDetails({required UpdateLoginDetailsParams params}) async {
    try {
      final result = await userDataSource.updateLoginDetails(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateLoginDetailsVerifyOtp(
      {required UpdateLoginDetailsParams params}) async {
    try {
      final result = await userDataSource.updateLoginDetailsVerifyOtp(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
