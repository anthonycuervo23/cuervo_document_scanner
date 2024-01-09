import 'package:bakery_shop_flutter/common/constants/theme.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPreferredTheme extends UseCase<Themes, NoParams> {
  final AppRepository appRepository;

  GetPreferredTheme({required this.appRepository});

  @override
  Future<Either<AppError, Themes>> call(NoParams params) async {
    return await appRepository.getPreferredTheme();
  }
}
