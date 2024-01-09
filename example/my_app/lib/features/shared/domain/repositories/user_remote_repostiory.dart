import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_profile_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/upload_file_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
//
abstract class UserRemoteRepository {
  Future<Either<AppError, AccountInfoEntity>> getAccountInfo();
  Future<Either<AppError, UserEntity>> getUserDetails();
  Future<Either<AppError, UploadFileEntity>> uploadFile({required UploadFileParams params});
  Future<Either<AppError, PostApiResponse>> updateUserDetail({required UpdateUserDetailParams params});
  Future<Either<AppError, PostApiResponse>> deleteFamilyDetail({required int id});
  Future<Either<AppError, PostApiResponse>> updateLoginDetails({required UpdateLoginDetailsParams params});
  Future<Either<AppError, PostApiResponse>> updateLoginDetailsVerifyOtp({required UpdateLoginDetailsParams params});
}
