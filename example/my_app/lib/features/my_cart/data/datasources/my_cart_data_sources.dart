import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/my_cart/data/models/my_cart_model.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class MyCartDataSources {
  Future<Either<AppError, MyCartEntity>> getCartProduct({required NoParams params});
  Future<Either<AppError, PostApiResponse>> addCartProduct({required AddProductMyCartParms params});
  Future<Either<AppError, PostApiResponse>> updateCartProduct({required UpdateQuantityParms params});
  Future<Either<AppError, PostApiResponse>> deleteCartProduct({required int params});
}

class MyCartDataSourcesImpl extends MyCartDataSources {
  final ApiClient client;

  MyCartDataSourcesImpl({required this.client});

  @override
  Future<Either<AppError, MyCartEntity>> getCartProduct({required NoParams params}) async {
    final result = await commonApiApiCall<MyCartModel>(
      apiPath: 'cart',
      apiCallType: APICallType.GET,
      screenName: 'My Cart Screen',
      client: client,
      fromJson: (json) {
        final data = MyCartModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data!));
  }

  @override
  Future<Either<AppError, PostApiResponse>> addCartProduct({required AddProductMyCartParms params}) async {
    Map<String, dynamic> parms = {};
    if (params.productId != null && params.productPriceId != null) {
      parms = {'product_id': params.productId, 'product_price_id': params.productPriceId, 'qty': params.qty};
    } else {
      parms = {'product_id': params.productId, 'qty': params.qty};
    }
    final result = await commonApiApiCall<PostApiResponse>(
      apiPath: 'cart/add',
      apiCallType: APICallType.POST,
      screenName: 'My Cart Screen For Add Cart Product',
      params: parms,
      client: client,
      fromJson: (json) {
        final data = PostApiResponse.fromJson(json);
        return data;
      },
    );

    return result.fold(
      (appError) {
        return Left(appError);
      },
      (list) {
        return Right(list);
      },
    );
  }

  @override
  Future<Either<AppError, PostApiResponse>> updateCartProduct({required UpdateQuantityParms params}) async {
    Map<String, dynamic> parms = {'cart_id': params.cartId, 'qty': params.quantity};
    final result = await commonApiApiCall<PostApiResponse>(
      apiPath: 'cart/update-qty',
      apiCallType: APICallType.POST,
      screenName: 'My Cart Screen For Update Cart Product',
      client: client,
      params: parms,
      fromJson: (json) {
        final data = PostApiResponse.fromJson(json);
        return data;
      },
    );
    return result.fold((appError) => Left(appError), (list) => Right(list));
  }

  @override
  Future<Either<AppError, PostApiResponse>> deleteCartProduct({required int params}) async {
    int id = params;
    final result = await commonApiApiCall<PostApiResponse>(
      apiPath: 'cart/remove/$id',
      apiCallType: APICallType.DELETE,
      screenName: 'My Cart Screen For Update Cart Product',
      client: client,
      fromJson: (json) {
        final data = PostApiResponse.fromJson(json);
        return data;
      },
    );
    return result.fold((appError) => Left(appError), (list) => Right(list));
  }
}
