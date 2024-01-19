// ignore_for_file: annotate_overrides

part of 'app_language_cubit.dart';

abstract class AppLanguageState extends Equatable {
  const AppLanguageState();

  @override
  List<Object> get props => [];

  get appLanguageList => null;
}

class AppLanguageInitial extends AppLanguageState {}

class AppLanguageLoadingState extends AppLanguageState {}

class AppLanguageLoadedState extends AppLanguageState {
  final List<AppLanguageListModel> appLanguageList;
  final List<AppLanguageListModel> origionalLanguageList;

  const AppLanguageLoadedState({required this.appLanguageList, required this.origionalLanguageList});

  @override
  List<Object> get props => [appLanguageList];
}

class AppLanguageErrorState extends AppLanguageState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AppLanguageErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
