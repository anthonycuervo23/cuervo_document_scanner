part of 'delivery_time_slot_cubit.dart';

sealed class DeliveryTimeSlotState extends Equatable {
  const DeliveryTimeSlotState();

  @override
  List<Object?> get props => [];
}

final class DeliveryTimeSlotInitial extends DeliveryTimeSlotState {}

class DeliveryTimeSlotLoadingState extends DeliveryTimeSlotState {
  @override
  List<Object> get props => [];
}

class DeliveryTimeSlotLoadedState extends DeliveryTimeSlotState {
  final SelectedTab selectedTab;
  final List<DeliveryTimeSlotModel>? standardTimeList;
  final List<DeliveryTimeSlotModel>? midNightTimeList;
  final List<DeliveryTimeSlotModel>? fixTimeList;
  final bool? isEdited;
  final int? itemIndex;
  final double? random;

  const DeliveryTimeSlotLoadedState({
    required this.selectedTab,
    this.fixTimeList,
    this.midNightTimeList,
    this.standardTimeList,
    this.isEdited,
    this.itemIndex,
    this.random,
  });

  DeliveryTimeSlotLoadedState copyWith({
    SelectedTab? selectedTab,
    double? random,
    bool? isEdited,
    List<DeliveryTimeSlotModel>? standardTimeList,
    List<DeliveryTimeSlotModel>? midNightTimeList,
    List<DeliveryTimeSlotModel>? fixTimeList,
    int? itemIndex,
  }) {
    return DeliveryTimeSlotLoadedState(
      selectedTab: selectedTab ?? this.selectedTab,
      random: random ?? this.random,
      isEdited: isEdited ?? this.isEdited,
      standardTimeList: standardTimeList ?? this.standardTimeList,
      midNightTimeList: midNightTimeList ?? this.midNightTimeList,
      fixTimeList: fixTimeList ?? this.fixTimeList,
      itemIndex: itemIndex ?? this.itemIndex,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        isEdited,
        random,
        standardEasing,
        midNightTimeList,
        fixTimeList,
      ];
}

class DeliveryTimeSlotErrorState extends DeliveryTimeSlotState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const DeliveryTimeSlotErrorState({
    required this.appErrorType,
    required this.errorMessage,
  });
  @override
  List<Object> get props => [
        appErrorType,
        errorMessage,
      ];
}
