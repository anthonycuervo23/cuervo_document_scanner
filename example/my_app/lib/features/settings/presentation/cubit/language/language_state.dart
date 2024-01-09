part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitialState extends LanguageState {
  final int index;

  const LanguageInitialState({required this.index});

  LanguageInitialState copyWith({int? index}) {
    return LanguageInitialState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}

class LanguageLoadedState extends LanguageState {
  final Locale locale;

  const LanguageLoadedState(this.locale);

  @override
  List<Object> get props => [locale.languageCode];
}

class LanguageErrorState extends LanguageState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const LanguageErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
