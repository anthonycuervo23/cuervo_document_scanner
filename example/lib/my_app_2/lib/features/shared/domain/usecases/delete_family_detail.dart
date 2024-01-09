import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteFamilyDetail extends UseCase<PostApiResponse, int> {
  final UserRemoteRepository userRemoteRepository;

  DeleteFamilyDetail({required this.userRemoteRepository});

  @override
  Future<Either<AppError, PostApiResponse>> call(int params) async {
    return await userRemoteRepository.deleteFamilyDetail(id: params);
  }
}
