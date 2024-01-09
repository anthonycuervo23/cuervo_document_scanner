part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderInitialState extends ReminderState {
  @override
  List<Object> get props => [];
}

class ReminderLoadingState extends ReminderState {
  @override
  List<Object> get props => [];
}

class ReminderLoadedState extends ReminderState {
  final BirthdayReminderEntities? birthdayReminderData;
  final List<BirthdayReminderDataModel>? birthdayDataList;
  final AnniversoryReminderEntities? anniversoryReminderData;
  final List<AnniversoryReminderDataModel>? anniversoryDataList;
  final EventsReminderEntities? eventsReminderData;
  final List<EventsReminderDataModel>? eventsDataList;
  final double? random;

  const ReminderLoadedState({
    this.birthdayReminderData,
    this.birthdayDataList,
    this.anniversoryReminderData,
    this.anniversoryDataList,
    this.eventsReminderData,
    this.eventsDataList,
    this.random,
  });

  ReminderLoadedState copywith({
    BirthdayReminderEntities? birthdayReminderData,
    List<BirthdayReminderDataModel>? birthdayDataList,
    AnniversoryReminderEntities? anniversoryReminderData,
    List<AnniversoryReminderDataModel>? anniversoryDataList,
    EventsReminderEntities? eventsReminderData,
    List<EventsReminderDataModel>? eventsDataList,
    double? random,
  }) {
    return ReminderLoadedState(
      birthdayReminderData: birthdayReminderData ?? this.birthdayReminderData,
      birthdayDataList: birthdayDataList ?? this.birthdayDataList,
      anniversoryReminderData: anniversoryReminderData ?? this.anniversoryReminderData,
      anniversoryDataList: anniversoryDataList ?? this.anniversoryDataList,
      eventsReminderData: eventsReminderData ?? this.eventsReminderData,
      eventsDataList: eventsDataList ?? this.eventsDataList,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        birthdayReminderData,
        birthdayDataList,
        anniversoryReminderData,
        anniversoryDataList,
        eventsReminderData,
        eventsDataList,
        random,
      ];
}

class ReminderErrorState extends ReminderState {
  final AppErrorType appErrorType;
  final String erroMessage;

  const ReminderErrorState({required this.appErrorType, required this.erroMessage});

  @override
  List<Object> get props => [appErrorType, erroMessage];
}
