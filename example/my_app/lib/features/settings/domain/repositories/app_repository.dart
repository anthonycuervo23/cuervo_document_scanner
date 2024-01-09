import 'package:bakery_shop_flutter/common/constants/theme.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class AppRepository {
  Future<Either<AppError, void>> updateLanguage(String language);
  Future<Either<AppError, String>> getPreferredLanguage();
  Future<Either<AppError, void>> updateTheme(Themes theme);
  Future<Either<AppError, Themes>> getPreferredTheme();
}
