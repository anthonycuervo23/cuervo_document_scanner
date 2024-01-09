import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/upload_file_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UploadFile extends UseCase<UploadFileEntity, UploadFileParams> {
  final UserRemoteRepository userRemoteRepository;

  UploadFile({required this.userRemoteRepository});

  @override
  Future<Either<AppError, UploadFileEntity>> call(UploadFileParams params) async {
    return await userRemoteRepository.uploadFile(params: params);
  }
}
