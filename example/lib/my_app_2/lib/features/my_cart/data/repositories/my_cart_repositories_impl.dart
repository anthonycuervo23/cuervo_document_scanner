import 'package:bakery_shop_flutter/features/my_cart/data/datasources/my_cart_data_sources.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/repositories/my_cart_repositories.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

class MyCartRepositoryImpl extends MyCartRepository {
  final MyCartDataSources myCartDataSources;

  MyCartRepositoryImpl({required this.myCartDataSources});

  @override
  Future<Either<AppError, MyCartEntity>> getCartProduct({required NoParams params}) async {
    try {
      final result = await myCartDataSources.getCartProduct(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> addCartProduct({required AddProductMyCartParms params}) async {
    try {
      final result = await myCartDataSources.addCartProduct(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteCartProduct({required int params}) async {
    try {
      final result = await myCartDataSources.deleteCartProduct(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateCartProduct({required UpdateQuantityParms params}) async {
    try {
      final result = await myCartDataSources.updateCartProduct(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
