import 'package:captain_score/shared/models/app_language_model.dart';

List<AppLanguageListModel> languages = [
  AppLanguageListModel(id: 1, name: 'English', shortCode: 'en', isDefault: 1),
];

class Languages {
  Languages._();

  static const String english = 'en';
  static const String hindi = 'hi';
  static const String gujarati = 'gu';
}
