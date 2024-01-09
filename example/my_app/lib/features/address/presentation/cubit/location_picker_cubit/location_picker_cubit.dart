import 'dart:async';

import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_geocoder/location_geocoder.dart';

part 'location_picker_state.dart';

enum CheckLoactionNavigation { cart, addAddress }

class LocationPickerCubit extends Cubit<LocationPickerState> {
  final LoadingCubit loadingCubit;

  LocationPickerCubit({required this.loadingCubit}) : super(LocationPickerInitialState());

  Future<Address?> findAndSetLocation({required double latitude, required double longitude}) async {
    loadingCubit.show();
    final LocatitonGeocoder geocoder = LocatitonGeocoder(appConstants.loctionApiKey);
    final address = await geocoder.findAddressesFromCoordinates(Coordinates(latitude, longitude));
    if (address.isNotEmpty) {
      loadingCubit.hide();
      emit(LocationPickerLoadedState(lat: latitude, long: longitude));
      return address.first;
    }
    loadingCubit.hide();
    return null;
  }

  Future<void> setLocation({required AddressScreenArguments args}) async {
    emit(LocationPickerLoadedState(lat: args.latitude, long: args.longitude));
  }
}
