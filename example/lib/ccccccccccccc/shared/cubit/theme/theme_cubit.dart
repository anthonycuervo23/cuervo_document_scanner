// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:captain_score/common/constants/theme.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:dartz/dartz.dart';

class ThemeCubit extends Cubit<Themes> {
  final SharedDataSource dataSource;
  bool isMounted = true;
  ThemeCubit({required this.dataSource}) : super(Themes.light);

  Future<void> toggleTheme() async {
    await dataSource.updateTheme(state == Themes.dark ? Themes.light : Themes.dark);
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {
    final Either<AppError, Themes> response = await dataSource.getPreferredTheme();
    if (!isMounted) return;
    emit(response.fold((error) => Themes.light, (successTheme) => successTheme));
  }
}
