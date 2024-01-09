import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/order_time_slot/order_time_slot_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/reminder_date/reminder_date_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/setting_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends SettingWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.settings.translate(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              settingListTile(
                svgPicturePath: "assets/photos/svg/setting_screen/language_icon.svg",
                text: TranslationConstants.language.translate(context),
                nextArrow: true,
                onTap: () => CommonRouter.pushNamed(RouteList.app_language_screen),
              ),
              BlocBuilder<OrderTimeSlotCubit, OrderTimeSlotState>(
                bloc: orderTimeSlotCubit,
                builder: (context, state) {
                  if (state is OrderTimeSlotLoadedState) {
                    return settingListTile(
                      svgPicturePath: "assets/photos/svg/setting_screen/order_time_slot.svg",
                      text: TranslationConstants.order_time_slot.translate(context),
                      nextArrow: false,
                      trailing: CommonWidget.commonText(
                        text: state.selectedTimeSlot,
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.primary1Color,
                            ),
                      ),
                      onTap: () => orderTimeSlotDialog(context: context),
                    );
                  } else if (state is OrderTimeSlotLoadingState) {
                    return CommonWidget.loadingIos();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/setting_screen/my_address.svg",
                text: TranslationConstants.my_address.translate(context),
                nextArrow: true,
                onTap: () {
                  if (userToken == null) {
                    CommonRouter.pushNamed(RouteList.without_login_screen, arguments: true);
                  } else {
                    CommonRouter.pushNamed(
                      RouteList.manage_address_screen,
                      arguments: CheckLoactionNavigation.addAddress,
                    );
                  }
                },
              ),
              BlocBuilder<ReminderDateCubit, ReminderDateState>(
                bloc: reminderDateCubit,
                builder: (context, state) {
                  if (state is ReminderDateLoadedState) {
                    return settingListTile(
                      svgPicturePath: "assets/photos/svg/common/selected_calender.svg",
                      text: TranslationConstants.reminder_date.translate(context),
                      nextArrow: false,
                      trailing: CommonWidget.commonText(
                        text: reminderDateCubit.formattedDate,
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.primary1Color,
                            ),
                      ),
                      onTap: () async {
                        List<DateTime> date = await CommonWidget.datePicker(
                          context: context,
                          minDate: DateTime.now(),
                          maxDate: DateTime(DateTime.now().year + 100),
                          isRangeDate: false,
                        );
                        reminderDateCubit.selectReminderDate(date: date[0]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<ToggleCubit, bool>(
                bloc: settingCubit.promotionalActivationCubit,
                builder: (context, state) {
                  return settingListTile(
                    svgPicturePath: "assets/photos/svg/setting_screen/promotional_activation.svg",
                    text: TranslationConstants.promotional_activation.translate(context),
                    nextArrow: false,
                    contentPadding: EdgeInsets.only(left: 15.w),
                    onTap: () {},
                    trailing: CommonWidget.toggleButton(
                      value: state,
                      onChanged: (bool value) {
                        settingCubit.promotionalActivationCubit.setValue(value: value);
                      },
                    ),
                  );
                },
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/setting_screen/privacy_policy.svg",
                text: TranslationConstants.privacy_policy.translate(context),
                nextArrow: true,
                onTap: () => CommonRouter.pushNamed(RouteList.policy_screen, arguments: TypeOfPolicy.privacyPolicy),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/setting_screen/terms_condition.svg",
                text: TranslationConstants.terms_and_condition.translate(context),
                nextArrow: true,
                onTap: () => CommonRouter.pushNamed(
                  RouteList.policy_screen,
                  arguments: TypeOfPolicy.termsAndConditions,
                ),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/setting_screen/logout_icon.svg",
                text: TranslationConstants.log_out.translate(context),
                nextArrow: true,
                onTap: () async {
                  var data = await CommonWidget.showAlertDialog(
                    context: context,
                    isTitle: true,
                    titleText: TranslationConstants.confirm_logout.translate(context),
                    text: TranslationConstants.sure_want_to_logout.translate(context),
                    // onTap: () async {
                    //   AppFunctions().forceLogout();
                    //   settingCubit.logout();
                    //   bool value = await settingCubit.logout();
                    //   if (value) {
                    //     CommonRouter.pushNamed(RouteList.login_screen);
                    //   } else {
                    //   CustomSnackbar.show(
                    //     snackbarType: SnackbarType.ERROR,
                    //     // ignore: use_build_context_synchronously
                    //     message: TranslationConstants.something_went_wrong.translate(context),
                    //   );
                    //   }
                    // },
                  );
                  if (data) {
                    AppFunctions().forceLogout();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
