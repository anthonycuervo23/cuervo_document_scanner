import 'package:bakery_shop_flutter/features/products/data/datasources/product_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetProductData extends UseCase<ProductDataEntity, ProductDataParms> {
  final ProductRemoteDataSource productRemoteDataSource;

  GetProductData({required this.productRemoteDataSource});

  @override
  Future<Either<AppError, ProductDataEntity>> call(ProductDataParms params) async {
    return await productRemoteDataSource.getProductData(params: params);
  }
}
