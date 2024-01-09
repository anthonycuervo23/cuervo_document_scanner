import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/cubit/feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/view/feedback_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

abstract class FeedbackWidget extends State<FeedbackScreen> {
  List<String> listOfFeedbackText = ["Very Bad!", "Bad!", "Ok ok!", "Good!", "Amazing!"];
  late FeedbackCubit feedbackCubit;

  @override
  void initState() {
    super.initState();
    feedbackCubit = getItInstance<FeedbackCubit>();
    feedbackCubit.feedbackController.clear();
  }

  @override
  void dispose() {
    feedbackCubit.close();
    super.dispose();
  }

  Widget giveYourFeedbackTextFeild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: TextFormField(
        onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
        controller: feedbackCubit.feedbackController,
        maxLines: 3,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          counterText: "",
          fillColor: appConstants.textFiledColor,
          filled: true,
          hintStyle: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default5Color),
          border: InputBorder.none,
          hintText: '${TranslationConstants.tyep_your_feedback.translate(context)}...',
          enabledBorder: textFildeBorder(color: appConstants.default7Color),
          focusedBorder: textFildeBorder(color: appConstants.primary1Color),
          errorBorder: textFildeBorder(color: appConstants.requiredColor),
          focusedErrorBorder: textFildeBorder(color: appConstants.primary1Color),
        ),
      ),
    );
  }

  Widget showMyNameToggelButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.show_my_name.translate(context),
          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
        BlocBuilder<ToggleCubit, bool>(
          bloc: feedbackCubit.toggleCubit,
          builder: (context, state) {
            return CommonWidget.toggleButton(
              value: state,
              thumbColor: feedbackCubit.isSwitchOn ? appConstants.primary1Color : appConstants.default8Color,
              onChanged: (value) => feedbackCubit.toggleCubit.setValue(value: value),
            );
          },
        ),
      ],
    );
  }

  Widget submitButtom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: CommonWidget.commonButton(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 11.h,
        ),
        alignment: Alignment.center,
        text: TranslationConstants.submit.translate(context),
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
        onTap: () {},
        context: context,
      ),
    );
  }

  OutlineInputBorder textFildeBorder({required color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  Widget reateUs({required BuildContext context, required double state}) {
    return CommonWidget.container(
      color: appConstants.greyBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 25.h,
      ),
      child: CommonWidget.container(
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 20.h,
        ),
        borderRadius: appConstants.prductCardRadius,
        color: appConstants.whiteBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.rate_your_experience.translate(context),
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
            CommonWidget.sizedBox(height: 15),
            ratingBarStar(),
            CommonWidget.sizedBox(height: 22),
            CommonWidget.commonText(
              text: listOfFeedbackText[feedbackCubit.currentSliderValue.toInt() - 1],
              style: Theme.of(context).textTheme.subTitle1MediumHeading.copyWith(color: appConstants.default1Color),
            ),
            CommonWidget.sizedBox(height: 15),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: CustomThumbShape(),
                trackHeight: 5.h,
                inactiveTrackColor: appConstants.greyBackgroundColor,
              ),
              child: Slider(
                value: state,
                activeColor: appConstants.primary1Color,
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (double value) {
                  feedbackCubit.changeSliderValue(value: value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingBarStar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          feedbackCubit.currentSliderValue.toInt(),
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CommonWidget.imageBuilder(
              imageUrl: feedbackCubit.currentSliderValue == 1
                  ? "assets/photos/svg/feedback/feedback1.svg"
                  : feedbackCubit.currentSliderValue == 2
                      ? "assets/photos/svg/feedback/feedback2.svg"
                      : feedbackCubit.currentSliderValue == 3
                          ? "assets/photos/svg/feedback/feedback3.svg"
                          : feedbackCubit.currentSliderValue == 4
                              ? "assets/photos/svg/feedback/feedback4.svg"
                              : "assets/photos/svg/feedback/feedback5.svg",
              width: 30.r,
              height: 30.r,
            ),
          ),
        ),
        ...List.generate(
          5 - feedbackCubit.currentSliderValue.toInt(),
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/feedback/feedback0.svg",
              width: 30.r,
              height: 30.r,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius = 10;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final outerRadius = thumbRadius;
    final outerPaint = Paint()
      ..color = appConstants.primary1Color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawCircle(center, outerRadius, outerPaint);

    final innerRadius = thumbRadius - outerPaint.strokeWidth / 2;

    final innerPaint = Paint()..color = Colors.white;

    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}
