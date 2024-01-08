// ignore_for_file: must_be_immutable

part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoadedState extends ChangePasswordState {
  bool? isVisibleCurruntPassword;
  bool? isVisibleNewPassword;
  bool? isVisibleConfirmPassword;
  double? random;

  ChangePasswordLoadedState({
    this.isVisibleCurruntPassword,
    this.isVisibleNewPassword,
    this.isVisibleConfirmPassword,
    this.random,
  });

  ChangePasswordLoadedState copyWith({
    bool? isVisibleCurruntPassword,
    bool? isVisibleNewPassword,
    bool? isVisibleConfirmPassword,
    double? random,
  }) {
    return ChangePasswordLoadedState(
      isVisibleCurruntPassword: isVisibleCurruntPassword ?? this.isVisibleCurruntPassword,
      isVisibleConfirmPassword: isVisibleConfirmPassword ?? this.isVisibleConfirmPassword,
      isVisibleNewPassword: isVisibleNewPassword ?? this.isVisibleNewPassword,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [isVisibleCurruntPassword, isVisibleConfirmPassword, isVisibleNewPassword, random];
}

class ChangePasswordErrorState extends ChangePasswordState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ChangePasswordErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
