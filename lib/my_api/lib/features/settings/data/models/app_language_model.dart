// ignore_for_file: prefer_collection_literals, avoid_print, overridden_fields, annotate_overrides

import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';

class AppLanguageModel {
  int? status;
  bool? success;
  String? message;
  List<AppLanguageEntity> languageList = <LanguageList>[];

  AppLanguageModel({this.status, this.success, this.message, required this.languageList});

  AppLanguageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    (json['data'] != null && json['status'] == 200)
        ? json['data'].forEach((v) => languageList.add(LanguageList.fromJson(v)))
        : [];
  }
}

class LanguageList extends AppLanguageEntity {
  final int id;
  final String name;
  final String shortCode;
  final int isDefault;
  final String imageUrl;
  final String language;

  LanguageList(
      {required this.id,
      required this.name,
      required this.shortCode,
      required this.isDefault,
      required this.imageUrl,
      required this.language})
      : super(
          id: id,
          name: name,
          shortCode: shortCode,
          isDefault: isDefault,
          imageUrl: imageUrl,
          // language: language,
        );

  factory LanguageList.fromJson(Map<String, dynamic> json) {
    return LanguageList(
      id: json['id'],
      name: json['name'],
      shortCode: json['short_code'] == 'hn' ? 'hi' : json['short_code'],
      isDefault: json['is_default'],
      imageUrl: json['image_url'] ?? 'https://example.com',
      language: json['language'],
    );
  }
}
