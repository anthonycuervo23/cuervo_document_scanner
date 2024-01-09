// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/core/api_constants.dart';
import 'package:bakery_shop_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/upload_file_model.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_profile_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/upload_file_params.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/account_info_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;

abstract class UserDataSource {
  Future<Either<AppError, AccountInfoEntity>> getAccountInfo();
  Future<Either<AppError, UserEntity>> getUserDetails();
  Future<Either<AppError, UploadFileEntity>> uploadFile({required UploadFileParams param});
  Future<Either<AppError, PostApiResponse>> updateUserDetail({required UpdateUserDetailParams param});
  Future<Either<AppError, PostApiResponse>> deleteFamilyDetail({required int id});
  Future<Either<AppError, PostApiResponse>> updateLoginDetails({required UpdateLoginDetailsParams param});
  Future<Either<AppError, PostApiResponse>> updateLoginDetailsVerifyOtp({required UpdateLoginDetailsParams param});
}

class UserDataSourceImpl extends UserDataSource {
  final ApiClient client;

  UserDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, AccountInfoEntity>> getAccountInfo() async {
    final result = await commonApiApiCall<AccountInfoModel>(
      apiPath: 'account',
      apiCallType: APICallType.GET,
      screenName: 'Common Api',
      client: client,
      fromJson: (json) {
        final policyModel = AccountInfoModel.fromJson(json);
        return policyModel;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data!));
  }

  @override
  Future<Either<AppError, UserEntity>> getUserDetails() async {
    try {
      final result = await commonApiApiCall<UserModel>(
        apiPath: 'profile',
        apiCallType: APICallType.GET,
        screenName: 'Get Profile',
        client: client,
        fromJson: (json) {
          final userModel = UserModel.fromJson(json);
          return userModel;
        },
      );

      return result.fold(
        (appError) {
          return Left(appError);
        },
        (list) {
          return Right(list.data!);
        },
      );
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, UploadFileEntity>> uploadFile({required UploadFileParams param}) async {
    try {
      Map<String, dynamic> params = {
        "type": param.type,
        "old_path": param.oldPath,
      };
      List<MapEntry<String, dio.MultipartFile>> multipleImages = [];
      multipleImages.add(
        MapEntry(
          "file",
          await dio.MultipartFile.fromFile(param.file, contentType: MediaType("image", "*/*")),
        ),
      );
      final result = await commonApiApiCall<UploadFileModel>(
        apiPath: 'upload',
        apiCallType: APICallType.POSTFILES,
        screenName: 'Edit Profile',
        header: ApiConstatnts().headers,
        params: params,
        multipleImages: multipleImages,
        client: client,
        fromJson: (json) {
          final uploadFileModel = UploadFileModel.fromJson(json);
          return uploadFileModel;
        },
      );

      return result.fold(
        (appError) {
          return Left(appError);
        },
        (list) {
          return Right(list.data!);
        },
      );
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteFamilyDetail({required int id}) async {
    final result = await commonApiApiCall<PostApiResponse>(
      apiPath: 'profile/family/$id',
      screenName: 'Edit Profile',
      header: ApiConstatnts().headers,
      apiCallType: APICallType.DELETE,
      client: client,
      fromJson: (json) {
        final familydetails = PostApiResponse.fromJson(json);
        return familydetails;
      },
    );

    return result.fold(
      (appError) {
        return Left(appError);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateUserDetail({required UpdateUserDetailParams param}) async {
    Map<String, dynamic> params = {
      "name": param.name.toString(),
      "country_code": param.countryCode.toString(),
      "date_of_birth": param.dob.toString(),
      "anniversary_date": param.anniversaryDate.toString(),
      "profile_image": param.profilePhoto.toString(),
      "address": param.address.toJson(),
      "family_info": param.familtyInfo.map((x) => x.toJson()).toList(),
    };
    log(params.toString());
    try {
      final result = await commonApiApiCall<PostApiResponse>(
        apiPath: 'profile',
        params: params,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Update Profile',
        fromJson: (json) {
          final userModel = PostApiResponse.fromJson(json);
          return userModel;
        },
      );
      return result.fold(
        (appError) {
          return Left(appError);
        },
        (data) {
          return Right(data);
        },
      );
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateLoginDetails({
    required UpdateLoginDetailsParams param,
  }) async {
    try {
      Map<String, String?> params;
      if (param.loginType == LogintType.phone) {
        params = {
          'type': 'mobile',
          'mobile': param.mobileNumber.replaceAll(' ', '').trim(),
          'country_code': param.countryCode,
        };
      } else {
        params = {
          'type': 'email',
          'email': param.email.toLowerCase(),
        };
      }

      final result = await commonApiApiCall<PostApiResponse>(
        apiPath: 'profile/generate-otp',
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        params: params,
        screenName: 'Update Email And Phone',
        client: client,
        fromJson: (json) {
          final otpModel = PostApiResponse.fromJson(json);
          return otpModel;
        },
      );

      return result.fold((appError) => Left(appError), (list) => Right(list));
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateLoginDetailsVerifyOtp({
    required UpdateLoginDetailsParams param,
  }) async {
    try {
      var params = (param.loginType == LogintType.email)
          ? {
              "otp": param.otp,
              "type": "email",
              "email": param.email,
            }
          : {
              "otp": param.otp,
              "type": "mobile",
              "country_code": "+91",
              "mobile": param.mobileNumber.replaceAll(' ', '').trim(),
            };

      final result = await commonApiApiCall<PostApiResponse>(
        apiPath: 'profile/verify-otp',
        params: params,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Otp Screen',
        fromJson: (json) {
          final verifyOtpModel = PostApiResponse.fromJson(json);
          return verifyOtpModel;
        },
      );

      return result.fold((appError) {
        return Left(appError);
      }, (list) {
        return Right(list);
      });
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }
}
