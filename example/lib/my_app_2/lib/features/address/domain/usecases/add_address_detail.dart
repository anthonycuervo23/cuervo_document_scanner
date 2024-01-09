import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/address/domain/params/add_address_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class AddAddressDetails extends UseCase<PostApiResponse, AddAddressDetailsParams> {
  final AddressRemoteDataSource addressDataSource;

  AddAddressDetails({required this.addressDataSource});

  @override
  Future<Either<AppError, PostApiResponse>> call(AddAddressDetailsParams params) async {
    return await addressDataSource.addAddressDetails(param: params);
  }
}
