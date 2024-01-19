part of 'custom_bottom_bloc.dart';

abstract class CustomBottomEvent extends Equatable {
  const CustomBottomEvent();
}

class CustomBottomChangeEvent extends CustomBottomEvent {
  final int currentIndex;
  const CustomBottomChangeEvent({required this.currentIndex});
  @override
  List<Object> get props => [currentIndex];
}
