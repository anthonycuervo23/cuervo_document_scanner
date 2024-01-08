import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/view/reminder_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ReminderScreen extends StatefulWidget {
  final ReminderType reminderType;
  const ReminderScreen({super.key, required this.reminderType});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends ReminderWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appConstants.backGroundColor,
        appBar: CustomAppBar(
          context,
          title: (reminderType == ReminderType.birthday)
              ? TranslationConstants.birthday.translate(context)
              : (reminderType == ReminderType.anniversary)
                  ? TranslationConstants.anniversary.translate(context)
                  : TranslationConstants.events.translate(context),
          titleCenter: false,
          onTap: () => CommonRouter.pop(),
        ),
        body: BlocBuilder<ReminderCubit, ReminderState>(
          bloc: reminderCubit,
          builder: (context, state) {
            if (state is ReminderLoadedState) {
              return Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  children: [
                    textField(
                      width: ScreenUtil().screenWidth,
                      context: context,
                      isSufix: true,
                      onTap: () async {
                        // String date = await searchFilterDialog(
                        //       context: context,
                        //       searchFilterCubit: reminderCubit.searchFilterCubit,
                        //     ) ??
                        //     "all";
                        // reminderCubit.filterData(state: state, value: date);
                      },
                      controller: reminderCubit.searchController,
                      onChanged: (p0) {},
                      // onChanged: reminderCubit.commonFilter(state: state),
                    ),
                    CommonWidget.sizedBox(height: 10.h),
                    Expanded(
                      child: LazyLoadScrollView(
                        scrollDirection: Axis.vertical,
                        onEndOfPage: () {
                          if (reminderType == ReminderType.birthday &&
                              state.birthdayReminderData?.nextPageUrl.isNotEmpty == true) {
                            reminderCubit.loadData(
                              reminderType: reminderType,
                              nextPageLoad: true,
                            );
                          } else if (reminderType == ReminderType.anniversary &&
                              state.anniversoryReminderData?.nextPageUrl.isNotEmpty == true) {
                            reminderCubit.loadData(
                              reminderType: reminderType,
                              nextPageLoad: true,
                            );
                          } else if (reminderType == ReminderType.event &&
                              state.eventsReminderData?.nextPageUrl.isNotEmpty == true) {
                            reminderCubit.loadData(
                              reminderType: reminderType,
                              nextPageLoad: true,
                            );
                          }
                        },
                        child: ListView.builder(
                          itemCount: (reminderType == ReminderType.birthday)
                              ? state.birthdayDataList?.length
                              : (reminderType == ReminderType.anniversary)
                                  ? state.anniversoryDataList?.length
                                  : state.eventsDataList?.length,
                          itemBuilder: (contex, index) {
                            return commonBox(state: state, index: index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ReminderLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is ReminderErrorState) {
              return Center(child: CommonWidget.commonText(text: state.erroMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
