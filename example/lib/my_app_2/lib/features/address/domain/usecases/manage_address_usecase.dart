import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetManageAddressData extends UseCase<ManageAddressEntity, NoParams> {
  final AddressRemoteDataSource addressDataSource;

  GetManageAddressData({required this.addressDataSource});

  @override
  Future<Either<AppError, ManageAddressEntity>> call(NoParams params) async {
    return await addressDataSource.getManageAddressDetails();
  }
}
