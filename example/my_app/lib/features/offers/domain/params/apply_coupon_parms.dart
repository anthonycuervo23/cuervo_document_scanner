import 'package:equatable/equatable.dart';

class ApplyCouponParms extends Equatable {
  final String couponCode;
  const ApplyCouponParms({required this.couponCode});
  @override
  List<Object?> get props => [couponCode];
}
