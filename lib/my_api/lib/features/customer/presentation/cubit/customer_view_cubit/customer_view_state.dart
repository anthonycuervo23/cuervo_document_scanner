part of 'customer_view_cubit.dart';

abstract class CustomerViewState extends Equatable {
  const CustomerViewState();

  @override
  List<Object> get props => [];
}

class CustomerViewLodingState extends CustomerViewState {
  @override
  List<Object> get props => [];
}

class CustomerViewLoadedState extends CustomerViewState {
  final int selectedTabBar;
  final List<OrderDetailModel> orderproductData;
  final List<AddressData> addressList;
  final double random;  

  CustomerViewLoadedState copyWith(
      {int? selectedTabBar, List<OrderDetailModel>? orderproductData, double? random, List<AddressData>? addressList}) {
    return CustomerViewLoadedState(
      selectedTabBar: selectedTabBar ?? this.selectedTabBar,
      orderproductData: orderproductData ?? this.orderproductData,
      random: random ?? this.random,
      addressList: addressList ?? this.addressList,
    );
  }                                                                                                  

  const CustomerViewLoadedState({
    required this.selectedTabBar,
    required this.orderproductData,
    required this.random,
    required this.addressList,
  });
  @override
  List<Object> get props => [selectedTabBar, orderproductData, addressList, random];
}

class CustomerViewErrorState extends CustomerViewState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const CustomerViewErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
