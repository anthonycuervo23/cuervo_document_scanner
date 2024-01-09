import 'package:equatable/equatable.dart';

enum LogintType { phone, email }

class UpdateLoginDetailsParams extends Equatable {
  final LogintType loginType;
  final String countryCode;
  final String mobileNumber;
  final String email;
  final String? otp;

  const UpdateLoginDetailsParams({
    required this.loginType,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
    this.otp,
  });

  @override
  List<Object?> get props => [
        loginType,
        countryCode,
        mobileNumber,
        email,
        otp,
      ];
}
