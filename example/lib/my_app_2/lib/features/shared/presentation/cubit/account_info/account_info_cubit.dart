// ignore_for_file: prefer_const_constructors

import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/get_policy_data.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final GetAccountInfoData getAccountInfoData;
  final LoadingCubit loadingCubit;

  AccountInfoCubit({
    required this.loadingCubit,
    required this.getAccountInfoData,
  }) : super(AccountInfoInitialState());

  Future<void> loadInitialData() async {
    emit(AccountInfoLoadingState());
    final Either<AppError, AccountInfoEntity> response = await getAccountInfoData(NoParams());
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(AccountInfoErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (AccountInfoEntity data) {
        accountInfoEntity = data;
        appConstants.buttonRadius = data.appSetting.buttonRadius;
        appConstants.prductCardRadius = data.appSetting.productCardRadius;
        emit(AccountInfoLoadedState(accountInfoEntity: data));
      },
    );
  }
}
