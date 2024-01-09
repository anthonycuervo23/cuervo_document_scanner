// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class OrderHistoryState extends Equatable {
  final int selectedIndex;

  OrderHistoryState({
    required this.selectedIndex,
  });

  @override
  List<Object?> get props => [selectedIndex];
}

class OrderHistoryInitialState extends OrderHistoryState {
  OrderHistoryInitialState(int selectedIndex, bool isSelected) : super(selectedIndex: selectedIndex);
}
