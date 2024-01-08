import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/data/models/upcoming_events_model.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/cubit/upcoming_events_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/pages/upcoming_event_screen/upcoming_events_screen.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class UpcomingEventsWidget extends State<UpcomingEventsScreen> {
  late UpcomingEventsCubit upcomingEventsCubit;

  @override
  void initState() {
    upcomingEventsCubit = getItInstance<UpcomingEventsCubit>();
    super.initState();
  }

  Widget upComingBox(
      {required int index, required UpcomingEventsModel model, required UpcomingEventsLoadedState state}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 1), blurRadius: 2, spreadRadius: 2, color: Color.fromARGB(5, 0, 0, 0)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: "#${index + 1}",
                fontSize: 14.sp,
                bold: true,
                color: const Color(0xff293847),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: model.eventName,
                fontSize: 14.sp,
                bold: true,
                color: const Color(0xff293847),
              ),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.6,
                child: CommonWidget.commonText(
                  text: model.eventInformation,
                  maxLines: 2,
                  fontSize: 11.sp,
                  color: const Color(0xff293847).withOpacity(0.6),
                ),
              ),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.6,
                child: Row(
                  children: [
                    CommonWidget.commonText(
                      text: "Event Date: ",
                      fontSize: 12.sp,
                      bold: true,
                      color: const Color(0xff293847),
                    ),
                    CommonWidget.commonText(
                      text: model.eventDate,
                      fontSize: 12.sp,
                      color: const Color(0xff293847).withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => CommonRouter.pushNamed(
                      RouteList.add_upcoming_events_screen,
                      arguments: UpcomingEventsModel(
                        index: index,
                        eventName: model.eventName,
                        eventInformation: model.eventInformation,
                        eventDate: model.eventDate,
                      ),
                    ),
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/customer/edit.svg",
                      height: 20.h,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () => upcomingEventsCubit.deleteEvent(index: index, state: state),
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/customer/delete.svg",
                      height: 20.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
