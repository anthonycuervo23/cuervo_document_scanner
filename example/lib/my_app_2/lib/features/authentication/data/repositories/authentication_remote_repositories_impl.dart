import 'package:bakery_shop_flutter/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/referral_code_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/verify_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/repositories/authentication_remote_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRemoteRepositoryImpl extends AuthenticationRemoteRepository {
  final AuuthenticationRemoteDataSource generateDataSource;

  AuthenticationRemoteRepositoryImpl({required this.generateDataSource});

  @override
  Future<Either<AppError, GenerateOtpEntity>> generateOtp({required GetLoginParams getLoginParams}) async {
    try {
      final result = await generateDataSource.generateOtp(getLoginParams: getLoginParams);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, VerifyOtpEntity>> verifyOtp({required GetVerifyOtpParams getVerifyOtpParams}) async {
    try {
      final result = await generateDataSource.verifyOtp(getVerifyOtpParams: getVerifyOtpParams);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, bool>> getReferralCode({required GetReferralCodeParams getReferralCodeParams}) async {
    try {
      final result = await generateDataSource.getReferralCode(getReferralCodeParams: getReferralCodeParams);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
