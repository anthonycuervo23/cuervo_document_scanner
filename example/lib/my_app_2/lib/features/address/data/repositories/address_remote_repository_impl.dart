import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/address/domain/params/add_address_details_params.dart';
import 'package:bakery_shop_flutter/features/address/domain/repositories/address_remote_repository.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class AddressRemoteRepositoriesImpl extends AddressRemoteRepository {
  final AddressRemoteDataSource addressRemoteDataSource;

  AddressRemoteRepositoriesImpl({required this.addressRemoteDataSource});

  @override
  Future<Either<AppError, ManageAddressEntity>> getManageAddress() async {
    try {
      final result = await addressRemoteDataSource.getManageAddressDetails();
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteAddressDetail({required int id}) async {
    try {
      final result = await addressRemoteDataSource.deleteAddressDetail(id: id);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> addAddressDetails({required AddAddressDetailsParams params}) async {
    try {
      final result = await addressRemoteDataSource.addAddressDetails(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> setDefaultAddressDetails({required String params}) async {
    try {
      final result = await addressRemoteDataSource.setDefaultAddressDetails(param: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
