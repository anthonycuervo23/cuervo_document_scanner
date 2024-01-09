part of 'add_address_cubit.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();

  @override
  List<Object?> get props => [];
}

final class AddAddressInitialState extends AddAddressState {
  @override
  List<Object> get props => [];
}

final class AddAddressLoadingState extends AddAddressState {
  @override
  List<Object> get props => [];
}

final class AddAddressLoadedState extends AddAddressState {
  final OrderAddressType orderAddressType;
  final AddAddressType addAddressType;
  final ManageAddressEntity? manageAddressEntity;
  final double? random;

  const AddAddressLoadedState({
    required this.addAddressType,
    required this.orderAddressType,
    this.manageAddressEntity,
    this.random,
  });

  AddAddressLoadedState copyWith({
    OrderAddressType? orderAddressType,
    AddAddressType? addAddressType,
    ManageAddressEntity? manageAddressEntity,
    double? random,
  }) {
    return AddAddressLoadedState(
      addAddressType: addAddressType ?? this.addAddressType,
      orderAddressType: orderAddressType ?? this.orderAddressType,
      manageAddressEntity: manageAddressEntity ?? this.manageAddressEntity,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        orderAddressType,
        addAddressType,
        manageAddressEntity,
        random,
      ];
}

final class AddAddressErrorState extends AddAddressState {
  final AppErrorType appErrorType;
  final String errorMessage;
  const AddAddressErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
