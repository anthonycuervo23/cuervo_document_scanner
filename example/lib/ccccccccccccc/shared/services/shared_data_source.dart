import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/theme.dart';
import 'package:captain_score/common/core/api_client.dart';
import 'package:captain_score/core/api_constants.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/models/app_language_model.dart';
import 'package:captain_score/shared/models/boolean_model.dart';
import 'package:captain_score/shared/models/general_setting_model.dart';
import 'package:captain_score/shared/services/common_api_calls.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

// ignore: constant_identifier_names
enum APICallType { GET, POST, DIRECTGET, DIRECTPOST, POSTFILES }

abstract class SharedDataSource {
  Future<void> updateLanguage(String languageCode);
  Future<Either<AppError, String>> getPreferredLanguage();
  Future<void> updateTheme(Themes? themes);
  Future<Either<AppError, Themes>> getPreferredTheme();
  Future<Either<AppError, bool>> getAppLangLabel({required String langId});
  Future<Either<AppError, bool>> updateUserSetting({required int id});
  Future<Either<AppError, List<AppLanguageListModel>>> getAppLanguageList();
  Future<Either<AppError, GeneralSettingEntity>> getGeneralSetting();
}

class SharedServicesDataSourceImpl extends SharedDataSource with CommonApiCalls {
  final ApiClient client;

  SharedServicesDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    final languageBox = await Hive.openBox(HiveBoxConstants.CURRENT_LANG_BOX);
    return languageBox.get(HiveConstants.PREFERRED_LANGUAGE, defaultValue: 'en');
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox(HiveBoxConstants.CURRENT_LANG_BOX);
    unawaited(languageBox.put(HiveConstants.PREFERRED_LANGUAGE, languageCode));
  }

  @override
  Future<Either<AppError, Themes>> getPreferredTheme() async {
    final theme = await Hive.openBox(HiveBoxConstants.THEME_BOX);
    return Right(theme.get(HiveConstants.APP_THEME_MODE, defaultValue: 'light') == 'dark' ? Themes.dark : Themes.light);
  }

  @override
  Future<void> updateTheme(Themes? themes) async {
    final themeBox = await Hive.openBox(HiveBoxConstants.THEME_BOX);
    unawaited(themeBox.put(HiveConstants.APP_THEME_MODE, (themes ?? Themes.dark) == Themes.dark ? 'dark' : 'light'));
  }

  @override
  Future<Either<AppError, bool>> getAppLangLabel({required String langId}) async {
    Map<String, dynamic> rawData = {};

    var params = {"language_id": langId.split('@').first};

    Either<AppError, BooleanModel> result = await commonApiApiCall<BooleanModel>(
      client: client,
      apiPath: "/labels/get",
      params: params,
      apiCallType: APICallType.GET,
      header: ApiConstatnts().headers,
      fromJson: (json) {
        rawData = json;
        final parseData = BooleanModel.fromJson(json);
        return parseData;
      },
      screenName: "App Language Label Page",
    );

    return (result.fold((error) => Left(error), (data) async {
      if (rawData["data"] != null) {
        String langCode = langId.split('@').last;
        File file = await File('$languageLocalPath/$langCode.json').create(recursive: true);

        file.writeAsStringSync(jsonEncode(rawData["data"]), flush: true, mode: FileMode.write);
      }
      return Right(data.data!);
    }));
  }

  @override
  Future<Either<AppError, bool>> updateUserSetting({required int id}) async {
    var params = {"app_language_id": id};

    Either<AppError, BooleanModel> result = await commonApiApiCall<BooleanModel>(
      client: client,
      apiPath: "/user/setting/save",
      params: params,
      apiCallType: APICallType.POST,
      header: ApiConstatnts().headers,
      fromJson: (json) {
        final parseData = BooleanModel.fromJson(json);
        return parseData;
      },
      screenName: "Update App Language Page",
    );

    return (result.fold((error) => Left(error), (data) => Right(data.data!)));
  }

  @override
  Future<Either<AppError, List<AppLanguageListModel>>> getAppLanguageList() async {
    Either<AppError, AppLanModel> result = await commonApiApiCall<AppLanModel>(
      client: client,
      apiPath: "/languages/app",
      apiCallType: APICallType.GET,
      header: ApiConstatnts().headers,
      fromJson: (json) {
        final parseData = AppLanModel.fromJson(json);
        return parseData;
      },
      screenName: "App Languages",
    );

    return (result.fold((error) => Left(error), (data) => Right(data.data)));
  }

  @override
  Future<Either<AppError, GeneralSettingEntity>> getGeneralSetting() async {
    Either<AppError, GeneralSettingModel> result = await commonApiApiCall<GeneralSettingModel>(
      client: client,
      apiPath: "/settings/get",
      apiCallType: APICallType.GET,
      header: ApiConstatnts().headers,
      fromJson: (json) {
        final parseData = GeneralSettingModel.fromJson(json);
        return parseData;
      },
      screenName: "General Setting",
    );

    return (result.fold((error) => Left(error), (data) => Right(data.data!)));
  }
}
