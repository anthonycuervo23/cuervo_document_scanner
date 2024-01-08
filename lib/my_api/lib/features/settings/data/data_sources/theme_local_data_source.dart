import 'dart:async';

import 'package:bakery_shop_admin_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_admin_flutter/common/constants/theme.dart';
import 'package:hive/hive.dart';

abstract class ThemeLocalDataSource {
  Future<void> updateTheme(Themes? themes);
  Future<Themes> getPreferredTheme();
}

class ThemeLocalDataSourceImpl extends ThemeLocalDataSource {
  @override
  Future<Themes> getPreferredTheme() async {
    final theme = await Hive.openBox(HiveBoxConstants.THEME_BOX);
    return theme.get(HiveConstants.APP_THEME_MODE, defaultValue: 'light') == 'dark' ? Themes.dark : Themes.light;
  }

  @override
  Future<void> updateTheme(Themes? themes) async {
    final themeBox = await Hive.openBox(HiveBoxConstants.THEME_BOX);
    unawaited(themeBox.put(HiveConstants.APP_THEME_MODE, (themes ?? Themes.dark) == Themes.dark ? 'dark' : 'light'));
  }
}
