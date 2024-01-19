// ignore_for_file: depend_on_referenced_packages, empty_catches

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/snackbar_type.dart';
import 'package:captain_score/shared/common_widgets/appsflyer_constants.dart';
import 'package:captain_score/shared/cubit/app_language/app_language_cubit.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/models/app_language_model.dart';
import 'package:captain_score/shared/models/general_setting_model.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/custom_snackbar.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:path_provider/path_provider.dart';

class GeneralSettingCubit extends Cubit<double> {
  bool isMounted = true;
  final LoadingCubit loadingCubit;
  final SharedDataSource sharedDataSource;
  final AppLanguageCubit appLanguageCubit;

  GeneralSettingCubit({
    required this.sharedDataSource,
    required this.loadingCubit,
    required this.appLanguageCubit,
  }) : super(0);

  Future<String> createDyanmicLink({
    required String campanion,
    required bool isRetargetting,
    required Map<String, dynamic> params,
  }) async {
    var paramsString = '';
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    //   "af_ad": "yellow_bananas",
    //   "af_adset": "my_adset",
    //   "af_android_url": "https://feedme.ca/buybananas",
    //   "af_channel": "my_channel",
    //   "af_dp": "afbasicapp://mainactivity",
    //   "af_ios_url": "https://feedme.ca/buybananas",
    //   "c": "my_campaign",
    //   "deep_link_value": "bananas",
    //   "deep_link_sub1": 10,
    //   "is_retargeting": true,
    //   "pid": "my_media_source_SMS"
    // }

    String longUrl =
        "${AppsflyerConstants.brandBaseURL}?af_xp=custom&pid=dmt&c=$campanion&af_dp=captainscore%3A%2F%2Fmainactivity$paramsString";

    Map<String, dynamic> data = Map<String, dynamic>.from({
      "af_xp": "custom",
      "pid": "dmt",
      "c": campanion,
      "is_retargeting": isRetargetting.toString(),
      "af_dp": "captainscore://mainactivity",
      "af_channel": "dmt",
      "af_android_url": '${AppsflyerConstants.brandBaseURL}/$campanion',
      "af_ios_url": '${AppsflyerConstants.brandBaseURL}/$campanion',
    });
    data.addAll(params);

    String shortUrl = Uri.encodeFull(longUrl);

    loadingCubit.show();
    params.forEach((key, value) {
      if (key != AppsflyerConstants.afOgTitle &&
          key != AppsflyerConstants.afOgImage &&
          key != AppsflyerConstants.afOgDescription) {
        paramsString += '&$key=$value';
      }
    });

    longUrl = "${AppsflyerConstants.brandBaseURL}?pid=dmt&af_dp=captainscore%3A%2F%2Fmainactivity$paramsString";
    shortUrl = Uri.encodeFull(longUrl);
    return shortUrl;
  }

  Future<void> loadGeneralSettingData() async {
    final Either<AppError, GeneralSettingEntity> response = await sharedDataSource.getGeneralSetting();

    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (gs) async {
        try {
          if (generalSettingEntity?.versionCode != gs.versionCode) {
            List<AppLanguageListModel> languages =
                List<AppLanguageListModel>.from(appLanBox.get(HiveConstants.APP_LANGUAGE_LIST, defaultValue: []));

            languages = languages.where((element) => element.isDefault == 1).toList();
            if (languages.isNotEmpty) {
              appLanguageCubit.loadLanguageLabels(id: languages.first.id, shortCode: languages.first.shortCode);
            }
          }
        } on Exception {}
        generalSettingEntity = gs;
        generalSettingBox.put(HiveConstants.GENERAL_SETTING_DATA, generalSettingEntity);
        adsCubit.loadAdsSetting();

        if (gs.splashScreenVideoURL != null && gs.splashScreenVideoURL!.isNotEmpty) {
          String splashUrl = gs.splashScreenVideoURL!;

          final directory = '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}splash_video';
          File file = File('$directory${Platform.pathSeparator}${splashUrl.split('/').last.toString()}');

          if ((!await file.exists()) && splashUrl.startsWith('http')) {
            try {
              await file.create(recursive: true);

              Client client = Client();
              var req = await client.get(Uri.parse(splashUrl));
              var bytes = req.bodyBytes;
              await file.writeAsBytes(bytes);
            } on Exception {
              final directory =
                  '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}splash_video';
              File file = File('$directory${Platform.pathSeparator}${splashUrl.split('/').last}');
              if (await file.exists()) {
                await file.delete();
              }
            }
          }
        }
      },
    );
  }
}
