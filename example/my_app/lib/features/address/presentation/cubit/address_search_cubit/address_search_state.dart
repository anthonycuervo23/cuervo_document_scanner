// ignore_for_file: must_be_immutable

part of 'address_search_cubit.dart';

sealed class AddressSearchState extends Equatable {
  const AddressSearchState();

  @override
  List<Object?> get props => [];
}

final class AddressSearchInitialState extends AddressSearchState {
  @override
  List<Object?> get props => [];
}

class AddressSearchLoadingState extends AddressSearchState {
  @override
  List<Object?> get props => [];
}

class AddressSearchLoadedState extends AddressSearchState {
  final List<AutocompletePrediction> places;
  final double? random;

  const AddressSearchLoadedState({required this.places, this.random});

  AddressSearchLoadedState copyWith({List<AutocompletePrediction>? places, double? random}) {
    return AddressSearchLoadedState(places: places ?? this.places, random: random);
  }

  @override
  List<Object?> get props => [places, random];
}

class AddressSearchErrorState extends AddressSearchState {
  AppErrorType appErrorType;
  String errorMessage;

  AddressSearchErrorState({required this.errorMessage, required this.appErrorType});

  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
