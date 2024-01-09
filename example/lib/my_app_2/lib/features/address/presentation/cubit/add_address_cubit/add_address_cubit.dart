// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/core/build_context.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/manage_address_entity.dart';
import 'package:bakery_shop_flutter/features/address/domain/params/add_address_details_params.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/add_address_detail.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/delete_address_detail.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/manage_address_usecase.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/set_default_address.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'add_address_state.dart';

enum OrderAddressType { home, someoneElse }

enum AddAddressType { home, work, other, someone_Else }

class AddAddressCubit extends Cubit<AddAddressState> {
  final LoadingCubit loadingCubit;
  final LocationPickerCubit locationPickerCubit;
  final GetUserDataCubit getUserDataCubit;
  final CounterCubit counterCubit;
  late AddressScreenArguments args;
  late LoactionArguments loactionArgs;

  final GetManageAddressData getManageAddressData;
  final DeleteAddress deleteAddressDetail;
  final AddAddressDetails addAddressDetails;
  final SetDefaultAddressDetails setDefaultAddressDetails;

  Completer<GoogleMapController> mapController = Completer();

  FlutterContactPicker contactPicker = FlutterContactPicker();

  String cityName = '';
  String stateName = '';
  String countryName = '';
  String fullAddress = '';
  String pinCode = '';

  AddAddressCubit({
    required this.loadingCubit,
    required this.locationPickerCubit,
    required this.counterCubit,
    required this.deleteAddressDetail,
    required this.getManageAddressData,
    required this.addAddressDetails,
    required this.setDefaultAddressDetails,
    required this.getUserDataCubit,
  }) : super(AddAddressInitialState());

  void inilizeAddressField({
    AddAddressType? addAddressType,
    OrderAddressType? orderAddressType,
    ManageAddressEntity? manageAddressEntity,
  }) {
    if (state is AddAddressLoadedState) {
      var loadedState = state as AddAddressLoadedState;
      loadedState.copyWith(
        addAddressType: addAddressType ?? AddAddressType.home,
        orderAddressType: orderAddressType ?? OrderAddressType.home,
      );
    }
  }

  Future<void> initilize() async {
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
      CustomSnackbar.show(
        snackbarType: SnackbarType.ERROR,
        message: TranslationConstants.location_permission_required.translate(buildContext),
      );
      return;
    }

    // args = AddressScreenArguments(
    //   latitude: position.latitude,
    //   longitude: position.longitude,
    //   fullAddress: '',
    //   aeriaName: '',
    //   isNew: false,
    // );

    Address? adddress = await locationPickerCubit.findAndSetLocation(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    animateMap(latitude: position.latitude, longitude: position.longitude);

    args = AddressScreenArguments(
      latitude: position.latitude,
      longitude: position.longitude,
      aeriaName:
          (adddress?.subLocality?.isNotEmpty ?? false) ? (adddress?.subLocality ?? '') : (adddress?.locality ?? ''),
      fullAddress: adddress?.addressLine ?? TranslationConstants.not_available.translate(buildContext),
      isNew: false,
    );
    loadingCubit.hide();
  }

  Future<void> setData({required double latitude, required double longitude}) async {
    final LocatitonGeocoder geocoder = LocatitonGeocoder(appConstants.loctionApiKey);
    final address = await geocoder.findAddressesFromCoordinates(Coordinates(args.latitude, args.longitude));
    cityName = address.first.locality ?? '';
    stateName = address.first.adminArea ?? '';
    countryName = address.first.countryName ?? '';
    pinCode = address.first.postalCode ?? '';
  }

  Future<void> animateMap({required double latitude, required double longitude}) async {
    try {
      // (await mapController.future).animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
      //   ),
      // );
      mapController.future.then(
        (value) => value.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 16),
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> setCurrentLocation({required AddressScreenArguments address}) async {
    loadingCubit.show();

    args = address;

    // (await mapController.future).animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(address.latitude, address.longitude), zoom: 16),
    //   ),
    // );
    mapController.future.then(
      (value) => value.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(address.latitude, address.longitude), 16),
      ),
    );
    locationPickerCubit.setLocation(args: args);

    await Future.delayed(const Duration(milliseconds: 700));
    loadingCubit.hide();
  }

  void changeAddressType({
    required AddAddressLoadedState state,
    AddAddressType? addAddressType,
    OrderAddressType? orderAddressType,
  }) {
    emit(state.copyWith(
      addAddressType: addAddressType,
      orderAddressType: orderAddressType,
      random: Random().nextDouble(),
    ));
  }

  Future<void> loadInitialData({bool isLoadingShow = true}) async {
    if (isLoadingShow) {
      loadingCubit.show();
    } else {
      emit(AddAddressLoadingState());
    }

    Either<AppError, ManageAddressEntity> response = await getManageAddressData(NoParams());

    response.fold(
      (AppError error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          loadingCubit.hide();
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        emit(AddAddressErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (ManageAddressEntity data) {
        loadingCubit.hide();

        if (state is AddAddressLoadedState) {
          var loadedState = state as AddAddressLoadedState;
          emit(loadedState.copyWith(manageAddressEntity: data, random: Random().nextDouble()));
        }
        emit(
          AddAddressLoadedState(
            manageAddressEntity: data,
            addAddressType: AddAddressType.home,
            orderAddressType: OrderAddressType.home,
            random: Random().nextDouble(),
          ),
        );
      },
    );
  }

  void deleteAddressDetails({required int id, required AddAddressLoadedState state}) async {
    loadingCubit.show();
    Either<AppError, PostApiResponse> response = await deleteAddressDetail(id);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        // emit(AddAddressErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          loadInitialData();
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }

  void addAddressDetail({
    int? id,
    required AddAddressLoadedState state,
    required String name,
    required String mobile,
    required String floatNo,
    required String landmark,
    required String addressController,
    required String addressType,
  }) async {
    String address = addressController;

    if (address.contains(countryName)) {
      address = address.replaceAll(countryName, '');
    }
    if (address.contains(pinCode)) {
      address = address.replaceAll(pinCode, '');
    }
    if (address.contains(stateName)) {
      address = address.replaceAll(stateName, '');
    }
    if (address.contains(cityName)) {
      address = address.replaceAll(cityName, '');
    }
    address = address.replaceAll(', ,', '');

    address = address.replaceAll(' ,', '');
    address = address.replaceAll('-', '');
    address = address.trim();

    AddAddressDetailsParams addAddressDetailsParams = AddAddressDetailsParams(
      id: id ?? 0,
      name: name,
      mobile: mobile,
      floatNo: floatNo,
      locality: address,
      landmark: landmark,
      cityName: cityName,
      stateName: stateName,
      countryName: countryName,
      countryCode: userEntity?.countryCode ?? "+91",
      pinCode: pinCode,
      addressType: addressType,
    );

    loadingCubit.show();
    Either<AppError, PostApiResponse> response = await addAddressDetails(addAddressDetailsParams);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          addAddressCubit.loadInitialData();
          CommonRouter.popUntil(
            RouteList.manage_address_screen,
            // arguments: CheckLoactionNavigation.addAddress,
          );
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }

  void setDefaultAddress({required AddAddressLoadedState state, required int id}) async {
    loadingCubit.show();
    Either<AppError, PostApiResponse> response = await setDefaultAddressDetails("$id");
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          loadInitialData();
          getUserDataCubit.loadUserData(loadShow: false);
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }
}
