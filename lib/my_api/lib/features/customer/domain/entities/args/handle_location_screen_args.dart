import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:equatable/equatable.dart';

class HandleLocationArgs extends Equatable {
  final CheckLoactionNavigation navigateFrom;
  final Addresstype? addresstype;
  final String? flanNo;
  final String? address;
  final String? landmark;

  const HandleLocationArgs({
    required this.navigateFrom,
    this.flanNo,
    this.address,
    this.landmark,
    this.addresstype,
  });

  HandleLocationArgs copyWith({
    CheckLoactionNavigation? navigateFrom,
    Addresstype? addresstype,
    String? flanNo,
    String? address,
    String? landmark,
  }) {
    return HandleLocationArgs(
      navigateFrom: navigateFrom ?? this.navigateFrom,
      addresstype: addresstype ?? this.addresstype,
      flanNo: flanNo ?? this.flanNo,
      address: address ?? this.address,
      landmark: landmark ?? this.landmark,
    );
  }

  @override
  List<Object?> get props => [navigateFrom, flanNo, address, landmark];
}
