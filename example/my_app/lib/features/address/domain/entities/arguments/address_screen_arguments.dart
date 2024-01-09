// ignore_for_file: must_be_immutable

import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

class AddressScreenArguments extends Equatable {
  final int? id;
  final double latitude;
  final double longitude;
  final AutocompletePrediction? prediction;
  String fullAddress;
  String aeriaName;
  final String? cityName;
  final String? stateName;
  final String? countryName;
  final String? pinCode;
  final String? floatNo;
  final String? landmark;
  final String? addresstype;
  final String? name;
  final String? mobile;
  final bool isNew;

  AddressScreenArguments({
    this.id,
    this.name,
    this.mobile,
    this.prediction,
    this.cityName,
    this.stateName,
    this.countryName,
    this.pinCode,
    this.floatNo,
    this.landmark,
    this.addresstype,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.aeriaName,
    required this.isNew,
  });

  AddressScreenArguments copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? name,
    String? mobile,
    String? fullAddress,
    String? aeriaName,
    String? cityName,
    String? stateName,
    String? countryName,
    String? pinCode,
    String? floatNo,
    String? landmark,
    String? addresstype,
    AddAddressCubit? addAddressCubit,
    AutocompletePrediction? prediction,
    bool? isNew,
  }) {
    return AddressScreenArguments(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      prediction: prediction ?? this.prediction,
      fullAddress: fullAddress ?? this.fullAddress,
      aeriaName: aeriaName ?? this.aeriaName,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      countryName: countryName ?? this.countryName,
      pinCode: pinCode ?? this.pinCode,
      floatNo: floatNo ?? this.floatNo,
      landmark: landmark ?? this.landmark,
      addresstype: addresstype ?? this.addresstype,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      isNew: isNew ?? this.isNew,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        latitude,
        longitude,
        prediction,
        fullAddress,
        aeriaName,
        cityName,
        stateName,
        countryName,
        pinCode,
        floatNo,
        landmark,
        addresstype,
        isNew,
      ];
}
