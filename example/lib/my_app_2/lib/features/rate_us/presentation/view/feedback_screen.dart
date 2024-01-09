// ignore_for_file: library_private_types_in_public_api

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/cubit/feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/view/feedback_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends FeedbackWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackCubit, double>(
      bloc: feedbackCubit,
      builder: (context, state) {
        return CommonWidget.gestureHideKeyboard(
          context,
          child: Scaffold(
            appBar: customAppBar(
              context,
              title: TranslationConstants.feedback.translate(context),
              onTap: () => CommonRouter.pop(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  reateUs(context: context, state: state),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 25.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.commonText(
                          text: TranslationConstants.do_you_have_feedback.translate(context),
                          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                        giveYourFeedbackTextFeild(context),
                        showMyNameToggelButton(context),
                        submitButtom(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
