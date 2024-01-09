part of 'marketing_cubit.dart';

abstract class MarketingState extends Equatable {
  const MarketingState();

  @override
  List<Object?> get props => [];
}

class MarketingLoadingState extends MarketingState {
  @override
  List<Object> get props => [];
}

class MarketingLoadedState extends MarketingState {
  final SelectedTab selectedTab;
  final List<MarketingDataModel> marketingData;
  final List<MarketingDataModel>? filteredAndSearchedData;
  final double? random;
  final bool displayFilter;

  const MarketingLoadedState({
    required this.selectedTab,
    required this.marketingData,
    this.random,
    this.filteredAndSearchedData,
    required this.displayFilter,
  });

  MarketingLoadedState copyWith({
    SelectedTab? selectedTab,
    List<MarketingDataModel>? marketingData,
    double? random,
    List<MarketingDataModel>? filteredAndSearchedData,
    bool? displayFilter,
  }) {
    return MarketingLoadedState(
      selectedTab: selectedTab ?? this.selectedTab,
      marketingData: marketingData ?? this.marketingData,
      random: random ?? this.random,
      filteredAndSearchedData: filteredAndSearchedData ?? this.filteredAndSearchedData,
      displayFilter: displayFilter ?? this.displayFilter,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        marketingData,
        random,
        filteredAndSearchedData,
        displayFilter,
      ];
}

class MarketingErrorState extends MarketingState {
  final ErrorType errorType;
  final String errormessage;

  const MarketingErrorState({required this.errorType, required this.errormessage});
  @override
  List<Object> get props => [
        errorType,
        errormessage,
      ];
}
