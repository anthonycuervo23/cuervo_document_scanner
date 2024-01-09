import 'package:bakery_shop_flutter/features/products/data/datasources/product_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/products/domain/repositories/product_remote_repository.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

class ProductRemoteRepositoriesImpl extends ProductRemoteRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepositoriesImpl({required this.productRemoteDataSource});

  @override
  Future<Either<AppError, ProductCategoryEntity>> getProductCategory({required NoParams params}) async {
    try {
      final result = await productRemoteDataSource.getProductCategory(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, ProductDataEntity>> getProductData({required ProductDataParms params}) async {
    try {
      final result = await productRemoteDataSource.getProductData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
