// ignore_for_file: must_be_immutable

part of 'upcoming_events_cubit.dart';

abstract class UpcomingEventsState extends Equatable {
  const UpcomingEventsState();

  @override
  List<Object?> get props => [];
}

class UpcomingEventsLoadingState extends UpcomingEventsState {
  @override
  List<Object> get props => [];
}

class UpcomingEventsLoadedState extends UpcomingEventsState {
  final List<UpcomingEventsModel> listOfEvents;
  final List<UpcomingEventsModel>? filterList;
  double? random;

  UpcomingEventsLoadedState({
    required this.listOfEvents,
    this.filterList,
    this.random,
  });

  UpcomingEventsLoadedState copyWith({
    List<UpcomingEventsModel>? listOfEvents,
    List<UpcomingEventsModel>? filterList,
    double? random,
  }) {
    return UpcomingEventsLoadedState(
      filterList: filterList ?? this.filterList,
      listOfEvents: listOfEvents ?? this.listOfEvents,
      random: random,
    );
  }

  @override
  List<Object?> get props => [listOfEvents, random];
}

class UpcomingEventsErrorState extends UpcomingEventsState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const UpcomingEventsErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
