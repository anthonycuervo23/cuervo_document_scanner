// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:bakery_shop_admin_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_admin_flutter/common/constants/languages.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  late Map<String, String> _localizedStrings;
  late Map<String, String> _fallbackLocalizedStrings;

  Future<bool> load(bool status) async {
    if (kIsWeb && (storage.getItem('${locale.languageCode}.json') != null)) {
      String fileData = storage.getItem('${locale.languageCode}.json');
      final Map<String, dynamic> jsonMap = json.decode(fileData);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      final jsonString = await rootBundle.loadString('assets/languages/en.json');
      final Map<String, dynamic> fallBackJsonMap = json.decode(jsonString);
      _fallbackLocalizedStrings = fallBackJsonMap.map((key, value) => MapEntry(key, value.toString()));
      return true;
    }

    if (status) {
      String langFile =
          '${await AppFunctions().getApplicationDirectory()}${Platform.pathSeparator}languages${Platform.pathSeparator}${locale.languageCode}.json';

      String fileData = File(langFile).readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(fileData);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      final jsonString = await rootBundle.loadString('assets/languages/en.json');
      final Map<String, dynamic> fallBackJsonMap = json.decode(jsonString);
      _fallbackLocalizedStrings = fallBackJsonMap.map((key, value) => MapEntry(key, value.toString()));

      return true;
    }
    if (!status) {
      final jsonString = await rootBundle.loadString('assets/languages/en.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      _fallbackLocalizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

      return true;
    }
    return false;
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
    if (kIsWeb && (storage.getItem('${locale.languageCode}.json') != null)) {
      AppLocalizations localizations = AppLocalizations(locale);
      await localizations.load(true);
      return localizations;
    }

    String langFile =
        '${await AppFunctions().getApplicationDirectory()}${Platform.pathSeparator}languages${Platform.pathSeparator}${locale.languageCode}.json';

    if (await File(langFile).exists()) {
      AppLocalizations localizations = AppLocalizations(locale);
      await localizations.load(true);
      return localizations;
    }

    AppLocalizations localizations = AppLocalizations(const Locale('en'));
    await localizations.load(false);
    List<AppLanguageEntity> tempList = <AppLanguageEntity>[];
    for (var element in languages) {
      tempList.add(element.copyWith(isDefault: 0));
    }
    tempList[0] = tempList[0].copyWith(isDefault: 1);
    languages = tempList;
    appLanBox.put(HiveConstants.APP_LANGUAGE_LIST, languages);
    currentLanBox.put(HiveConstants.PREFERRED_LANGUAGE, 'en');
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
