import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/repositories/authentication_remote_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetGenerateOtpData extends UseCase<GenerateOtpEntity, GetLoginParams> {
  final AuthenticationRemoteRepository authenticationRemoteRepository;

  GetGenerateOtpData({required this.authenticationRemoteRepository});

  @override
  Future<Either<AppError, GenerateOtpEntity>> call(GetLoginParams params) async {
    return await authenticationRemoteRepository.generateOtp(getLoginParams: params);
  }
}
