import 'package:bakery_shop_flutter/common/constants/theme.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateTheme extends UseCase<void, Themes> {
  final AppRepository appRepository;

  UpdateTheme({required this.appRepository});

  @override
  Future<Either<AppError, void>> call(Themes params) async {
    return await appRepository.updateTheme(params);
  }
}
