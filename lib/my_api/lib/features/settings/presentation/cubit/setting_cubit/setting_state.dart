part of 'setting_cubit.dart';

abstract class SettingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingInitialState extends SettingState {
  @override
  List<Object?> get props => [];
}

class SettingLoadingState extends SettingState {
  @override
  List<Object?> get props => [];
}

class SettingLoadedState extends SettingState {
  SettingLoadedState();

  @override
  List<Object?> get props => [];
}

class SettingErrorState extends SettingState {
  final AppErrorType appErrorType;
  final String errorMessage;

  SettingErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
