// ignore_for_file: must_be_immutable

part of 'otp_verification_cubit.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object> get props => [];
}

class OtpLoadTimerState extends OtpVerificationState {
  int secondsRemaining = 10;
  bool enableResend = false;

  OtpLoadTimerState({required this.secondsRemaining, required this.enableResend});

  @override
  List<Object> get props => [secondsRemaining, enableResend];
}
