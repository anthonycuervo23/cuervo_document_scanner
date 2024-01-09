part of 'offers_cubit.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object?> get props => [];
}

class OffersInitialState extends OffersState {}

class OffersLoadingState extends OffersState {
  @override
  List<Object?> get props => [];
}

class OffersLoadedState extends OffersState {
  final List<OfferDetailsModel> searcheditems;
  final double? random;
  const OffersLoadedState({this.random, required this.searcheditems});
  OffersLoadedState copywWith({double? random, List<OfferDetailsModel>? searcheditems}) {
    return OffersLoadedState(
      searcheditems: searcheditems ?? this.searcheditems,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [random, searcheditems];
}

class OffersErrorState extends OffersState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const OffersErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [];
}
