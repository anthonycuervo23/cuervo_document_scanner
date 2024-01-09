import 'package:equatable/equatable.dart';

class AddAddressDetailsParams extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final String floatNo;
  final String locality;
  final String? landmark;
  final String cityName;
  final String stateName;
  final String countryName;
  final String countryCode;
  final String pinCode;
  final String addressType;

  const AddAddressDetailsParams({
    required this.id,
    required this.name,
    required this.mobile,
    required this.floatNo,
    required this.locality,
    this.landmark,
    required this.cityName,
    required this.stateName,
    required this.countryName,
    required this.countryCode,
    required this.pinCode,
    required this.addressType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        floatNo,
        locality,
        landmark,
        cityName,
        stateName,
        countryName,
        countryCode,
        pinCode,
        addressType,
      ];
}
