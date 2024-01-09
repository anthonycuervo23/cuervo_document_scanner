import 'package:equatable/equatable.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';

class UpdateUserDetailParams extends Equatable {
  final String name;
  final String countryCode;
  final String dob;
  final String anniversaryDate;
  final AddressData address;
  final String profilePhoto;
  final List<FamiltyInfo> familtyInfo;

  const UpdateUserDetailParams({
    required this.name,
    required this.countryCode,
    required this.dob,
    required this.anniversaryDate,
    required this.address,
    required this.profilePhoto,
    required this.familtyInfo,
  });

  @override
  List<Object?> get props => [
        name,
        countryCode,
        dob,
        anniversaryDate,
        address,
        profilePhoto,
        familtyInfo,
      ];
}
