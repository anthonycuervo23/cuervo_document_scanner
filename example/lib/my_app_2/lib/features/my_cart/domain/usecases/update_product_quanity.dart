import 'package:bakery_shop_flutter/features/my_cart/data/datasources/my_cart_data_sources.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateProductQuntity extends UseCase<PostApiResponse, UpdateQuantityParms> {
  final MyCartDataSources myCartDataSources;

  UpdateProductQuntity({required this.myCartDataSources});

  @override
  Future<Either<AppError, PostApiResponse>> call(UpdateQuantityParms params) async {
   return await myCartDataSources.updateCartProduct(params: params);
  }
}
