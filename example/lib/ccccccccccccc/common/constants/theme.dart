import 'package:captain_score/shared/models/theme_model.dart';

enum Themes { light, dark }

class ThemesList {
  const ThemesList._();

  static const themeList = [
    ThemeModel(key: "Light", theme: Themes.light),
    ThemeModel(key: "Dark", theme: Themes.dark),
  ];
}
