import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitialState());
  List<OfferDetailsModel> templist = [];
  void loaded() {
    emit(OffersLoadedState(searcheditems: offerData));
  }

  void deleteOffersDetaile({required int index, required OffersLoadedState state}) {
    List<OfferDetailsModel> data = state.searcheditems;

    data.removeAt(index);
    emit(state.copywWith(random: Random().nextDouble(), searcheditems: data));
  }

  void filterForSearch({required OffersLoadedState state, required String value}) {
    List<OfferDetailsModel> l1 =
        offerData.where((element) => element.offerTital.toLowerCase().contains(value.toLowerCase())).toList();
    emit(state.copywWith(searcheditems: l1, random: Random().nextDouble()));
  }
}
