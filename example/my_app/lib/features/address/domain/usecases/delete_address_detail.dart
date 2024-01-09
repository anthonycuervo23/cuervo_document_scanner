import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteAddress extends UseCase<PostApiResponse, int> {
  final AddressRemoteDataSource addressDataSource;

  DeleteAddress({required this.addressDataSource});

  @override
  Future<Either<AppError, PostApiResponse>> call(int params) async {
    return await addressDataSource.deleteAddressDetail(id: params);
  }
}
