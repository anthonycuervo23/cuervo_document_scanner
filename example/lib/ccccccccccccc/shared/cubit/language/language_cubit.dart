// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SharedDataSource dataSource;
  bool isMounted = true;

  LanguageCubit({
    required this.dataSource,
  }) : super(LanguageLoaded(Locale(currentLangCode)));

  void toggleLanguage({required String shortCode}) async {
    await dataSource.updateLanguage(shortCode);
    loadPreferredLanguage();
  }

  Future<void> loadPreferredLanguage() async {
    Either<AppError, String> response = await dataSource.getPreferredLanguage();
    if (!isMounted) return;
    emit(
      response.fold(
        (l) => LanguageError(appErrorType: l.errorType),
        (r) => LanguageLoaded(Locale(r)),
      ),
    );
  }
}
