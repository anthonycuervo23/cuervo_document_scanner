import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';

// Widget withoutLogin({required BuildContext context}) {
//   return Padding(
//     padding: EdgeInsets.only(left: 2.w, top: 8.h, bottom: 26.h),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CommonWidget.commonText(
//           text: TranslationConstants.welcome_to_drawer.translate(context),
//           style: Theme.of(context).textTheme.subTitle2LightHeading.copyWith(color: appConstants.buttonTextColor),
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: TranslationConstants.bakery.translate(context),
//                     style: Theme.of(context).textTheme.h2BoldHeading.copyWith(
//                           color: appConstants.primary1Color,
//                         ),
//                   ),
//                   TextSpan(
//                     text: TranslationConstants.shop.translate(context),
//                     style: Theme.of(context).textTheme.h2BoldHeading.copyWith(
//                           color: appConstants.buttonTextColor,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         CommonWidget.commonText(
//           text: TranslationConstants.please_login_to_continue.translate(context),
//           style: Theme.of(context).textTheme.subTitle2LightHeading.copyWith(color: appConstants.buttonTextColor),
//         ),
//         CommonWidget.sizedBox(height: 20),
//         GestureDetector(
//           onTap: () => CommonRouter.pushReplacementNamed(RouteList.login_screen),
//           child: CommonWidget.container(
//             height: 48.h,
//             width: ScreenUtil().screenWidth / 1.3,
//             color: appConstants.primary1Color,
//             borderRadius: appConstants.prductCardRadius,
//             alignment: Alignment.center,
//             child: CommonWidget.commonText(
//               text: TranslationConstants.login_capital.translate(context),
//               style: Theme.of(context).textTheme.captionBoldHeading.copyWith(color: appConstants.buttonTextColor),
//             ),
//           ),
//         ),
//         CommonWidget.sizedBox(height: 15),
//         InkWell(
//           onTap: () => CommonRouter.pop(),
//           child: CommonWidget.commonText(
//             text: TranslationConstants.back_home.translate(context),
//             style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.buttonTextColor),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget withoutLogin({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(left: 2.w, top: 8.h, bottom: 16.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.welcome_to_drawer.translate(context),
              style: Theme.of(context).textTheme.bodyLightHeading.copyWith(color: appConstants.whiteBackgroundColor),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TranslationConstants.bakery.translate(context),
                    style: Theme.of(context).textTheme.subTitle1BoldHeading.copyWith(color: appConstants.primary1Color),
                  ),
                  TextSpan(
                    text: TranslationConstants.shop.translate(context),
                    style: Theme.of(context)
                        .textTheme
                        .subTitle1BoldHeading
                        .copyWith(color: appConstants.whiteBackgroundColor),
                  )
                ],
              ),
            ),
            CommonWidget.commonText(
              text: TranslationConstants.please_login_to_continue.translate(context),
              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                    color: appConstants.whiteBackgroundColor,
                  ),
            ),
          ],
        ),
        CommonWidget.commonButton(
          context: context,
          text: TranslationConstants.login.translate(context).toUpperCase(),
          style: Theme.of(context).textTheme.captionBoldHeading.copyWith(color: appConstants.buttonTextColor),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          borderRadius: 8.r,
          onTap: () => CommonRouter.pushReplacementNamed(RouteList.login_screen),
        ),
      ],
    ),
  );
}

Widget withLogin({required BuildContext context, required GerUserDataLoadedState state}) {
  return Padding(
    padding: EdgeInsets.only(left: 2.w, top: 8.h, bottom: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  CommonRouter.pop();
                  CommonRouter.pushNamed(RouteList.my_profile_screen);
                },
                child: Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.15),
                  ),
                  padding: state.userDataEntity.profilePhoto != ''
                      ? EdgeInsets.all(state.userDataEntity.profilePhoto.endsWith('svg') ? 5.r : 0)
                      : accountInfoEntity?.defaultImage.isNotEmpty == true
                          ? EdgeInsets.all(accountInfoEntity!.defaultImage.endsWith('svg') ? 5.r : 0)
                          : const EdgeInsets.all(0),
                  child: state.userDataEntity.profilePhoto != ''
                      ? CommonWidget.imageBuilder(
                          borderRadius: 50,
                          imageUrl: state.userDataEntity.profilePhoto,
                        )
                      : accountInfoEntity?.defaultImage.isNotEmpty == true
                          ? CommonWidget.imageBuilder(
                              borderRadius: 50,
                              imageUrl: accountInfoEntity!.defaultImage,
                            )
                          : CommonWidget.imageBuilder(
                              imageUrl: "assets/photos/svg/edit_profile/avtar_picture.svg",
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CommonRouter.pop();
                        CommonRouter.pushNamed(RouteList.my_profile_screen);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.commonText(
                            text: '${TranslationConstants.hey.translate(context)},',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLightHeading
                                .copyWith(color: appConstants.buttonTextColor),
                          ),
                          CommonWidget.commonText(
                            text: state.userDataEntity.name?.toCamelcase() ??
                                TranslationConstants.name.translate(context),
                            style: Theme.of(context)
                                .textTheme
                                .bodyBoldHeading
                                .copyWith(color: appConstants.buttonTextColor),
                          ),
                        ],
                      ),
                    ),
                    CommonWidget.commonText(
                      text: state.userDataEntity.referralCode,
                      style:
                          Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.primary1Color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            CommonRouter.pop();
            CommonRouter.pushNamed(RouteList.edit_profile_screen, arguments: UserNewOld.oldUser);
          },
          child: CircleAvatar(
            backgroundColor: appConstants.primary1Color,
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/edit_icon.svg",
              height: 15.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget drawerItems({required BuildContext context}) {
  return Expanded(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: 16.h, left: 16.w),
        child: Column(
          children: [
            commonTile(
              context: context,
              text: TranslationConstants.my_order_history.translate(context),
              imagePath: 'assets/photos/svg/drawer/order_history_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.order_history_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.order_status.translate(context),
              imagePath: 'assets/photos/svg/drawer/order_status_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.order_status_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.my_refer_code.translate(context),
              imagePath: 'assets/photos/svg/drawer/refer_code_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.refer_earn_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.my_reward_point.translate(context),
              imagePath: 'assets/photos/svg/drawer/my_points_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.my_reward_point_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.my_routine_order.translate(context),
              imagePath: 'assets/photos/svg/drawer/routine_order_icon.svg',
              requiredLogin: true,
              onTap: () {
                // BlocProvider.of<CartCubit>(context).updateAllData(
                //   nevigateToDrawers: RoutineOrder.drawer,
                //   routineOrderss: true,
                //   state: state,
                // );
                CommonRouter.pushNamed(RouteList.routine_order_screen);
              },
            ),
            commonTile(
              context: context,
              text: TranslationConstants.chat.translate(context),
              imagePath: 'assets/photos/svg/drawer/chat_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.chat_support_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.help_Support.translate(context),
              imagePath: 'assets/photos/svg/drawer/help_support_icon.svg',
              onTap: () => CommonRouter.pushNamed(RouteList.help_support_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.settings.translate(context),
              imagePath: 'assets/photos/svg/drawer/settings_icon.svg',
              onTap: () => CommonRouter.pushNamed(RouteList.setting_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.favorite_list.translate(context),
              imagePath: 'assets/photos/svg/drawer/favorite_list_icon.svg',
              requiredLogin: true,
              onTap: () => CommonRouter.pushNamed(RouteList.my_favorite_screen),
            ),
            commonTile(
              context: context,
              text: TranslationConstants.rate_us.translate(context),
              imagePath: 'assets/photos/svg/drawer/rate_us_icon.svg',
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...');
                if (await inAppReview.isAvailable()) {
                  inAppReview.requestReview();
                }
              },
            ),
            commonTile(
              context: context,
              text: TranslationConstants.share_app.translate(context),
              imagePath: 'assets/photos/svg/drawer/share_app_icon.svg',
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}

Widget commonTile({
  required String text,
  required VoidCallback onTap,
  required String imagePath,
  required BuildContext context,
  bool requiredLogin = false,
}) {
  return drawerCommonBox(
    onTap: () {
      CommonRouter.pop();
      if (userToken == null && requiredLogin) {
        CommonRouter.pushNamed(RouteList.without_login_screen, arguments: true);
      } else {
        onTap.call();
      }
    },
    text: text,
    svgPicturePath: imagePath,
    context: context,
  );
}

Widget drawerCommonBox({
  required BuildContext context,
  required VoidCallback onTap,
  required String text,
  Color? textColor,
  String? svgPicturePath,
}) {
  return GestureDetector(
    onTap: onTap,
    child: CommonWidget.container(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      color: Colors.transparent,
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          CommonWidget.imageBuilder(imageUrl: svgPicturePath ?? '', fit: BoxFit.contain, height: 18.r),
          CommonWidget.sizedBox(width: 22),
          CommonWidget.commonText(
            text: text,
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.buttonTextColor),
          ),
        ],
      ),
    ),
  );
}
