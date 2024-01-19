// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'custom_bottom_event.dart';
part 'custom_bottom_state.dart';

class CustomBottomBloc extends Bloc<CustomBottomEvent, CustomBottomState> {
  List loadCustomBottomIndex = [];

  CustomBottomBloc() : super(const CustomBottomChanged(currentIndex: 0)) {
    on<CustomBottomChangeEvent>(customBottomChange);
  }

  Future<void> customBottomChange(CustomBottomChangeEvent event, Emitter<CustomBottomState> emit) async {
    loadCustomBottomIndex.add(event.currentIndex);
    emit(CustomBottomChanged(currentIndex: event.currentIndex));
  }
}
