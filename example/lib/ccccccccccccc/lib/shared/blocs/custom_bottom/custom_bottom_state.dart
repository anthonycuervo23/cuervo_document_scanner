// ignore_for_file: annotate_overrides, overridden_fields

part of 'custom_bottom_bloc.dart';

abstract class CustomBottomState extends Equatable {
  final int currentIndex;
  const CustomBottomState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class CustomBottomErrorState extends CustomBottomState {
  final int currentIndex;
  const CustomBottomErrorState({required this.currentIndex}) : super(currentIndex: currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class CustomBottomChanged extends CustomBottomState {
  final int currentIndex;
  const CustomBottomChanged({required this.currentIndex}) : super(currentIndex: currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
