import 'dart:convert';
import 'dart:io';

import 'package:captain_score/shared/models/app_language_model.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/languages.dart';
import 'package:path_provider/path_provider.dart';

class AppLocalizations {
  late final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  late Map<String, String> _localizedStrings;
  late Map<String, String> _fallbackLocalizedStrings;

  Future<bool> load(bool status) async {
    String langFile =
        '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}languages${Platform.pathSeparator}${locale.languageCode}.json';

    if (status) {
      String fileData = File(langFile).readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(fileData);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      final jsonString = await rootBundle.loadString('assets/languages/en.json');
      final Map<String, dynamic> fallBackJsonMap = json.decode(jsonString);
      _fallbackLocalizedStrings = fallBackJsonMap.map((key, value) => MapEntry(key, value.toString()));

      if (kDebugMode) {
        // print("load from file");
      }
      return true;
    } else {
      final jsonString = await rootBundle.loadString('assets/languages/en.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      _fallbackLocalizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      return true;
    }
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }

  String? defaultTranslate(String key) {
    return _fallbackLocalizedStrings[key];
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // print("Locale" + locale.languageCode.toString());
    // print("Locale" + languages.map((e) => e.shortCode).toList().contains(locale.languageCode).toString());
    return languages.map((e) => e.shortCode).toList().contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    String langFile =
        '${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}languages${Platform.pathSeparator}${locale.languageCode}.json';

    if (await File(langFile).exists()) {
      AppLocalizations localizations = AppLocalizations(locale);
      await localizations.load(true);
      return localizations;
    } else {
      AppLocalizations localizations = AppLocalizations(const Locale('en'));

      await localizations.load(false);

      List<AppLanguageListModel> tempList = <AppLanguageListModel>[];
      for (var element in languages) {
        tempList.add(element.copyWith(isDefault: 0));
      }
      tempList[0] = tempList[0].copyWith(isDefault: 1);
      languages = tempList;
      appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
      currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, 'en');
      return localizations;
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
