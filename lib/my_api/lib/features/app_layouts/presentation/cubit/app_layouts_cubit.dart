import 'dart:math';
import 'dart:ui';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_layouts_state.dart';

class AppLayoutsCubit extends Cubit<AppLayoutsState> {
  PickImageCubit pickImageCubitCubit;
  CounterCubit counterCubit;

  AppLayoutsCubit({required this.pickImageCubitCubit, required this.counterCubit}) : super(AppLayoutsLoadingState());

  Future<void> uploadLogo({required AppLayoutsLoadedState state}) async {
    await pickImageCubitCubit.pickImage(pickType: "gallery");
    emit(state.copyWth(random: Random().nextDouble()));
  }

  void initialDataLoad() {
    Color primaryColor = const Color(0xFF00B1B6);
    String primaryColorText = "#00B1B6FF";
    String secondoryColorText = "#E7C49BFF";
    String defualtColorText = "#373A3AFF";

    Color secendoryColor = const Color(0xFFE7C49B);
    Color defualtColor = const Color(0xFF373A3A);

    emit(
      AppLayoutsLoadedState(
        defualtColor: defualtColor,
        defualtColorText: defualtColorText,
        primaryColor: primaryColor,
        primaryColorText: primaryColorText,
        secendoryColor: secendoryColor,
        secondoryColorText: secondoryColorText,
        buttonStyleCheckBox: true,
      ),
    );
  }

  void onCheckBoxChange({
    required bool value,
    required AppLayoutsLoadedState state,
  }) {
    emit(state.copyWth(buttonStyleCheckBox: value));
  }

  String convertColorString({required Color color}) {
    return '#${color.red.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.green.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.blue.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.alpha.toRadixString(16).toUpperCase().padLeft(2, '0')}';
  }

  void onApplyClicked({required AppLayoutsLoadedState state, required int index, Color? colors}) {
    Color pickedColor = colors!;
    String newColorText = convertColorString(color: pickedColor);

    if (index == 0) {
      emit(
        state.copyWth(
          primaryColor: pickedColor,
          primaryColorText: newColorText,
          random: Random().nextDouble(),
        ),
      );
    } else if (index == 1) {
      emit(
        state.copyWth(
          secendoryColor: pickedColor,
          secondoryColorText: newColorText,
          random: Random().nextDouble(),
        ),
      );
    } else if (index == 2) {
      emit(
        state.copyWth(
          defualtColor: pickedColor,
          defualtColorText: newColorText,
          random: Random().nextDouble(),
        ),
      );
    }
  }
}
