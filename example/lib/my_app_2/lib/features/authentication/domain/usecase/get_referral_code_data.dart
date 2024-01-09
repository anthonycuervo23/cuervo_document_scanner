import 'package:bakery_shop_flutter/features/authentication/domain/params/referral_code_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/repositories/authentication_remote_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetReferralCodeData extends UseCase<bool, GetReferralCodeParams> {
  final AuthenticationRemoteRepository authenticationRemoteRepository;

  GetReferralCodeData({required this.authenticationRemoteRepository});

  @override
  Future<Either<AppError, bool>> call(GetReferralCodeParams params) async {
    return await authenticationRemoteRepository.getReferralCode(getReferralCodeParams: params);
  }
}
