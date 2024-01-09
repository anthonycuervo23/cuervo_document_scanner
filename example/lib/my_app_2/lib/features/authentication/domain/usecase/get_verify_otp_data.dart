import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/verify_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/repositories/authentication_remote_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetVerifyOtpData extends UseCase<VerifyOtpEntity, GetVerifyOtpParams> {
  final AuthenticationRemoteRepository authenticationRemoteRepository;

  GetVerifyOtpData({required this.authenticationRemoteRepository});

  @override
  Future<Either<AppError, VerifyOtpEntity>> call(GetVerifyOtpParams params) async {
    return await authenticationRemoteRepository.verifyOtp(getVerifyOtpParams: params);
  }
}
