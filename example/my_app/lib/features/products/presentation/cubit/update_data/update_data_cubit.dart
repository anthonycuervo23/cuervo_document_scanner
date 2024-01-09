import 'dart:math';

import 'package:bloc/bloc.dart';

class UpdateDataCubit extends Cubit<double> {
  UpdateDataCubit() : super(0);

  void update() {
    emit(Random().nextDouble());
  }
}
