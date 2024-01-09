// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

abstract class ReviewAndFeedbackState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewAndFeedbackInitialState extends ReviewAndFeedbackState {
  @override
  List<Object> get props => [];
}

class ReviewAndFeedbackLoadingState extends ReviewAndFeedbackState {
  @override
  List<Object> get props => [];
}

class ReviewAndFeedbackLoadedState extends ReviewAndFeedbackState {
  final int selectedIndex;
  final bool isSelected;
  final bool isSelectPopupMenu;
  final int selectPopupMenuIndex;
  final List listOfReview;

  ReviewAndFeedbackLoadedState({
    required this.selectedIndex,
    required this.isSelected,
    required this.isSelectPopupMenu,
    required this.selectPopupMenuIndex,
    required this.listOfReview,
  });

  ReviewAndFeedbackState copyWith({
    int? selectedIndex,
    bool? isSelected,
    bool? isSelectPopupMenu,
    int? selectPopupMenuIndex,
    List? listOfReview,
  }) {
    return ReviewAndFeedbackLoadedState(
      listOfReview: listOfReview ?? this.listOfReview,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isSelected: isSelected ?? this.isSelected,
      isSelectPopupMenu: isSelectPopupMenu ?? this.isSelectPopupMenu,
      selectPopupMenuIndex: selectPopupMenuIndex ?? this.selectPopupMenuIndex,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        isSelected,
        isSelectPopupMenu,
        selectPopupMenuIndex,
      ];
}

class ReviewAndFeedbackErrorState extends ReviewAndFeedbackState {
  @override
  List<Object?> get props => [];
}
