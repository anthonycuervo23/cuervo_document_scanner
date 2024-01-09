import 'package:equatable/equatable.dart';

class GetVerifyOtpParams extends Equatable {
  final String mobilenumber;
  final String otp;

  const GetVerifyOtpParams({
    required this.mobilenumber,
    required this.otp,
  });

  @override
  List<Object> get props => [mobilenumber, otp];
}
