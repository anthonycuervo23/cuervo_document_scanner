import 'package:bakery_shop_flutter/features/shared/data/models/account_info_model.dart';
import 'package:equatable/equatable.dart';

class AccountInfoEntity extends Equatable {
  final int id;
  final String name;
  final String subDomain;
  final String image;
  final String defaultImage;
  final AppSetting appSetting;

  const AccountInfoEntity({
    required this.id,
    required this.name,
    required this.subDomain,
    required this.image,
    required this.defaultImage,
    required this.appSetting,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        subDomain,
        image,
        defaultImage,
        appSetting,
      ];
}
