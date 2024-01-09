import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetUserData extends UseCase<UserEntity, NoParams> {
  final UserRemoteRepository userRemoteRepository;

  GetUserData({required this.userRemoteRepository});

  @override
  Future<Either<AppError, UserEntity>> call(NoParams params) async {
    return await userRemoteRepository.getUserDetails();
  }
}
