// To parse this JSON data, do
//
//     final manageAddress = manageAddressFromJson(jsonString);

// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class ManageAddressModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final ManageAddressEntity? data;

  ManageAddressModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ManageAddressModel.fromJson(Map<String, dynamic> json) => ManageAddressModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? AddressData.fromJson(json["data"]) : null,
      );
}

class AddressData extends ManageAddressEntity {
  final List<AddressDetailes> addresses;

  const AddressData({
    required this.addresses,
  }) : super(addresses: addresses);

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
        addresses: json["addresses"] == null
            ? []
            : List<AddressDetailes>.from(
                json["addresses"].map(
                  (addressList) => AddressDetailes.fromJson(addressList),
                ),
              ),
      );
}

class AddressDetailes {
  final int id;
  final String name;
  final String countryCode;
  final String mobileNo;
  final AddAddressType addresstype;
  final bool isDefaultAddress;
  final LocationsData address;
  final String fullAddress;

  AddressDetailes({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.mobileNo,
    required this.isDefaultAddress,
    required this.addresstype,
    required this.address,
    required this.fullAddress,
  });

  factory AddressDetailes.fromJson(Map<String, dynamic> json) => AddressDetailes(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"] ?? '',
        countryCode: json["country_code"] ?? '',
        mobileNo: json["mobile_no"] ?? '',
        addresstype: json["address_type"] == 'Home'
            ? AddAddressType.home
            : json["address_type"] == 'Work'
                ? AddAddressType.work
                : json["address_type"] == 'Other'
                    ? AddAddressType.other
                    : AddAddressType.someone_Else,
        isDefaultAddress: int.tryParse(json["is_default_address"].toString()) == 1 ? true : false,
        address: LocationsData.fromJson(json["address"]),
        fullAddress: json["full_address"] ?? '',
      );
}

class LocationsData {
  final String flatNo;
  final String locality;
  final String landmark;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  LocationsData({
    required this.flatNo,
    required this.locality,
    required this.landmark,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory LocationsData.fromJson(Map<String, dynamic> json) => LocationsData(
        flatNo: json["flat_no"] ?? '',
        locality: json["locality"] ?? '',
        landmark: json["landmark"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        country: json["country"] ?? '',
        zipCode: json["zip_code"] ?? '',
      );
}
