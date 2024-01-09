// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GetLoginParams extends Equatable {
  final String? mobilenumber;
  final String? countryCode;
  final String? email;
  final String? type;
  final String? googleId;

  const GetLoginParams({
    this.mobilenumber,
    this.countryCode,
    this.email,
    this.type,
    this.googleId,
  });

  @override
  List<Object?> get props => [
        mobilenumber,
        countryCode,
        email,
        type,
        googleId,
      ];
}
