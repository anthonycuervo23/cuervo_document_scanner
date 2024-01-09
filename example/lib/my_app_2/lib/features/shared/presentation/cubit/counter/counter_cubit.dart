// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  bool isMounted = true;
  CounterCubit() : super(0);

  Timer? timer;

  void startTimer() {
    timer?.cancel();
    timer = null;
    if (!isMounted) return;

    emit(0);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!isMounted) return;
      emit(t.tick);
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    if (!isMounted) return;
    emit(0);
  }

  void reloadState() {
    emit(Random().nextInt(10000));
  }

  void increment() {
    emit(state + 1);
  }

  void chanagePageIndex({required int index}) {
    emit(index);
  }

  void decrement() {
    emit(state - 1);
  }

  void setCounter({required int count}) {
    emit(count);
  }
}
