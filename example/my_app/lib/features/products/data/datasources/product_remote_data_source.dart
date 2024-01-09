import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/core/api_constants.dart';
import 'package:bakery_shop_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

import '../models/product_category_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<AppError, ProductCategoryEntity>> getProductCategory({required NoParams params});
  Future<Either<AppError, ProductDataEntity>> getProductData({required ProductDataParms params});
}

class ProductDataSourceImpl extends ProductRemoteDataSource {
  final ApiClient client;

  ProductDataSourceImpl({required this.client});

  @override
  Future<Either<AppError, ProductCategoryEntity>> getProductCategory({required NoParams params}) async {
    try {
      final result = await commonApiApiCall<CategoryDataModel>(
        apiPath: 'categories',
        apiCallType: APICallType.GET,
        header: ApiConstatnts().headers,
        client: client,
        screenName: 'Category Screen',
        fromJson: (json) {
          final categoryModel = CategoryDataModel.fromJson(json);
          return categoryModel;
        },
      );

      return result.fold((appError) {
        return Left(appError);
      }, (list) {
        return Right(list.data!);
      });
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }

  Map<String, dynamic> listToUrlParams({required String keyName, required List<String> params}) {
    final map = <String, dynamic>{};
    for (var i = 0; i < params.length; i++) {
      map['$keyName[$i]'] = params[i];
    }
    return map;
  }

  @override
  Future<Either<AppError, ProductDataEntity>> getProductData({required ProductDataParms params}) async {
    try {
      Map<String, dynamic> queryParams = {};
      queryParams = {
        'category_id': params.categoryId,
        "page": params.page,
      };
      if (params.filterOrderBy?.isNotEmpty == true) {
        queryParams.addAll(listToUrlParams(keyName: 'order_by', params: params.filterOrderBy ?? []));
      }
      final result = await commonApiApiCall<ProductModel>(
        apiPath: 'products',
        apiCallType: APICallType.GET,
        header: ApiConstatnts().headers,
        client: client,
        params: queryParams,
        screenName: 'Get Product Screen',
        fromJson: (json) {
          final productModel = ProductModel.fromJson(json);
          return productModel;
        },
      );
      return result.fold((appError) => Left(appError), (list) => Right(list.data!));
    } on UnauthorisedException catch (_) {
      return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "unauthorised"));
    }
  }
}
