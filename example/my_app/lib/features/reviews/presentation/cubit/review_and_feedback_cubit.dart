// ignore: depend_on_referenced_packages
import 'package:bakery_shop_flutter/features/reviews/data/models/review_and_feedback_model.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_state.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewAndFeedbackCubit extends Cubit<ReviewAndFeedbackState> {
  final LoadingCubit loadingCubit;
  ReviewAndFeedbackCubit({required this.loadingCubit}) : super(ReviewAndFeedbackInitialState());

  void loadData() {
    emit(ReviewAndFeedbackLoadingState());
    emit(
      ReviewAndFeedbackLoadedState(
        selectedIndex: 0,
        isSelectPopupMenu: false,
        isSelected: false,
        selectPopupMenuIndex: 0,
        listOfReview: listOfDummyRating,
      ),
    );
  }

  void selectedTapRating({required int index, required ReviewAndFeedbackLoadedState state}) {
    emit(state.copyWith(selectedIndex: index, isSelected: true));
  }

  void selectPopupMenu({required int index, required ReviewAndFeedbackLoadedState state}) {
    emit(state.copyWith(selectPopupMenuIndex: index, isSelectPopupMenu: true));
  }
}
