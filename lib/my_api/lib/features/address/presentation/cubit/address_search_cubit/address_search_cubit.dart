import 'dart:async';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

part 'address_search_state.dart';

class AddressSearchCubit extends Cubit<AddressSearchState> {
  final LoadingCubit loadingCubit;

  AddressSearchCubit({required this.loadingCubit}) : super(AddressSearchInitial());

  List<AutocompletePrediction> places = [];

  final _places = FlutterGooglePlacesSdk('AIzaSyA6vKEF9G12zSbgsJBcTxUVXvGzlnBnMJ4');

  Future<void> getSearchedPlaces(String search) async {
    emit(AddressSearchLoadingState());
    FindAutocompletePredictionsResponse predictions = await _places.findAutocompletePredictions(search);
    places = predictions.predictions;
    emit(AddressSearchLoadedState(places: places));
  }

  Future<void> applySelectedLocation(int index, {required AddressScreenArguments args}) async {
    FetchPlaceResponse res = await _places.fetchPlace(places[index].placeId, fields: [PlaceField.Location]);
    AutocompletePrediction prediction = places[index];
    LatLng? latLng = res.place?.latLng;
    CommonRouter.pop(
      args: args.copyWith(
        prediction: prediction,
        latitude: latLng?.lat,
        longitude: latLng?.lng,
        aeriaName: prediction.primaryText,
        fullAddress: prediction.fullText,
      ),
    );
  }

  void initialState() {
    emit(AddressSearchInitial());
  }

  Timer? _debounceTimer;
  void search({required String searchString}) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(
      const Duration(seconds: 1),
      () {
        if (searchString.isNotEmpty) {
          getSearchedPlaces(searchString);
        } else {
          initialState();
        }
      },
    );
  }
}
