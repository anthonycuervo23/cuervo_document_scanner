part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class AuthanticationLoadingState extends AuthenticationState {
  const AuthanticationLoadingState();

  @override
  List<Object> get props => [];
}

class AuthGenerateOtpLoadedState extends AuthenticationState {
  final LoginEntity loginEntity;

  AuthGenerateOtpLoadedState copyWith({LoginEntity? loginEntity}) {
    return AuthGenerateOtpLoadedState(
      loginEntity: loginEntity ?? this.loginEntity,
    );
  }

  const AuthGenerateOtpLoadedState({
    required this.loginEntity,
  });

  @override
  List<Object> get props => [loginEntity];
}
class AuthGererateOtpErrorState extends AuthenticationState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AuthGererateOtpErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
