// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/verify_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_generate_otp_data.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_verify_otp_data.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/update_login_otp.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final LoadingCubit loadingCubit;
  final GetGenerateOtpData getGenerateOtp;
  final UpdateLoginOtp updateLoginOtp;
  final GetUserDataCubit userDataLoadCubit;
  final GetVerifyOtpData getVerifyOtpData;
  bool isMounted = true;

  TextEditingController otpController = TextEditingController();

  int secondsRemaining = 60;
  late Timer timer;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  OtpVerificationCubit({
    required this.loadingCubit,
    required this.getVerifyOtpData,
    required this.getGenerateOtp,
    required this.updateLoginOtp,
    required this.userDataLoadCubit,
  }) : super(OtpLoadTimerState(enableResend: false, secondsRemaining: 60));

  void loadTimer({required bool enableResend, required int seconds}) {
    if (!isMounted) return;
    emit(OtpLoadTimerState(enableResend: enableResend, secondsRemaining: seconds));
  }

  Future<void> resendCode({required String mobilenumber, required UserNewOld userNewOld}) async {
    loadingCubit.show();
    final Either<AppError, GenerateOtpEntity> response = await getGenerateOtp(
      GetLoginParams(
        mobilenumber: mobilenumber,
        countryCode: "+91",
        type: 'mobile',
      ),
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
      (GenerateOtpEntity data) {
        secondsRemaining = 60;
        loadingCubit.hide();
        if (data.otp != '') {
          CommonRouter.pushNamed(
            RouteList.otp_verification_screen,
            arguments: GenerateOtpArgument(mobileNumber: mobilenumber, generateOtpEntity: data, useOldNew: userNewOld),
          );

          if (!isMounted) return;
          emit(OtpLoadTimerState(enableResend: false, secondsRemaining: 60));
        }
      },
    );
  }

  Future<void> verifyOtpData({
    required String phoneNumber,
    required bool isNewUser,
    required BuildContext context,
  }) async {
    loadingCubit.show();

    Either<AppError, VerifyOtpEntity> response = await getVerifyOtpData(
      GetVerifyOtpParams(mobilenumber: phoneNumber, otp: otpController.text),
    );

    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (VerifyOtpEntity data) async {
        if (data.token != '') {
          await userDataBox.put(HiveConstants.USER_TOKEN, data.token.toString());
          loadingCubit.hide();
          if (isNewUser) {
            CommonRouter.pushReplacementNamed(RouteList.referral_screen);
          } else {
            CommonRouter.pushNamedAndRemoveUntil(RouteList.app_home);
            BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
          }
        }
      },
    );
    loadingCubit.hide();
  }

  Future<void> updateVerifyOtpData({
    required BuildContext context,
    required UpdateLoginDetailsParams updateLoginDetailsParams,
  }) async {
    loadingCubit.show();

    Either<AppError, PostApiResponse> response = await updateLoginOtp(UpdateLoginDetailsParams(
      loginType: updateLoginDetailsParams.loginType,
      countryCode: updateLoginDetailsParams.countryCode,
      mobileNumber: updateLoginDetailsParams.mobileNumber,
      email: updateLoginDetailsParams.email,
      otp: otpController.text,
    ));

    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (PostApiResponse data) async {
        userDataLoadCubit.loadUserData(loadShow: true);
        CommonRouter.popUntil(RouteList.app_home);
        BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
      },
    );
    loadingCubit.hide();
  }
}
