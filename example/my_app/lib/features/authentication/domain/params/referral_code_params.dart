import 'package:equatable/equatable.dart';

class GetReferralCodeParams extends Equatable {
  final String referrCode;

  const GetReferralCodeParams({
    required this.referrCode,
  });

  @override
  List<Object> get props => [referrCode];
}
