import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/image_crop_args.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/image_crop/crop_image_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CropImageScreen extends StatefulWidget {
  final ImageCropArgs cropArgs;

  const CropImageScreen({Key? key, required this.cropArgs}) : super(key: key);

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends CropImageWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: AppBar(
        title: CommonWidget.commonText(
          text: TranslationConstants.crop_image.translate(context),
          style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
        ),
        backgroundColor: appConstants.whiteBackgroundColor,
        centerTitle: true,
      ),
      body: Container(
        color: appConstants.whiteBackgroundColor,
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Center(child: buildImage()),
        ),
      ),
      bottomNavigationBar: buildButtons(),
    );
  }
}
