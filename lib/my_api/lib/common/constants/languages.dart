import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';

List<AppLanguageEntity> languages = [
  AppLanguageEntity(id: 1, name: 'English', shortCode: 'en', isDefault: 1, imageUrl: ''),
];

class Languages {
  Languages._();

  static const String english = 'en';
  static const String hindi = 'hi';
  static const String gujarati = 'gu';
}
