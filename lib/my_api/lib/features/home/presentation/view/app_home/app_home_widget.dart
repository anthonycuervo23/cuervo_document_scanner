import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/chat/presentation/pages/chat_list/chat_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/app_home/app_home_view.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/app_home/bottom_nav_constants.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/app_home/nav_title_widget.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/home_screen/home_screen_view.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/order_cubit/order_history_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/pages/order_history_screen_view.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/setting_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppHomeWidget extends State<AppHome> {
  late BottomNavigationCubit bottomNavigationCubit;
  final screen = [
    const HomeScreen(),
    const OrderHistoryScreen(),
    const ChatListScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    AppFunctions().getUserToken();
    bottomNavigationCubit = BlocProvider.of<BottomNavigationCubit>(context);
    orderHistoryCubit = getItInstance<OrderHistoryCubit>();
    orderHistoryCubit.loadOrderData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  AppBar appBar({required int state}) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0.0,
      elevation: 0.5,
      shadowColor: appConstants.neutral1Color,
      surfaceTintColor: appConstants.white,
      backgroundColor: appConstants.appbarColor,
      iconTheme: IconThemeData(color: appConstants.black),
      leading: Builder(
        builder: (context) {
          return IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Scaffold.of(context).openDrawer();
            },
            icon: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/appbar/drawer_icon.svg",
              fit: BoxFit.cover,
              height: 15.h,
            ),
          );
        },
      ),
      title: bottomNavigationCubit.state == 1
          ? CommonWidget.commonText(
              text: TranslationConstants.orders.translate(context),
            )
          : state == 2
              ? CommonWidget.commonText(text: TranslationConstants.chat.translate(context))
              : state == 3
                  ? CommonWidget.commonText(
                      text: TranslationConstants.settings.translate(context),
                      textAlign: TextAlign.start,
                      fontSize: 16.sp)
                  : Container(),
      actions: state == 1
          ? [
              BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
                bloc: orderHistoryCubit,
                builder: (context, state) {
                  if (state is OrderHistoryLoadedState) {
                    return DropdownButton(
                      value: state.filterValue,
                      borderRadius: BorderRadius.circular(15.r),
                      items: const [
                        DropdownMenuItem(value: "customer", child: Text("Customer")),
                        DropdownMenuItem(value: "supplier", child: Text("Supplier")),
                        DropdownMenuItem(value: "supplierReturnList", child: Text("Supplier Return List")),
                      ],
                      // elevation: 8,
                      onChanged: (v) => orderHistoryCubit.changeData(state: state, value: v ?? ""),
                    );
                    // return Container(
                    //   width: 150.w,
                    //   height: 50.h,
                    //   alignment: Alignment.center,
                    //   child: CustomDropdownButton(
                    //     selectedOptions: '',
                    //     dataList: const [
                    //       'customer',
                    //       'supplier',
                    //       'supplierReturnList',
                    //     ],
                    //     onOptionSelected: (v) {},
                    //   ),
                    // );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ]
          : state == 2
              ? [const SizedBox.shrink()]
              : state == 3
                  ? [const SizedBox.shrink()]
                  : [
                      GestureDetector(
                        onTap: () async {
                          // CommonRouter.pushNamed(RouteList.notification_screen);
                        },
                        child: BlocBuilder<CounterCubit, int>(
                          bloc: badgeCounterCubit,
                          builder: (context, state) {
                            return Badge(
                              alignment: Alignment.topRight,
                              backgroundColor: Colors.red,
                              label: Text(
                                1 == 1 ? "10" : totalNotificationCounts.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: newDeviceType == NewDeviceType.web ? 8.sp : 9.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: CommonWidget.imageBuilder(
                                imageUrl: 'assets/photos/svg/appbar/notification_icon.svg',
                                height: newDeviceType == NewDeviceType.phone
                                    ? 20.r
                                    : newDeviceType == NewDeviceType.tablet
                                        ? 22.r
                                        : 18.r,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: newDeviceType == NewDeviceType.web
                            ? EdgeInsets.only(right: 25.w, left: 55.h)
                            : EdgeInsets.only(right: 15.w, left: 25.h),
                        child: CommonWidget.imageBuilder(
                          imageUrl:
                              "https://media.istockphoto.com/id/1311084168/photo/overjoyed-pretty-asian-woman-look-at-camera-with-sincere-laughter.jpg?s=612x612&w=0&k=20&c=akS4eKR3suhoP9cuk7_7ZVZrLuMMG0IgOQvQ5JiRmAg=",
                          borderRadius: 50.r,
                          fit: BoxFit.cover,
                          height: 40.r,
                          width: 40.r,
                        ),
                      ),
                    ],
    );
  }

  Widget bottomBar({required int state}) {
    bool isNeedSafeArea = View.of(context).viewPadding.bottom > 0;
    return Container(
      height: isNeedSafeArea ? 76.h : 64.h,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.symmetric(vertical: isNeedSafeArea ? 8.h : 0),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, blurStyle: BlurStyle.outer),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < bottomBarItems.length; i++)
                  Expanded(
                    child: NavTitleWidget(
                      title: bottomBarItems[i].title.translate(context),
                      onTap: () => bottomNavigationCubit.changedBottomNavigation(i),
                      iconPath: bottomBarItems[i].icon,
                      isSelected: bottomBarItems[i].index == state,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
