// ignore_for_file: empty_catches

import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/languages.dart';
import 'package:captain_score/core/build_context.dart';
import 'package:captain_score/shared/cubit/language/language_cubit.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/models/app_language_model.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  final SharedDataSource dataSource;
  final LoadingCubit loadingCubit;

  bool isMounted = true;

  AppLanguageCubit({required this.dataSource, required this.loadingCubit}) : super(AppLanguageInitial());

  Future<void> loadAppLanguageList() async {
    // loadingCubit.show();
    if (!isMounted) return;
    emit(AppLanguageLoadingState());

    final Either<AppError, List<AppLanguageListModel>> response = await dataSource.getAppLanguageList();
    if (!isMounted) return;
    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        emit(AppLanguageErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (List<AppLanguageListModel> appLangList) {
        String defaultLangCode;
        try {
          defaultLangCode = languages.where((element) => element.isDefault == 1).toList().first.shortCode;
          int index = appLangList.indexWhere((element) => element.shortCode == defaultLangCode);

          List<AppLanguageListModel> tempList = <AppLanguageListModel>[];
          for (var element in appLangList) {
            tempList.add(element.copyWith(isDefault: 0));
          }
          tempList[index] = tempList[index].copyWith(isDefault: 1);
          languages = tempList;
        } on Exception {
          defaultLangCode = 'en';
          languages = appLangList;
        }
        appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
        if (!isMounted) return;
        emit(AppLanguageLoadedState(appLanguageList: languages, origionalLanguageList: languages));
      },
    );
    // loadingCubit.hide();
  }

  void filterList({
    required String searchString,
    required List<AppLanguageListModel> appLanguageList,
    required List<AppLanguageListModel> origionalLanguageList,
  }) {
    if (!isMounted) return;
    emit(AppLanguageLoadingState());
    if (!isMounted) return;
    emit(
      AppLanguageLoadedState(
        appLanguageList:
            origionalLanguageList.where((element) => element.name.toLowerCase().contains(searchString)).toList(),
        origionalLanguageList: origionalLanguageList,
      ),
    );
  }

  Future<void> updateLanguage(BuildContext context, int index, AppLanguageLoadedState state) async {
    loadingCubit.show();
    if (kDebugMode) {
      print(state.appLanguageList[index].shortCode);
    }

    final Either<AppError, bool> response = await dataSource.getAppLangLabel(
      langId: '${state.appLanguageList[index].id}@${state.appLanguageList[index].shortCode}',
    );
    if (!isMounted) return;
    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        emit(AppLanguageErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (bool status) async {
        if (status) {
          final Either<AppError, bool> response = await dataSource.updateUserSetting(
            id: state.appLanguageList[index].id,
          );
          if (!isMounted) return;
          response.fold(
            (error) async {
              if (error.errorType == AppErrorType.unauthorised) {
                await AppFunctions().forceLogout();
              }
              emit(AppLanguageErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
            },
            (bool status) {
              List<AppLanguageListModel> tempList = <AppLanguageListModel>[];
              for (var element in languages) {
                tempList.add(element.copyWith(isDefault: 0));
              }
              tempList[index] = tempList[index].copyWith(isDefault: 1);
              languages.clear();
              languages.addAll(tempList);
              appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
              currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, languages[index].shortCode.toString());
              context.read<LanguageCubit>().toggleLanguage(shortCode: languages[index].shortCode.toString());

              if (!isMounted) return;
              emit(AppLanguageLoadedState(
                  appLanguageList: languages, origionalLanguageList: state.origionalLanguageList));
            },
          );
        } else {
          if (!isMounted) return;
          emit(AppLanguageLoadedState(
              appLanguageList: state.appLanguageList, origionalLanguageList: state.origionalLanguageList));
        }
      },
    );
    // }
    loadingCubit.hide();
  }

  Future<void> loadLanguageLabels({required int id, required String shortCode}) async {
    final Either<AppError, bool> response = await dataSource.getAppLangLabel(langId: '$id@$shortCode');
    if (!isMounted) return;
    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        emit(AppLanguageErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (bool status) async {
        try {
          buildContext.read<LanguageCubit>().toggleLanguage(shortCode: languages.first.shortCode.toString());
        } on Exception {}
      },
    );
  }
}
