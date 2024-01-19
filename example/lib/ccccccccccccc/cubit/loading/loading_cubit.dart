// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);
  bool isMounted = true;

  void show() {
    if (!isMounted) return;
    emit(true);
  }

  void hide() {
    if (!isMounted) return;
    emit(false);
  }
}
