// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

class ToggleCubit extends Cubit<bool> {
  ToggleCubit() : super(false);

  void setValue({required bool value}) {
    emit(value);
  }
}
