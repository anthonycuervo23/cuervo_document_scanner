// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/reviews/data/models/review_and_feedback_model.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_state.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/view/review_and_feedback_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ReviewAndFeedbackWidget extends State<ReviewAndFeedbackScreen> {
  late ReviewAndFeedbackCubit reviewAndFeedbackCubit;
  List<ReviewAndFeedbackModel> sortedRatingList = [];

  @override
  void initState() {
    super.initState();
    reviewAndFeedbackCubit = getItInstance<ReviewAndFeedbackCubit>();
    reviewAndFeedbackCubit.loadData();
    sortedRatingList = List.from(listOfDummyRating);
  }

  @override
  void deactivate() {
    reviewAndFeedbackCubit.loadingCubit.hide();
    reviewAndFeedbackCubit.close();
    super.deactivate();
  }

  Widget filterView({required BuildContext context, required ReviewAndFeedbackLoadedState state}) {
    return Row(
      children: [
        commonButton(
          state: state,
          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
          buttonText: TranslationConstants.all.translate(context),
          onTap: () {
            reviewAndFeedbackCubit.selectedTapRating(index: 0, state: state);
            sortedRatingList = List.from(listOfDummyRating);
          },
          index: 0,
        ),
        commonButton(
          state: state,
          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
          buttonText: TranslationConstants.rating.translate(context),
          onTap: () {
            reviewAndFeedbackCubit.selectedTapRating(index: 1, state: state);
            sortedRatingList.sort(
              (a, b) => b.rating.compareTo(a.rating),
            );
          },
          index: 1,
        ),
        commonButton(
          state: state,
          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
          buttonText: TranslationConstants.order_review.translate(context),
          onTap: () {
            reviewAndFeedbackCubit.selectedTapRating(index: 2, state: state);
          },
          index: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
          child: Container(
            padding: EdgeInsets.only(top: 10.h),
            height: 40.h,
            child: VerticalDivider(
              color: appConstants.default6Color,
              width: 1.w,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: appConstants.default2Color,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    contentPadding: EdgeInsets.all(10.r),
                    backgroundColor: appConstants.whiteBackgroundColor,
                    surfaceTintColor: appConstants.whiteBackgroundColor,
                    shadowColor: appConstants.default4Color,
                    alignment: Alignment.topRight,
                    insetPadding: EdgeInsets.only(right: 15.w, left: 215.w, top: 120.h),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        reviewAndFeedbackPopup(
                          state: state,
                          buttonText: TranslationConstants.newest_first.translate(context),
                          context: context,
                          index: 0,
                          onTap: () {
                            reviewAndFeedbackCubit.selectPopupMenu(index: 0, state: state);
                            CommonRouter.pop();
                          },
                          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
                        ),
                        Divider(),
                        reviewAndFeedbackPopup(
                          state: state,
                          buttonText: TranslationConstants.oldest_first.translate(context),
                          context: context,
                          index: 1,
                          onTap: () {
                            reviewAndFeedbackCubit.selectPopupMenu(index: 1, state: state);
                            CommonRouter.pop();
                          },
                          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
                        ),
                        Divider(),
                        reviewAndFeedbackPopup(
                          state: state,
                          buttonText: TranslationConstants.highest_rate.translate(context),
                          context: context,
                          index: 2,
                          onTap: () {
                            reviewAndFeedbackCubit.selectPopupMenu(index: 2, state: state);
                            CommonRouter.pop();
                          },
                          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
                        ),
                        Divider(),
                        reviewAndFeedbackPopup(
                          state: state,
                          buttonText: TranslationConstants.lowest_rate.translate(context),
                          context: context,
                          index: 3,
                          onTap: () {
                            reviewAndFeedbackCubit.selectPopupMenu(index: 3, state: state);
                            CommonRouter.pop();
                          },
                          reviewAndFeedbackCubit: reviewAndFeedbackCubit,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 43.h,
              width: 40.h,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(shape: BoxShape.circle, color: appConstants.primary1Color),
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/review_and_feedback_screen/alternet.svg",
                color: appConstants.buttonTextColor,
                height: 2.h,
                width: 3.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget commonButton({
    required ReviewAndFeedbackCubit reviewAndFeedbackCubit,
    required ReviewAndFeedbackLoadedState state,
    required String buttonText,
    required VoidCallback onTap,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 14.4.w, top: 10.h),
      child: MaterialButton(
        padding: EdgeInsets.only(
          left: ScreenUtil().screenWidth * 0.04,
          right: ScreenUtil().screenWidth * 0.04,
        ),
        color: state.isSelected == index ? appConstants.secondary2Color : appConstants.textFiledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: state.isSelected == index ? appConstants.primary1Color : appConstants.default5Color,
          ),
        ),
        minWidth: ScreenUtil().screenWidth * 0.15,
        elevation: 0,
        onPressed: onTap,
        child: CommonWidget.commonText(
          text: buttonText,
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
        ),
      ),
    );
  }

  Widget commonRatingBox({required ReviewAndFeedbackModel reviewAndFeedbackModel}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: CommonWidget.container(
        borderRadius: appConstants.prductCardRadius,
        color: appConstants.whiteBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
              child: Container(
                height: 50.h,
                width: 45.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CommonWidget.imageBuilder(
                  height: 50.h,
                  width: 45.w,
                  imageUrl: reviewAndFeedbackModel.image.isNotEmpty
                      ? reviewAndFeedbackModel.image
                      : "assets/photos/png/review_and_feedback_screen/emptyprofile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonWidget.commonText(
                          text: reviewAndFeedbackModel.name,
                          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                        CommonWidget.container(
                          child: Row(
                            children: [
                              CommonWidget.imageBuilder(
                                imageUrl: "assets/photos/svg/review_and_feedback_screen/view.svg",
                                height: 10.h,
                                width: 10.w,
                              ),
                              CommonWidget.sizedBox(width: 5),
                              CommonWidget.commonText(
                                text: "${reviewAndFeedbackModel.views} Views",
                                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                      color: appConstants.default4Color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      children: [
                        ratingBarStar(reviewAndFeedbackModel.rating),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: "${reviewAndFeedbackModel.viewTime} hour ago",
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.default4Color,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, right: 20),
                    child: CommonWidget.commonText(
                      text: reviewAndFeedbackModel.viewDetails,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .captionBookHeading
                          .copyWith(color: appConstants.default3Color, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/review_and_feedback_screen/like.svg",
                          height: 16.h,
                          width: 15.w,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: "Like ${reviewAndFeedbackModel.like}",
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.default4Color,
                              ),
                        ),
                        CommonWidget.sizedBox(width: 15),
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/review_and_feedback_screen/comment.svg",
                          height: 16.h,
                          width: 15.w,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: "Comments ${reviewAndFeedbackModel.comments}",
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.default4Color,
                              ),
                        ),
                        CommonWidget.sizedBox(width: 15),
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/review_and_feedback_screen/share.svg",
                          height: 16.h,
                          width: 15.w,
                        ),
                        CommonWidget.sizedBox(width: 8),
                        CommonWidget.commonText(
                          text: "Share",
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.default4Color,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewAndFeedbackPopup({
    required ReviewAndFeedbackLoadedState state,
    required BuildContext context,
    required ReviewAndFeedbackCubit reviewAndFeedbackCubit,
    required String buttonText,
    required VoidCallback onTap,
    required int index,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CommonWidget.commonText(
            text: buttonText,
            style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                  color: state.isSelectPopupMenu == index ? appConstants.primary1Color : appConstants.default1Color,
                ),
          ),
        ),
      ),
    );
  }

  Widget ratingBarStar(int rating) {
    List<Widget> starWidgets = List.generate(
      5,
      (index) {
        if (index < rating) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/star_icon.svg",
              height: 12.h,
              width: 12.w,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/star_icon.svg",
              height: 12.h,
              width: 12.w,
              color: appConstants.default6Color,
            ),
          );
        }
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: starWidgets,
    );
  }
}
