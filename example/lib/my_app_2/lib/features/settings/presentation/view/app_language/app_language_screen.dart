import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/settings/domain/entities/app_language_entity.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/app_language/app_language_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/app_language/app_language_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLanguageScreen extends StatefulWidget {
  const AppLanguageScreen({super.key});

  @override
  State<AppLanguageScreen> createState() => _AppLanguageScreenState();
}

class _AppLanguageScreenState extends AppLanguageWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.language.translate(context),
      ),
      body: BlocBuilder<AppLanguageCubit, AppLanguageState>(
        bloc: appLanguageCubit,
        builder: (context, state) {
          if (state is AppLanguageLoadedState) {
            return Padding(
              padding: EdgeInsets.only(top: 12.h, left: 15.w, right: 15.w, bottom: ScreenUtil().bottomBarHeight + 16.h),
              child: GridView.builder(
                itemCount: state.appLanguageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 18.w,
                  childAspectRatio: 1.8.r,
                ),
                itemBuilder: (context, index) {
                  AppLanguageEntity appLanguageEntity = state.appLanguageList[index];
                  return commonLanguageBox(
                    index: index,
                    state: state,
                    appLanguageEntity: appLanguageEntity,
                    onTap: () => appLanguageCubit.changeLanguage(state: state, selectindex: index),
                  );
                },
              ),
            );
          } else if (state is AppLanguageLoadingState) {
            return CommonWidget.loadingIos();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
