import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_view_state.dart';

class CustomerViewCubit extends Cubit<CustomerViewState> {
  final CustomerCubit customerCubit;
  CustomerViewCubit({required this.customerCubit})
      : super(const CustomerViewLoadedState(selectedTabBar: 0, orderproductData: [], random: 0, addressList: []));

  void changeTab({required int tabValue}) {
    CustomerViewLoadedState customerViewLoadedState = state as CustomerViewLoadedState;
    emit(customerViewLoadedState.copyWith(selectedTabBar: tabValue));
  }

  void addList({required List<OrderDetailModel> orderList, required List<AddressData> addressList}) {
    CustomerViewLoadedState customerViewLoadedState = state as CustomerViewLoadedState;

    emit(customerViewLoadedState.copyWith(orderproductData: orderList, addressList: addressList));
  }

  void removeOrder({required int index}) {
    CustomerViewLoadedState customerViewLoadedState = state as CustomerViewLoadedState;

    List<OrderDetailModel> orderList = customerViewLoadedState.orderproductData;

    orderList.removeAt(index);

    emit(customerViewLoadedState.copyWith(orderproductData: orderList, random: Random().nextDouble()));
  }

  void removeAddress({required int index}) {
    CustomerViewLoadedState customerViewLoadedState = state as CustomerViewLoadedState;

    List<AddressData> addressList = customerViewLoadedState.addressList;

    addressList.removeAt(index);

    emit(customerViewLoadedState.copyWith(addressList: addressList, random: Random().nextDouble()));
  }

  void deleteCustomer({required CustomerDetailModel customerDetailModel}) {
    customerCubit.deleteCustomer(customerDetailModel: customerDetailModel);
  }

  void updateAddress({required AddressData address, required CustomerViewLoadedState state, required int index}) {
    List<AddressData> allAddressData = [];
    allAddressData.addAll(state.addressList);
    allAddressData[index] = address;
    emit(state.copyWith(addressList: allAddressData, random: Random().nextDouble()));
  }

  void addAddress({
    required AddressData address,
    required CustomerViewLoadedState state,
  }) {
    List<AddressData> allAddressData = [];
    allAddressData.addAll(state.addressList);
    allAddressData.add(address);
    emit(state.copyWith(addressList: allAddressData, random: Random().nextDouble()));
  }
}
