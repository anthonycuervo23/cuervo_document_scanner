import 'package:bakery_shop_flutter/features/products/data/datasources/product_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetProductCategoryData extends UseCase<ProductCategoryEntity, NoParams> {
  final ProductRemoteDataSource productRemoteDataSource;

  GetProductCategoryData({required this.productRemoteDataSource});

  @override
  Future<Either<AppError, ProductCategoryEntity>> call(NoParams params) async {
    return await productRemoteDataSource.getProductCategory(params: params);
  }
}
