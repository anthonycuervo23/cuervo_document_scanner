// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_shop_flutter/common/constants/theme.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/get_preferred_theme.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/update_theme.dart';
import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<Themes> {
  final GetPreferredTheme getPreferredTheme;
  final UpdateTheme updateTheme;

  bool isMounted = true;

  ThemeCubit({
    required this.getPreferredTheme,
    required this.updateTheme,
  }) : super(Themes.light);

  Future<void> toggleTheme() async {
    await updateTheme(state == Themes.dark ? Themes.light : Themes.dark);
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {
    final response = await getPreferredTheme(NoParams());
    if (!isMounted) return;
    emit(response.fold((l) => Themes.light, (r) => r));
  }
}
