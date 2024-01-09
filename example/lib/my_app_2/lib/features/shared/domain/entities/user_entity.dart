// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';

class UserEntity extends Equatable {
  final int id;
  final String? name;
  final String email;
  final String countryCode;
  final String mobile;
  final String dob;
  final String anniversaryDate;
  final String fullAddress;
  final AddressData address;
  final String profilePhoto;
  final String referralCode;
  final List<FamiltyInfo> familtyInfo;
  final List<String> relationshipOptions;
  final bool familyDetailsShow;

  const UserEntity({
    required this.id,
    this.name,
    required this.email,
    required this.countryCode,
    required this.mobile,
    required this.dob,
    required this.anniversaryDate,
    required this.address,
    required this.fullAddress,
    required this.profilePhoto,
    required this.referralCode,
    required this.familtyInfo,
    required this.relationshipOptions,
    required this.familyDetailsShow, 
  });
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        countryCode,
        mobile,
        dob,
        anniversaryDate,
        address,
        fullAddress,
        profilePhoto,
        referralCode,
        familtyInfo,
        relationshipOptions,
        familyDetailsShow, 
      ];

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? countryCode,
    String? mobile,
    String? dob,
    String? anniversaryDate,
    String? fullAddress,
    AddressData? address,
    String? profilePhoto,
    String? referralCode,
    List<FamiltyInfo>? familtyInfo,
    List<String>? relationshipOptions,
    bool? familyDetailsShow,
    bool? isFamilyDetailsExpand,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      anniversaryDate: anniversaryDate ?? this.anniversaryDate,
      fullAddress: fullAddress ?? this.fullAddress,
      address: address ?? this.address,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      referralCode: referralCode ?? this.referralCode,
      familtyInfo: familtyInfo ?? this.familtyInfo,
      relationshipOptions: relationshipOptions ?? this.relationshipOptions,
      familyDetailsShow: familyDetailsShow ?? this.familyDetailsShow, 
    );
  }
}
