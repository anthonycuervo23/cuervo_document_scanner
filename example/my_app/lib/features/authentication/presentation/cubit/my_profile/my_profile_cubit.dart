import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/get_user_details.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final GetUserData getUserData;
  final LoadingCubit loadingCubit;

  MyProfileCubit({required this.loadingCubit, required this.getUserData}) : super(const MyProfileInitialState());

  Future<void> loadUserData() async {
    loadingCubit.show();
    Either<AppError, UserEntity> response = await getUserData(NoParams());
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(MyProfileErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (UserEntity data) {
        userEntity = data;
        emit(MyProfileLoadedState(userDataEntity: data));
        loadingCubit.hide();
      },
    );
  }

  void dataSave({required UserEntity userDataEntity}) {
    emit(MyProfileLoadedState(userDataEntity: userDataEntity));
  }
}
