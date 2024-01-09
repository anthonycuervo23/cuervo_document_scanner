import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

// ignore: must_be_immutable
class AddressScreenArguments extends Equatable {
  double latitude;
  double longitude;
  String fullAddress;
  String aeriaName;

  AddressScreenArguments({
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.aeriaName,
  });

  AddressScreenArguments copyWith({
    double? latitude,
    double? longitude,
    AutocompletePrediction? prediction,
    String? fullAddress,
    String? aeriaName,
  }) {
    return AddressScreenArguments(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      fullAddress: fullAddress ?? this.fullAddress,
      aeriaName: aeriaName ?? this.aeriaName,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        fullAddress,
        aeriaName,
      ];
}
