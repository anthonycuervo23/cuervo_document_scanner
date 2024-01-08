import 'dart:math';

import 'package:bloc/bloc.dart';

class DropDownCubit extends Cubit<double> {
  DropDownCubit() : super(10);
  List<String> searchList = [];
  void onSearchTextChanged({required String text, required List<String> dataList}) async {
    searchList = dataList;
    searchList = dataList.where((element) => element.toLowerCase().contains(text.toLowerCase())).toList();
    emit(Random().nextDouble());
  }
}
