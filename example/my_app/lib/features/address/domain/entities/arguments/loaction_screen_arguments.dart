import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:equatable/equatable.dart';

class LoactionArguments extends Equatable {
  final bool isNew;
  final bool? isEditProfile;
  final CheckLoactionNavigation checkLoactionNavigator;

  const LoactionArguments({
    required this.isNew,
    required this.checkLoactionNavigator,
    this.isEditProfile,
  });

  @override
  List<Object?> get props => [
        isNew,
        checkLoactionNavigator,
        isEditProfile,
      ];
}
