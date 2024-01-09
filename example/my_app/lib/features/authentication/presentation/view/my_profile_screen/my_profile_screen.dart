import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/my_profile/my_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/my_profile_screen/my_profile_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends MyProfileScreenWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        textColor: appConstants.default1Color,
        title: TranslationConstants.my_profile.translate(context),
        trailing: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: CommonWidget.textButton(
            text: TranslationConstants.edit.translate(context),
            textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                  color: appConstants.primary1Color,
                ),
            onTap: () => CommonRouter.pushNamed(RouteList.edit_profile_screen, arguments: UserNewOld.oldUser),
          ),
        ),
      ),
      body: BlocBuilder<MyProfileCubit, MyProfileState>(
        bloc: myProfileCubit,
        builder: (context, state) {
          if (state is MyProfileLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  userDataView(state, context),
                  Visibility(
                    visible: state.userDataEntity.familtyInfo.isNotEmpty,
                    child: familyDetails(state: state),
                  ),
                ],
              ),
            );
          } else if (state is MyProfileLoadingState) {
            return Center(child: CommonWidget.loadingIos());
          } else if (state is MyProfileErrorState) {
            return CommonWidget.dataNotFound(
              context: context,
              heading: TranslationConstants.something_went_wrong.translate(context),
              subHeading: state.errorMessage,
              buttonLabel: TranslationConstants.try_again.translate(context),
              // onTap: () => productCategoryCubit.getCategory(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
