import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:dartz/dartz.dart';

abstract class MyCartRepository {
  Future<Either<AppError, MyCartEntity>> getCartProduct({required NoParams params});
  Future<Either<AppError, PostApiResponse>> addCartProduct({required AddProductMyCartParms params});
  Future<Either<AppError, PostApiResponse>> updateCartProduct({required UpdateQuantityParms params});
  Future<Either<AppError, PostApiResponse>> deleteCartProduct({required int params});
}
