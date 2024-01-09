import 'dart:math';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/get_user_details.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_data_load_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  final LoadingCubit loadingCubit;
  final GetUserData getUserData;

  GetUserDataCubit({
    required this.getUserData,
    required this.loadingCubit,
  }) : super(GerUserDataInitialState());

  Future<void> loadUserData({required bool loadShow}) async {
    if (loadShow) {
      loadingCubit.show();
    }
    Either<AppError, UserEntity> response = await getUserData(NoParams());
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(UserDataLoadErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (UserEntity data) {
        userEntity = data;
        loadingCubit.hide();

        GerUserDataLoadedState? userDataLoadLoadedState;
        if (state is GerUserDataLoadedState) {
          userDataLoadLoadedState = state as GerUserDataLoadedState;
          emit(userDataLoadLoadedState.copyWith(userDataEntity: data, random: Random().nextDouble()));
        } else {
          emit(GerUserDataLoadedState(userDataEntity: data, random: Random().nextDouble()));
        }
        if (data.name == '' &&
            data.address.flatNo == '' &&
            data.address.locality == '' &&
            data.anniversaryDate == '' &&
            data.dob == '') {
          CommonRouter.pushReplacementNamed(RouteList.edit_profile_screen, arguments: UserNewOld.newUser);
        }
      },
    );
  }
}
