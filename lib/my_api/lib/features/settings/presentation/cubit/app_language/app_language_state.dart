part of 'app_language_cubit.dart';

sealed class AppLanguageState extends Equatable {
  const AppLanguageState();

  @override
  List<Object> get props => [];
}

final class AppLanguageInitialState extends AppLanguageState {
  const AppLanguageInitialState();

  @override
  List<Object> get props => [];
}

final class AppLanguageLoadingState extends AppLanguageState {
  const AppLanguageLoadingState();

  @override
  List<Object> get props => [];
}

final class AppLanguageLoadedState extends AppLanguageState {
  final List<AppLanguageEntity> appLanguageList;
  const AppLanguageLoadedState({required this.appLanguageList});
  AppLanguageLoadedState copyWith({List<AppLanguageEntity>? appLanguageList}) {
    return AppLanguageLoadedState(
      appLanguageList: appLanguageList ?? this.appLanguageList,
    );
  }

  @override
  List<Object> get props => [appLanguageList];
}

final class AppLanguageErrorState extends AppLanguageState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AppLanguageErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
