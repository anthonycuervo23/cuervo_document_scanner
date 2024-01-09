import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  AuthenticationLoadingState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoadedState extends AuthenticationState {
  final GenerateOtpEntity generateOtpEntity;

  AuthenticationLoadedState({required this.generateOtpEntity});
  AuthenticationLoadedState copyWith({GenerateOtpEntity? generateOtpEntity}) {
    return AuthenticationLoadedState(generateOtpEntity: generateOtpEntity ?? this.generateOtpEntity);
  }

  @override
  List<Object> get props => [generateOtpEntity];
}

class AuthenticationErrorState extends AuthenticationState {
  final AppErrorType appErrorType;
  final String errorMessage;

  AuthenticationErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
