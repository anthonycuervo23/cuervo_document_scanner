// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';

class UserModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final UserEntity? data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
      );
}

class UserData extends UserEntity {
  final int id;
  final String name;
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
  const UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.mobile,
    required this.dob,
    required this.anniversaryDate,
    required this.fullAddress,
    required this.address,
    required this.profilePhoto,
    required this.referralCode,
    required this.familtyInfo,
    required this.relationshipOptions,
    required this.familyDetailsShow,
  }) : super(
          id: id,
          name: name,
          email: email,
          countryCode: countryCode,
          mobile: mobile,
          dob: dob,
          anniversaryDate: anniversaryDate,
          fullAddress: fullAddress,
          address: address,
          profilePhoto: profilePhoto,
          referralCode: referralCode,
          familtyInfo: familtyInfo,
          relationshipOptions: relationshipOptions,
          familyDetailsShow: familyDetailsShow,
        );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] ?? 1,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        countryCode: json["country_code"] ?? '',
        mobile: json["mobile"] ?? '',
        dob: json["dob"] ?? '',
        anniversaryDate: json["anniversary_date"] ?? '',
        fullAddress: json["full_address"] ?? '',
        address: AddressData.fromJson(json["address"]),
        profilePhoto: json["profile_photo"] ?? '',
        referralCode: json["referral_code"] ?? '',
        familtyInfo: List<FamiltyInfo>.from(json["familty_info"].map((x) => FamiltyInfo.fromJson(x))),
        relationshipOptions:
            json["relationship_options"] == null ? [] : List<String>.from(json["relationship_options"].map((x) => x)),
        familyDetailsShow:
            List<FamiltyInfo>.from(json["familty_info"].map((x) => FamiltyInfo.fromJson(x))).isEmpty ? false : true,
      );
}

class AddressData {
  String flatNo;
  String locality;
  String landmark;
  String? city;
  String? state;
  String? country;
  String? zipCode;

  AddressData({
    required this.flatNo,
    required this.locality,
    required this.landmark,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
        flatNo: json["flat_no"] ?? '',
        locality: json["locality"] ?? '',
        landmark: json["landmark"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        country: json["country"] ?? '',
        zipCode: json["zip_code"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "flat_no": flatNo.toString(),
        "locality": locality.toString(),
        "landmark": landmark.toString(),
        "city": city.toString(),
        "state": state.toString(),
        "country": country.toString(),
        "zip_code": zipCode.toString(),
      };
}

class FamiltyInfo {
  int? id;
  TextEditingController name;
  TextEditingController relation;
  String dateOfBirth;
  String? anniversaryDate;
  bool? isFamilyDetailsExpand;

  FamiltyInfo({
    this.id,
    required this.name,
    required this.relation,
    required this.dateOfBirth,
    this.anniversaryDate,
    this.isFamilyDetailsExpand,
  });

  factory FamiltyInfo.fromJson(Map<String, dynamic> json) => FamiltyInfo(
        id: json["id"] ?? '',
        name: TextEditingController(text: json["name"] ?? ''),
        relation: TextEditingController(text: json["relation"] ?? ''),
        dateOfBirth: json["date_of_birth"] ?? '',
        anniversaryDate: json["anniversary_date"] ?? '',
        isFamilyDetailsExpand: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name.text.toString(),
        "relation": relation.text.toString(),
        "date_of_birth": dateOfBirth.toString(),
        "anniversary_date": anniversaryDate.toString(),
      };

  FamiltyInfo copyWith({
    int? id,
    TextEditingController? name,
    TextEditingController? relation,
    String? dateOfBirth,
    String? anniversaryDate,
    bool? isFamilyDetailsExpand = false,
  }) {
    return FamiltyInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      relation: relation ?? this.relation,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      anniversaryDate: anniversaryDate ?? this.anniversaryDate,
      isFamilyDetailsExpand: isFamilyDetailsExpand ?? this.isFamilyDetailsExpand,
    );
  }
}
