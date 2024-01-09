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
  final int? selectIndex;
  
  const AppLanguageLoadedState({required this.appLanguageList, this.selectIndex});

  AppLanguageLoadedState copyWith({List<AppLanguageEntity>? appLanguageList, int? selectIndex}) {
    return AppLanguageLoadedState(
      appLanguageList: appLanguageList ?? this.appLanguageList,
      selectIndex: selectIndex ?? this.selectIndex,
    );
  }

  @override
  List<Object> get props => [appLanguageList, selectIndex ?? 1];
}

final class AppLanguageErrorState extends AppLanguageState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AppLanguageErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
