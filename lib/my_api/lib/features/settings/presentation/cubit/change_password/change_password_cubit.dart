import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

enum TextFieldType { curruntPassword, newPassword, confirmPassword }

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final LoadingCubit loadingCubit;

  ChangePasswordCubit({required this.loadingCubit}) : super(ChangePasswordLoadedState());

  void changeVisibilities({
    required ChangePasswordLoadedState state,
    required TextFieldType textFieldTypes,
  }) {
    if (textFieldTypes == TextFieldType.curruntPassword) {
      state.isVisibleCurruntPassword = !(state.isVisibleCurruntPassword ?? true);
    } else if (textFieldTypes == TextFieldType.newPassword) {
      state.isVisibleNewPassword = !(state.isVisibleNewPassword ?? true);
    } else if (textFieldTypes == TextFieldType.confirmPassword) {
      state.isVisibleConfirmPassword = !(state.isVisibleConfirmPassword ?? true);
    }

    emit(
      state.copyWith(
        isVisibleConfirmPassword: state.isVisibleConfirmPassword,
        isVisibleCurruntPassword: state.isVisibleCurruntPassword,
        isVisibleNewPassword: state.isVisibleNewPassword,
        random: Random().nextDouble(),
      ),
    );
  }
}
