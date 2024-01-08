import 'package:bakery_shop_admin_flutter/common/constants/theme.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/data_sources/language_local_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/data_sources/theme_local_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:dartz/dartz.dart';

class AppRepositoryImpl extends AppRepository {
  final LanguageLocalDataSource languageLocalDataSource;
  final ThemeLocalDataSource themeLocalDataSource;

  AppRepositoryImpl({
    required this.languageLocalDataSource,
    required this.themeLocalDataSource,
  });

  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final response = await languageLocalDataSource.getPreferredLanguage();
      return Right(response);
    } on Exception {
      return const Left(AppError(errorType: AppErrorType.database, errorMessage: ''));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response = await languageLocalDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return const Left(AppError(errorType: AppErrorType.database, errorMessage: ''));
    }
  }

  @override
  Future<Either<AppError, Themes>> getPreferredTheme() async {
    try {
      final response = await themeLocalDataSource.getPreferredTheme();
      return Right(response);
    } on Exception {
      return const Left(AppError(errorType: AppErrorType.database, errorMessage: ''));
    }
  }

  @override
  Future<Either<AppError, void>> updateTheme(Themes theme) async {
    try {
      final response = await themeLocalDataSource.updateTheme(theme);
      return Right(response);
    } on Exception {
      return const Left(AppError(errorType: AppErrorType.database, errorMessage: ''));
    }
  }
}
