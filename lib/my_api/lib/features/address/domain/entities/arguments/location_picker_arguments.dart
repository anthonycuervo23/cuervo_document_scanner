import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:equatable/equatable.dart';

class LocationPickerScreenArguments extends Equatable {
  final String? address;
  final CheckLoactionNavigation navigationFrom;

  const LocationPickerScreenArguments({this.address, required this.navigationFrom});

  @override
  List<Object?> get props => [address, navigationFrom];
}
