part of 'my_profile_cubit.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitialState extends MyProfileState {
  const MyProfileInitialState();

  @override
  List<Object> get props => [];
}

class MyProfileLoadingState extends MyProfileState {
  const MyProfileLoadingState();

  @override
  List<Object> get props => [];
}

class MyProfileLoadedState extends MyProfileState {
  final UserEntity userDataEntity;

  MyProfileLoadedState copyWith({
    UserEntity? userDataEntity,
  }) {
    return MyProfileLoadedState(
      userDataEntity: userDataEntity ?? this.userDataEntity,
    );
  }

  const MyProfileLoadedState({required this.userDataEntity});

  @override
  List<Object> get props => [];
}

class MyProfileErrorState extends MyProfileState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const MyProfileErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
