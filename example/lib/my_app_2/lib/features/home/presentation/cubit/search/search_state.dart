part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitialState extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<TempProductData> searcheditems;
  final bool? issuffixShow;
  final double? random;

  const SearchLoadedState({
    required this.searcheditems,
    this.issuffixShow,
    this.random,
  });

  SearchLoadedState copyWith({
    List<TempProductData>? searcheditems,
    bool? issuffixShow,
    double? random,
  }) {
    return SearchLoadedState(
      searcheditems: searcheditems ?? this.searcheditems,
      issuffixShow: issuffixShow ?? this.issuffixShow,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [searcheditems, issuffixShow, random];
}

final class SearchErrorState extends SearchState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const SearchErrorState({required this.errorMessage, required this.appErrorType});
  @override
  List<Object?> get props => [errorMessage, appErrorType];
}
