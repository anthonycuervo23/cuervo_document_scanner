import 'package:bakery_shop_flutter/features/address/data/models/manage_address_model.dart';
import 'package:equatable/equatable.dart';

class ManageAddressEntity extends Equatable {
  final List<AddressDetailes> addresses;
  const ManageAddressEntity({required this.addresses});

  @override
  List<Object?> get props => [addresses];
}
