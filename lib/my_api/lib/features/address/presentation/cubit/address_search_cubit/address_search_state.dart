// ignore_for_file: must_be_immutable

part of 'address_search_cubit.dart';

sealed class AddressSearchState extends Equatable {
  const AddressSearchState();

  @override
  List<Object> get props => [];
}

final class AddressSearchInitial extends AddressSearchState {
  @override
  List<Object> get props => [];
}

class AddressSearchLoadingState extends AddressSearchState {
  @override
  List<Object> get props => [];
}

class AddressSearchLoadedState extends AddressSearchState {
  late List<AutocompletePrediction> places;
  AddressSearchLoadedState({required this.places});
  @override
  List<Object> get props => [places];
}

class AddressSearchErrorState extends AddressSearchState {
  AppErrorType appErrorType;
  String errorMessage;

  AddressSearchErrorState({required this.errorMessage, required this.appErrorType});

  @override
  List<Object> get props => [];
}
