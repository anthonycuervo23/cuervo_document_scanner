// ignore_for_file: must_be_immutable

part of 'location_picker_cubit.dart';

sealed class LocationPickerState extends Equatable {
  const LocationPickerState();

  @override
  List<Object?> get props => [];
}

final class LocationPickerInitialState extends LocationPickerState {
  @override
  List<Object> get props => [];
}

final class LocationPickerLoadingState extends LocationPickerState {
  @override
  List<Object> get props => [];
}

class LocationPickerLoadedState extends LocationPickerState {
  final double lat, long;

  const LocationPickerLoadedState({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}

class LocationPickerErrorState extends LocationPickerState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const LocationPickerErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
