// ignore_for_file: prefer_const_constructors

import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/get_policy_data.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'policy_state.dart';

enum TypeOfPolicy { privacyPolicy, termsAndConditions }

class PolicyCubit extends Cubit<PolicyState> {
  final GetPolicyData getPolicyData;
  final LoadingCubit loadingCubit;

  PolicyCubit({
    required this.loadingCubit,
    required this.getPolicyData,
  }) : super(PolicyInitialState());

  Future<void> loadInitialData({required TypeOfPolicy typeOfPolicy}) async {
    String slug;
    if (typeOfPolicy == TypeOfPolicy.privacyPolicy) {
      slug = "privacy-policy";
    } else {
      slug = "terms-condition";
    }
    loadingCubit.show();
    final Either<AppError, PolicyEntity> response = await getPolicyData(slug);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(PolicyErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (data) {
        loadingCubit.hide();
        emit(PolicyLoadedState(policyDataEntity: data));
      },
    );
  }
}
