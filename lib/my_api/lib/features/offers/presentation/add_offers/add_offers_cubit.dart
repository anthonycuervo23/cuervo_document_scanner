import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/add_offers/add_offers_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AddOffersCubit extends Cubit<AddOffersState> {
  AddOffersCubit() : super(const AddOffersLoadedState());

  int selectedDiscountValue = 1;
  TextEditingController offerTitleController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController offerCodeController = TextEditingController();
  TextEditingController offerLimitController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  void loadcontroller({required OfferDetailsModel model}) {
    offerTitleController = TextEditingController(text: model.offerTital);
    shortDescriptionController = TextEditingController(text: model.offerDescripption);
    amountController = TextEditingController(text: model.price);
    offerCodeController = TextEditingController(text: model.cuponText);
    offerLimitController = TextEditingController(text: model.orderLimit);
  }

  void updateDiscountValue({required AddOffersLoadedState state, required int value}) {
    selectedDiscountValue = value;
    emit(state.copyWith(selectedDiscountValue: value));
  }

  void startDatePicker({required List<DateTime?>? date, required AddOffersLoadedState state}) {
    startDateController = TextEditingController(text: "${date?[0]?.day}/${date?[0]?.month}/${date?[0]?.year}");
    emit(state.copyWith(startDate: date![0], random: Random().nextDouble()));
  }

  void endDatePicker({required List<DateTime?>? date, required AddOffersLoadedState state}) {
    endDateController = TextEditingController(text: "${date?[0]?.day}/${date?[0]?.month}/${date?[0]?.year}");
    emit(state.copyWith(endDate: date![0], random: Random().nextDouble()));
  }
}
