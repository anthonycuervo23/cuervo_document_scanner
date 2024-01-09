import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderModel {
  String image;
  String title;
  String description;
  double height;

  SliderModel({
    required this.title,
    required this.description,
    required this.image,
    required this.height,
  });
}

List<SliderModel> listOfIntroduction = [
  SliderModel(
    title: TranslationConstants.bakry_shop,
    description: TranslationConstants.introduction_details_1,
    image: 'assets/photos/png/introduction_screen/intro_screen1.png',
    height: ScreenUtil().screenHeight * 0.54,
  ),
  SliderModel(
    title: TranslationConstants.choose_categories,
    description: TranslationConstants.introduction_details_2,
    image: 'assets/photos/png/introduction_screen/intro_screen2.png',
    height: ScreenUtil().screenHeight * 0.6,
  ),
  SliderModel(
    title: TranslationConstants.good_services,
    description: TranslationConstants.introduction_details_3,
    image: 'assets/photos/png/introduction_screen/intro_screen3.png',
    height: ScreenUtil().screenHeight * 0.55,
  ),
];
