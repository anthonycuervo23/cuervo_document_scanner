import 'dart:async';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:location_geocoder/location_geocoder.dart';

part 'address_search_state.dart';

class AddressSearchCubit extends Cubit<AddressSearchState> {
  final LoadingCubit loadingCubit;
  List<AutocompletePrediction> places = [];
  final _places = FlutterGooglePlacesSdk(appConstants.loctionApiKey);
  Timer? _debounceTimer;
  AddressSearchCubit({required this.loadingCubit}) : super(AddressSearchInitialState());

  Future<void> searchingPlaces(String search) async {
    try {
      FindAutocompletePredictionsResponse predictions = await _places.findAutocompletePredictions(search);
      places = predictions.predictions;
      emit(AddressSearchLoadedState(places: places));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> applySelectedLocation(int index, {required AddressScreenArguments args}) async {
    try {
      FetchPlaceResponse res = await _places.fetchPlace(places[index].placeId, fields: [PlaceField.Location]);
      AutocompletePrediction prediction = places[index];
      LatLng? latLng = res.place?.latLng;
      final LocatitonGeocoder geocoder = LocatitonGeocoder(appConstants.loctionApiKey);
      final address = await geocoder.findAddressesFromCoordinates(Coordinates(args.latitude, args.longitude));
      CommonRouter.pop(
        args: args.copyWith(
          prediction: prediction,
          latitude: latLng?.lat,
          longitude: latLng?.lng,
          aeriaName: prediction.primaryText,
          fullAddress: prediction.fullText,
          countryName: address.first.countryName,
          cityName: address.first.locality,
          pinCode: address.first.postalCode,
          stateName: address.first.adminArea,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void checkOnChanged({required String searchString}) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(
      const Duration(seconds: 1),
      () {
        if (searchString.isNotEmpty) {
          searchingPlaces(searchString);
        }
      },
    );
  }
}
