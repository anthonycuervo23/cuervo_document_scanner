import 'dart:io';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/onboarding/data/model/introduction_model.dart';
import 'package:bakery_shop_flutter/features/onboarding/presentation/view/introduction_screen/introduction_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends IntroductionWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
        context,
        toolbarHeight: 25,
        backArrow: false,
        appBarColor: Colors.transparent,
        trailing: Padding(
          padding: EdgeInsets.only(right: 20.h),
          child: CommonWidget.textButton(
            text: TranslationConstants.skip.translate(context),
            textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.primary1Color),
            onTap: () {
              bakeryBox.put(HiveConstants.IS_FIRST_LOAD, false);
              CommonRouter.pushReplacementNamed(RouteList.login_screen);
            },
          ),
        ),
      ),
      body: BlocBuilder<CounterCubit, int>(
        bloc: counterCubit,
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight,
                width: ScreenUtil().screenWidth,
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/introduction_screen/intro_background.svg",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: listOfIntroduction.length,
                        onPageChanged: (index) => counterCubit.chanagePageIndex(index: index),
                        dragStartBehavior: DragStartBehavior.start,
                        itemBuilder: (context, index) {
                          SliderModel sliderModel = listOfIntroduction[index];
                          return detailsOfIntroductionScreen(sliderModel: sliderModel);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Platform.isAndroid ? 45.h : 25.h,
                        top: Platform.isAndroid ? 0 : 10.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          listOfIntroduction.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: CustomDotIndicator(isActive: state == index),
                          ),
                        ),
                      ),
                    ),
                    bottomButton(state: state),
                    CommonWidget.sizedBox(height: Platform.isAndroid ? 50.h : 15 + ScreenUtil().bottomBarHeight),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
