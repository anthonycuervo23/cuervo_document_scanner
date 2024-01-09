// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/referral_code_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_referral_code_data.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ReferralRedeemCubit extends Cubit<bool> {
  final LoadingCubit loadingCubit;
  final GetReferralCodeData getReferralCodeData;
  TextEditingController referCodeController = TextEditingController();

  bool isMounted = true;

  ReferralRedeemCubit({
    required this.loadingCubit,
    required this.getReferralCodeData,
  }) : super(false);

  Future<void> referralCodeData({required UserNewOld userNewOld, required BuildContext context}) async {
    loadingCubit.show();
    final Either<AppError, bool> response = await getReferralCodeData(
      GetReferralCodeParams(referrCode: referCodeController.text),
    );
    response.fold(
      (error) async {
        loadingCubit.hide();

        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (bool data) {
        if (!isMounted) return;
        if (data == true) {
          loadingCubit.hide();
          CustomSnackbar.show(
            snackbarType: SnackbarType.SUCCESS,
            message: TranslationConstants.refer_code_applied_successfully.translate(context),
          );
          CommonRouter.pushReplacementNamed(RouteList.edit_profile_screen, arguments: UserNewOld.newUser);
        } else {
          loadingCubit.hide();
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: TranslationConstants.error.translate(context));
        }
      },
    );
  }
}
