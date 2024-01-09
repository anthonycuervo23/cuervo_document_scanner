import 'package:equatable/equatable.dart';

class VerifyOtpEntity extends Equatable {
  final String? token;

  const VerifyOtpEntity({
    this.token,
  });
  @override
  List<Object?> get props => [token];
}
