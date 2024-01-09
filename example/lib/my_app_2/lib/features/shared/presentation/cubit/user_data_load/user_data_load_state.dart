part of 'user_data_load_cubit.dart';

sealed class GetUserDataState extends Equatable {
  const GetUserDataState();

  @override
  List<Object?> get props => [];
}

final class GerUserDataInitialState extends GetUserDataState {}

class GerUserDataLoadingState extends GetUserDataState {
  const GerUserDataLoadingState();

  @override
  List<Object> get props => [];
}

class GerUserDataLoadedState extends GetUserDataState {
  final UserEntity userDataEntity;
  final double? random;

  GerUserDataLoadedState copyWith({UserEntity? userDataEntity, double? random}) {
    return GerUserDataLoadedState(
      userDataEntity: userDataEntity ?? this.userDataEntity,
      random: random ?? this.random,
    );
  }

  const GerUserDataLoadedState({required this.userDataEntity, this.random});

  @override
  List<Object?> get props => [userDataEntity, random];
}

class UserDataLoadErrorState extends GetUserDataState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const UserDataLoadErrorState({
    required this.appErrorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
