import 'package:bakery_shop_admin_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetPreferredLanguage({required this.appRepository});

  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await appRepository.getPreferredLanguage();
  }
}
