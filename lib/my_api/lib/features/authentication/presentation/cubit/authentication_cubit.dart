import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/params/login_params.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/usecases/get_login_data.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetLoginData getLoginData;
  final LoadingCubit loadingCubit;
  AuthenticationCubit({required this.getLoginData, required this.loadingCubit}) : super(AuthenticationInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    loadingCubit.show();
    final Either<AppError, LoginEntity> response = await getLoginData(
      GetLoginParams(email: email, password: password),
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
      (LoginEntity data) async {
        emit(AuthGenerateOtpLoadedState(loginEntity: data));
        if (data.token != '') {
          await userDataBox.put(HiveConstants.USER_TOKEN, data.token.toString());
          Future.delayed(const Duration(seconds: 2), () {
            loadingCubit.hide();
            CommonRouter.pushReplacementNamed(RouteList.app_home);
          });
        }
      },
    );
  }
}
