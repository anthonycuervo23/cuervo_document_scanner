import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRemoteRepository {
  Future<Either<AppError, ProductCategoryEntity>> getProductCategory({required NoParams params});
  Future<Either<AppError, ProductDataEntity>> getProductData({required ProductDataParms params});
}
