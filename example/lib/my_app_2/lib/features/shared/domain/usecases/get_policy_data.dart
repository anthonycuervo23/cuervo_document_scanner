import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAccountInfoData extends UseCase<AccountInfoEntity, NoParams> {
  final UserRemoteRepository userRemoteRepository;

  GetAccountInfoData({required this.userRemoteRepository});

  @override
  Future<Either<AppError, AccountInfoEntity>> call(NoParams params) async {
    return await userRemoteRepository.getAccountInfo();
  }
}
