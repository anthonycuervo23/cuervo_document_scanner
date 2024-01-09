import 'package:bakery_shop_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepository appRepository;

  UpdateLanguage({required this.appRepository});

  @override
  Future<Either<AppError, void>> call(String params) async {
    return await appRepository.updateLanguage(params);
  }
}
