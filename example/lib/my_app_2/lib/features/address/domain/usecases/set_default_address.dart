import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class SetDefaultAddressDetails extends UseCase<PostApiResponse, String> {
  final AddressRemoteDataSource addressDataSource;

  SetDefaultAddressDetails({required this.addressDataSource});

  @override
  Future<Either<AppError, PostApiResponse>> call(String params) async {
    return await addressDataSource.setDefaultAddressDetails(param: params);
  }
}
