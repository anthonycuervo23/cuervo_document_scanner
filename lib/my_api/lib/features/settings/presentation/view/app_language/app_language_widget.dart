import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/app_language/app_language_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/app_language/app_language_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppLanguageWidget extends State<AppLanguageScreen> {
  late AppLanguageCubit appLanguageCubit;

  @override
  void initState() {
    appLanguageCubit = getItInstance<AppLanguageCubit>();
    appLanguageCubit.loadAppLanguages();
    super.initState();
  }

  Widget commonLanguageBox({
    required VoidCallback onTap,
    required int index,
    required AppLanguageEntity appLanguageEntity,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CommonWidget.container(
        color: appConstants.white,
        borderRadius: 10.r,
        isBorder: appLanguageEntity.isDefault == 1,
        borderColor: appLanguageEntity.isDefault == 1 ? appConstants.themeColor : appConstants.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w, top: 12.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: CommonWidget.imageBuilder(
                      imageUrl: appLanguageEntity.imageUrl!,
                      height: 31.r,
                      width: 31.r,
                      borderRadius: 96.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Visibility(
                    visible: appLanguageEntity.isDefault == 1,
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
                      height: 18.r,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              CommonWidget.commonText(
                text: appLanguageEntity.name,
                style: Theme.of(context).textTheme.caption1MediumHeading.copyWith(color: appConstants.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
