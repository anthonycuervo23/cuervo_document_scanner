import 'dart:developer';

import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/core/api_constants.dart';
import 'package:bakery_shop_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_flutter/features/address/data/models/manage_address_model.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/address/domain/params/add_address_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class AddressRemoteDataSource {
  Future<Either<AppError, ManageAddressEntity>> getManageAddressDetails();
  Future<Either<AppError, PostApiResponse>> deleteAddressDetail({required int id});
  Future<Either<AppError, PostApiResponse>> addAddressDetails({required AddAddressDetailsParams param});
  Future<Either<AppError, PostApiResponse>> setDefaultAddressDetails({required String param});
}

class AddressDataSourceImpl extends AddressRemoteDataSource {
  final ApiClient client;

  AddressDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, ManageAddressEntity>> getManageAddressDetails() async {
    final result = await commonApiApiCall<ManageAddressModel>(
      apiPath: 'address',
      apiCallType: APICallType.GET,
      screenName: 'Manage Address Screen',
      client: client,
      fromJson: (json) {
        final manageAddressModel = ManageAddressModel.fromJson(json);
        return manageAddressModel;
      },
    );

    return result.fold((appError) => Left(appError), (list) {
      return Right(list.data!);
    });
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteAddressDetail({required int id}) async {
    final result = await commonApiApiCall<PostApiResponse>(
      apiPath: 'address/remove/$id',
      screenName: 'Delete Address Screen',
      header: ApiConstatnts().headers,
      apiCallType: APICallType.DELETE,
      client: client,
      fromJson: (json) {
        final addressdetails = PostApiResponse.fromJson(json);
        return addressdetails;
      },
    );

    return result.fold(
      (appError) {
        return Left(appError);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either<AppError, PostApiResponse>> addAddressDetails({required AddAddressDetailsParams param}) async {
    Map<String, dynamic> params = {
      "address_id": param.id,
      "name": param.name,
      "mobile": param.mobile,
      "flat_no": param.floatNo.toString(),
      "locality": param.locality.toString(),
      "landmark": param.landmark,
      "city": param.cityName,
      "state": param.stateName,
      "country": param.countryName,
      "zip_code": param.pinCode,
      "country_code": param.countryCode,
      "address_type": param.addressType.toString(),
    };
    log(params.toString());
    try {
      final result = await commonApiApiCall<PostApiResponse>(
        apiPath: 'address/store',
        params: params,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Add Address',
        fromJson: (json) {
          final userModel = PostApiResponse.fromJson(json);
          return userModel;
        },
      );
      return result.fold(
        (appError) {
          return Left(appError);
        },
        (data) {
          return Right(data);
        },
      );
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> setDefaultAddressDetails({required String param}) async {
    Map<String, dynamic> params = {
      "address_id": param,
    };
    log(params.toString());
    try {
      final result = await commonApiApiCall<PostApiResponse>(
        apiPath: 'address/default',
        params: params,
        apiCallType: APICallType.POST,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Default Address',
        fromJson: (json) {
          final userModel = PostApiResponse.fromJson(json);
          return userModel;
        },
      );
      return result.fold(
        (appError) {
          return Left(appError);
        },
        (data) {
          return Right(data);
        },
      );
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }
}
