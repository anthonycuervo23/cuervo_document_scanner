import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/address/domain/params/add_address_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class AddressRemoteRepository {
  Future<Either<AppError, ManageAddressEntity>> getManageAddress();
  Future<Either<AppError, PostApiResponse>> addAddressDetails({required AddAddressDetailsParams params});
  Future<Either<AppError, PostApiResponse>> deleteAddressDetail({required int id});
  Future<Either<AppError, PostApiResponse>> setDefaultAddressDetails({required String params});
}
