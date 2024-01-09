import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_profile_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateUserDetail extends UseCase<PostApiResponse, UpdateUserDetailParams> {
  final UserRemoteRepository userRemoteRepository;

  UpdateUserDetail({required this.userRemoteRepository});

  @override
  Future<Either<AppError, PostApiResponse>> call(UpdateUserDetailParams params) async {
    return await userRemoteRepository.updateUserDetail(params: params);
  }
}
