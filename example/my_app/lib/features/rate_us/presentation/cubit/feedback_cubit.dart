import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackCubit extends Cubit<double> {
  final LoadingCubit loadingCubit;
  final ToggleCubit toggleCubit;
  FeedbackCubit({required this.loadingCubit, required this.toggleCubit}) : super(1);

  TextEditingController feedbackController = TextEditingController();
  double currentSliderValue = 1;
  bool isSwitchOn = true;

  void changeSliderValue({required double value}) {
    currentSliderValue = value;
    emit(value);
  }
}
