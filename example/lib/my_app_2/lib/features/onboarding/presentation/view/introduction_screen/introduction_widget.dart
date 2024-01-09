import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/onboarding/data/model/introduction_model.dart';
import 'package:bakery_shop_flutter/features/onboarding/presentation/view/introduction_screen/introduction_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class IntroductionWidget extends State<IntroductionScreen> {
  late CounterCubit counterCubit;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    counterCubit = getItInstance<CounterCubit>();
  }

  @override
  void dispose() {
    counterCubit.close();
    super.dispose();
  }

  Widget detailsOfIntroductionScreen({required SliderModel sliderModel}) {
    return Column(
      children: [
        CommonWidget.imageBuilder(
          imageUrl: sliderModel.image,
          width: ScreenUtil().screenWidth * 0.8,
          height: ScreenUtil().screenHeight * 0.45,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Column(
            children: [
              CommonWidget.commonText(
                text: sliderModel.title.translate(context),
                style: Theme.of(context).textTheme.h3BoldHeading.copyWith(color: appConstants.default1Color),
              ),
              CommonWidget.sizedBox(height: 10),
              sliderModel.description.isNotEmpty
                  ? CommonWidget.commonText(
                      text: sliderModel.description.translate(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default3Color),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomButton({required int state}) {
    return CommonWidget.commonButton(
      height: 48.h,
      margin: EdgeInsets.only(left: 55.h, right: 55.h),
      width: ScreenUtil().screenWidth,
      alignment: Alignment.center,
      style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
            color: appConstants.buttonTextColor,
            fontSize: 19.sp,
          ),
      text: state != (listOfIntroduction.length - 1)
          ? TranslationConstants.next_introduction.translate(context)
          : TranslationConstants.get_started.translate(context),
      context: context,
      onTap: () {
        if (state != listOfIntroduction.length - 1) {
          pageController.animateToPage(
            (state + 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else {
          bakeryBox.put(HiveConstants.IS_FIRST_LOAD, false);
          CommonRouter.pushReplacementNamed(RouteList.login_screen);
        }
      },
    );
  }
}

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 7.h,
      width: isActive ? 22.w : 7.w,
      decoration: BoxDecoration(
        color: isActive ? appConstants.primary1Color : appConstants.secondary1Color,
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
    );
  }
}
