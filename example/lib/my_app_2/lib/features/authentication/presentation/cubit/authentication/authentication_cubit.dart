// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/params/generate_otp_params.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_generate_otp_data.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_state.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum UserNewOld { newUser, oldUser }

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetGenerateOtpData getGenerateOtp;
  final LoadingCubit loadingCubit;

  AuthenticationCubit({
    required this.getGenerateOtp,
    required this.loadingCubit,
  }) : super(AuthenticationInitialState());

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  GoogleSignInAccount? account;

  Future<void> generateOtpMobile({required String mobilenumber, required UserNewOld userNewOld}) async {
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
        emit(AuthenticationErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (GenerateOtpEntity data) {
        loadingCubit.hide();
        if (data.otp != '') {
          CommonRouter.pushNamed(
            RouteList.otp_verification_screen,
            arguments: GenerateOtpArgument(mobileNumber: mobilenumber, generateOtpEntity: data, useOldNew: userNewOld),
          );
        }
      },
    );
  }

  Future<void> loginWithEmail({
    required String email,
    required String googleId,
    required BuildContext context,
    required UserNewOld userNewOld,
  }) async {
    loadingCubit.show();
    final Either<AppError, GenerateOtpEntity> response = await getGenerateOtp(
      GetLoginParams(
        type: 'email',
        email: email,
        googleId: googleId,
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
        emit(AuthenticationErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (GenerateOtpEntity data) async {
        loadingCubit.hide();
        emit(AuthenticationLoadedState(generateOtpEntity: data));
        if (data.token != '') {
          await userDataBox.put(HiveConstants.USER_TOKEN, data.token.toString());
          if (data.isUserNew) {
            CommonRouter.pushReplacementNamed(RouteList.referral_screen);
          } else {
            CommonRouter.pushReplacementNamed(RouteList.app_home);
            BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
          }
        } else {
          if (data.otp != '') {
            CommonRouter.pushNamed(
              RouteList.otp_verification_screen,
              arguments: GenerateOtpArgument(mobileNumber: '', generateOtpEntity: data, useOldNew: userNewOld),
            );
          }
        }
      },
    );
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    CommonRouter.pushNamed(RouteList.login_screen);
  }
}
