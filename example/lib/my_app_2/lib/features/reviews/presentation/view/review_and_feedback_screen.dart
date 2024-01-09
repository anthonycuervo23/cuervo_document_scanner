// ignore_for_file: library_private_types_in_public_api, unrelated_type_equality_checks, prefer_const_constructors

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_state.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/view/review_and_feedback_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewAndFeedbackScreen extends StatefulWidget {
  const ReviewAndFeedbackScreen({super.key});

  @override
  _ReviewAndFeedbackScreenState createState() => _ReviewAndFeedbackScreenState();
}

class _ReviewAndFeedbackScreenState extends ReviewAndFeedbackWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.review_and_feedback.translate(context),
      ),
      body: BlocBuilder<ReviewAndFeedbackCubit, ReviewAndFeedbackState>(
        bloc: reviewAndFeedbackCubit,
        builder: (_, state) {
          if (state is ReviewAndFeedbackLoadedState) {
            return Column(
              children: [
                filterView(context: context, state: state),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: sortedRatingList.length,
                    itemBuilder: (context, index) => commonRatingBox(reviewAndFeedbackModel: sortedRatingList[index]),
                  ),
                ),
              ],
            );
          } else if (state is ReviewAndFeedbackLoadingState) {
            return CommonWidget.loadingIos();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
