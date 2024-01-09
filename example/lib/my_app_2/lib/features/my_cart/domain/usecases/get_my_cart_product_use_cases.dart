import 'package:bakery_shop_flutter/features/my_cart/data/datasources/my_cart_data_sources.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMyCartProductUseCases extends UseCase<MyCartEntity, NoParams> {
  final MyCartDataSources myCartDataSources;

  GetMyCartProductUseCases({required this.myCartDataSources});

  @override
  Future<Either<AppError, MyCartEntity>> call(NoParams params) async {
    return await myCartDataSources.getCartProduct(params: params);
  }
}
