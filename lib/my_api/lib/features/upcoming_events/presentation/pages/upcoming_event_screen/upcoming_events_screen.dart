import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/data/models/upcoming_events_model.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/cubit/upcoming_events_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/pages/upcoming_event_screen/upcoming_events_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingEventsScreen extends StatefulWidget {
  const UpcomingEventsScreen({super.key});

  @override
  State<UpcomingEventsScreen> createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends UpcomingEventsWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appConstants.blueBgColor,
        appBar: CustomAppBar(
          context,
          elevation: 0.5,
          shadowcolor: appConstants.grey,
          title: TranslationConstants.upcoming_events.translate(context),
          titleCenter: false,
          onTap: () => CommonRouter.pop(),
        ),
        body: BlocBuilder<UpcomingEventsCubit, UpcomingEventsState>(
          bloc: upcomingEventsCubit,
          builder: (context, state) {
            if (state is UpcomingEventsLoadedState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    textField(
                      context: context,
                      onTap: () async {
                        String date = await searchFilterDialog(
                              context: context,
                              searchFilterCubit: orderHistoryCubit.searchFilterCubit,
                            ) ??
                            "error";
                        upcomingEventsCubit.filterForDate(state: state, value: date);
                      },
                      controller: upcomingEventsCubit.searchController,
                      onChanged: (v) => upcomingEventsCubit.commonFilter(state: state),
                      width: ScreenUtil().screenWidth,
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: state.filterList != null && state.filterList!.isEmpty
                          ? CommonWidget.dataNotFound(
                              context: context,
                              actionButton: const SizedBox.shrink(),
                              bgColor: Colors.transparent,
                            )
                          : ListView.builder(
                              itemCount: state.filterList?.length ?? state.listOfEvents.length,
                              itemBuilder: (context, index) {
                                UpcomingEventsModel model = state.filterList?[index] ?? state.listOfEvents[index];
                                return upComingBox(model: model, index: index, state: state);
                              },
                            ),
                    ),
                  ],
                ),
              );
            } else if (state is UpcomingEventsLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is UpcomingEventsErrorState) {
              return Center(child: CommonWidget.commonText(text: state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: Container(
          height: 80.h,
          width: newDeviceType == NewDeviceType.phone
              ? ScreenUtil().screenWidth
              : newDeviceType == NewDeviceType.tablet
                  ? ScreenUtil().screenWidth
                  : double.infinity,
          color: appConstants.white,
          child: Center(
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () => CommonRouter.pushNamed(
                RouteList.add_upcoming_events_screen,
                arguments: UpcomingEventsModel(
                  eventName: '',
                  eventInformation: '',
                  eventDate: '',
                  index: 0,
                ),
              ),
              child: Container(
                height: 45.h,
                width: newDeviceType == NewDeviceType.phone
                    ? 180.w
                    : newDeviceType == NewDeviceType.tablet
                        ? ScreenUtil().screenWidth / 1.5
                        : ScreenUtil().screenWidth / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: appConstants.themeColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/customer/add_new.svg",
                      height: 20.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      TranslationConstants.add_event.translate(context),
                      style: TextStyle(fontSize: 15.sp, color: appConstants.white, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
