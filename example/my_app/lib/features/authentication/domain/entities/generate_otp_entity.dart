import 'package:equatable/equatable.dart';

class GenerateOtpEntity extends Equatable {
  final String? otp;
  final bool isUserNew;
  final String? token;

  const GenerateOtpEntity({
    this.otp,
    required this.isUserNew,
    this.token,
  });

  @override
  List<Object?> get props => [
        otp,
        isUserNew,
        token,
      ];
}
