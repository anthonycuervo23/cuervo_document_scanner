import 'dart:io';

import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/core/api_constants.dart';
import 'package:bakery_shop_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_flutter/features/authentication/data/models/generate_otp_model.dart';
import 'package:bakery_shop_flutter/features/authentication/data/models/referral_code_model.dart';
import 'package:bakery_shop_flutter/features/authentication/data/models/verify_otp_model.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/referral_code_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/verify_otp_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class AuuthenticationRemoteDataSource {
  Future<Either<AppError, GenerateOtpEntity>> generateOtp({required GetLoginParams getLoginParams});
  Future<Either<AppError, VerifyOtpEntity>> verifyOtp({required GetVerifyOtpParams getVerifyOtpParams});
  Future<Either<AppError, bool>> getReferralCode({required GetReferralCodeParams getReferralCodeParams});
}

class GenerateDataSourceImpl extends AuuthenticationRemoteDataSource {
  final ApiClient client;

  GenerateDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, GenerateOtpEntity>> generateOtp({required GetLoginParams getLoginParams}) async {
    String endPoint = '';
    try {
      Map<String, String?> params;
      if (getLoginParams.type == 'mobile') {
        endPoint = 'login/generate-otp';
        params = {
          'mobile': getLoginParams.mobilenumber?.replaceAll(' ', ''),
          'country_code': getLoginParams.countryCode,
        };
      } else {
        endPoint = 'login/google';
        params = {
          'google_id': getLoginParams.googleId,
          'email': getLoginParams.email?.toLowerCase(),
        };
      }

      final result = await commonApiApiCall<GenerateOtpModel>(
        apiPath: endPoint,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        params: params,
        screenName: 'Login Screen',
        client: client,
        fromJson: (json) {
          final otpModel = GenerateOtpModel.fromJson(json);
          return otpModel;
        },
      );

      return result.fold((appError) => Left(appError), (list) => Right(list.data!));
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, VerifyOtpEntity>> verifyOtp({required GetVerifyOtpParams getVerifyOtpParams}) async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    try {
      var params = Platform.isIOS
          ? {
              'mobile': getVerifyOtpParams.mobilenumber.replaceAll(' ', ''),
              'otp': getVerifyOtpParams.otp,
              // "device_model": iosInfo.model,
              // "device_id": iosInfo.identifierForVendor,
              // "device_type": iosInfo.systemName,
              // "device_unique_id": iosInfo.identifierForVendor,
              // "app_version_code": "",
              // "app_version_name": "",
              // "geo_country": "",
              // "geo_state": "",
              // "geo_city": "",
              // "geo_pincode": "",
              // "device_info": []
            }
          : {
              'mobile': getVerifyOtpParams.mobilenumber.replaceAll(' ', ''),
              'otp': getVerifyOtpParams.otp,
              // "device_model": androidInfo.model,
              // "device_id": androidInfo.id,
              // "device_type": androidInfo.type,
              // "device_unique_id": "",
              // "app_version_code": "",
              // "app_version_name": "",
              // "geo_country": "",
              // "geo_state": "",
              // "geo_city": "",
              // "geo_pincode": "",
              // "device_info": []
            };

      final result = await commonApiApiCall<VerifyOtpModel>(
        apiPath: 'login/verify-otp',
        params: params,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Otp Screen',
        fromJson: (json) {
          final verifyOtpModel = VerifyOtpModel.fromJson(json);
          return verifyOtpModel;
        },
      );

      return result.fold((appError) {
        return Left(appError);
      }, (list) {
        return Right(list.data!);
      });
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, bool>> getReferralCode({required GetReferralCodeParams getReferralCodeParams}) async {
    try {
      var params = {'refer_code': getReferralCodeParams.referrCode};

      final result = await commonApiApiCall<ReferralCodeModel>(
        apiPath: 'profile/update-refer',
        apiCallType: APICallType.POST,
        params: params,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'ReferralCode Screen',
        fromJson: (json) {
          final referralCodeModel = ReferralCodeModel.fromJson(json);
          return referralCodeModel;
        },
      );

      return result.fold((appError) {
        return Left(appError);
      }, (list) {
        return const Right(true);
      });
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }
}
