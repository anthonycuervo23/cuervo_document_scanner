import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';

class GenerateOtpArgument extends ModelResponseExtend {
  final String mobileNumber;
  final UserNewOld useOldNew;
  final GenerateOtpEntity? generateOtpEntity;
  final UpdateLoginDetailsParams? updateLoginDetailsParams;

  GenerateOtpArgument({
    required this.mobileNumber,
    this.generateOtpEntity,
    this.updateLoginDetailsParams,
    required this.useOldNew,
  });
}
