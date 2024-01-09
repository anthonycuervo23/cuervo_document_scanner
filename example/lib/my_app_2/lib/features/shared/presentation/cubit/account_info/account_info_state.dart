part of 'account_info_cubit.dart';

sealed class AccountInfoState extends Equatable {
  const AccountInfoState();

  @override
  List<Object> get props => [];
}

final class AccountInfoInitialState extends AccountInfoState {
  const AccountInfoInitialState();

  @override
  List<Object> get props => [];
}

class AccountInfoLoadingState extends AccountInfoState {
  const AccountInfoLoadingState();

  @override
  List<Object> get props => [];
}

class AccountInfoLoadedState extends AccountInfoState {
  final AccountInfoEntity accountInfoEntity;

  AccountInfoLoadedState copyWith({AccountInfoEntity? accountInfoEntity}) {
    return AccountInfoLoadedState(
      accountInfoEntity: accountInfoEntity ?? this.accountInfoEntity,
    );
  }

  const AccountInfoLoadedState({required this.accountInfoEntity});

  @override
  List<Object> get props => [accountInfoEntity];
}

class AccountInfoErrorState extends AccountInfoState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AccountInfoErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
