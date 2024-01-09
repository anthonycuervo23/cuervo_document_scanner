import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/referral_code_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/verify_otp_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRemoteRepository {
  Future<Either<AppError, GenerateOtpEntity>> generateOtp({required GetLoginParams getLoginParams});
  Future<Either<AppError, VerifyOtpEntity>> verifyOtp({required GetVerifyOtpParams getVerifyOtpParams});
  Future<Either<AppError, bool>> getReferralCode({required GetReferralCodeParams getReferralCodeParams});
}
