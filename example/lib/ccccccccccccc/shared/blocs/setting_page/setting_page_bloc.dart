// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:equatable/equatable.dart';

part 'setting_page_event.dart';
part 'setting_page_state.dart';

class SettingPageBloc extends Bloc<SettingPageEvent, SettingPageState> {
  final LoadingCubit loadingCubit;
  // final BussinessCategoryCubit bussinessCategoryCubit;

  SettingPageBloc({
    required this.loadingCubit,
    // required this.bussinessCategoryCubit,
  }) : super(SettingPageInitialState()) {
    on<SettingPageEvent>((event, emit) {});
    on<SettingPageInitialLoadEvent>(settingPageInitialLoadEvent);
  }

  FutureOr<void> settingPageInitialLoadEvent(SettingPageInitialLoadEvent event, Emitter<SettingPageState> emit) {
    loadingCubit.show();
    // bussinessCategoryCubit.loadBussinessCategory();
    loadingCubit.hide();
  }
}
