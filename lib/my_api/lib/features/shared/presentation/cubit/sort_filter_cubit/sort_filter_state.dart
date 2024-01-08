part of 'sort_filter_cubit.dart';

sealed class SortFilterState extends Equatable {
  const SortFilterState();

  @override
  List<Object?> get props => [];
}

class SortFilterLoadingState extends SortFilterState {
  @override
  List<Object> get props => [];
}

class SortFilterLoadedState extends SortFilterState {
  final List selectedFilterByName;
  final List selectedFilterByPrice;
  final double? random;

  const SortFilterLoadedState({
    this.random,
    required this.selectedFilterByName,
    required this.selectedFilterByPrice,
  });

  SortFilterLoadedState copyWith({
    List? selectedFilterByName,
    List? selectedFilterByPrice,
    double? random,
  }) {
    return SortFilterLoadedState(
      selectedFilterByName: selectedFilterByName ?? this.selectedFilterByName,
      selectedFilterByPrice: selectedFilterByPrice ?? this.selectedFilterByPrice,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [selectedFilterByName, random, selectedFilterByPrice];
}

class SortFilterErrorState extends SortFilterState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const SortFilterErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}


// sirt filter state