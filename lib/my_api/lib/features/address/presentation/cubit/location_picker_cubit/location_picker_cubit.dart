import 'dart:async';

import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/location_picker_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_picker_state.dart';

enum CheckLoactionNavigation { updateAddress, addAddress }

class LocationPickerCubit extends Cubit<LocationPickerState> {
  final LoadingCubit loadingCubit;
  final CounterCubit counterCubit;
  late AddressScreenArguments args;
  Completer<GoogleMapController> mapController = Completer();

  LocationPickerCubit({required this.loadingCubit, required this.counterCubit}) : super(LocationPickerLoadingState());

  Future<void> initilize({required LocationPickerScreenArguments arguments}) async {
    loadingCubit.show();
    PermissionStatus status = await Permission.location.request();
    Position? position;

    if (status.isGranted) {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
    } else {
      loadingCubit.hide();
      CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: "Location permission Required");
      return;
    }

    if (arguments.navigationFrom == CheckLoactionNavigation.addAddress) {
      args = AddressScreenArguments(
        latitude: position.latitude,
        longitude: position.longitude,
        fullAddress: '',
        aeriaName: '',
      );
    } else {
      Coordinates? coordinates = await getCoordinatesFromAddress(address: arguments.address!);

      args = AddressScreenArguments(
        latitude: coordinates!.latitude!,
        longitude: coordinates.longitude!,
        fullAddress: '',
        aeriaName: '',
      );
    }

    Address? adddress = await findAndSetLocation(args: args);

    if (arguments.navigationFrom == CheckLoactionNavigation.addAddress) {
      args = AddressScreenArguments(
        latitude: position.latitude,
        longitude: position.longitude,
        fullAddress: adddress?.addressLine ?? "Not available",
        aeriaName:
            (adddress?.subLocality?.isNotEmpty ?? false) ? (adddress?.subLocality ?? '') : (adddress?.locality ?? ''),
      );
    } else {
      Coordinates? coordinates = await getCoordinatesFromAddress(address: arguments.address!);

      args = AddressScreenArguments(
        latitude: coordinates!.latitude!,
        longitude: coordinates.longitude!,
        fullAddress: adddress?.addressLine ?? "Not available",
        aeriaName:
            (adddress?.subLocality?.isNotEmpty ?? false) ? (adddress?.subLocality ?? '') : (adddress?.locality ?? ''),
      );
    }

    loadingCubit.hide();
  }

  Future<Address?> findAndSetLocation({required AddressScreenArguments args}) async {
    const apiKey = 'AIzaSyA6vKEF9G12zSbgsJBcTxUVXvGzlnBnMJ4';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
    final address = await geocoder.findAddressesFromCoordinates(Coordinates(args.latitude, args.longitude));
    if (address.isNotEmpty) {
      emit(LocationPickerLoadedState(lat: args.latitude, long: args.longitude));
      return address.first;
    }
    return null;
  }

  Future<Coordinates?> getCoordinatesFromAddress({required String address}) async {
    const apiKey = 'AIzaSyA6vKEF9G12zSbgsJBcTxUVXvGzlnBnMJ4';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
    final coordinates = await geocoder.findAddressesFromQuery(address);
    if (coordinates.isNotEmpty) {
      return coordinates.first.coordinates;
    }
    return null;
  }

  Future<void> animateMap({required double latitude, required double longitude}) async {
    (await mapController.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
      ),
    );
  }

  Future<void> setCurrentLocation({required AddressScreenArguments address}) async {
    loadingCubit.show();
    args = address;
    (await mapController.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(address.latitude, address.longitude), zoom: 16),
      ),
    );
    setLocation(args: args);
    await Future.delayed(const Duration(milliseconds: 700));
    loadingCubit.hide();
  }

  Future<void> setLocation({required AddressScreenArguments args}) async {
    emit(LocationPickerLoadedState(lat: args.latitude, long: args.longitude));
  }
}
