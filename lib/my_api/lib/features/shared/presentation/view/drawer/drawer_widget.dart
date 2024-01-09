import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget profileDetails({required BuildContext context}) {
  return Container(
    height: 150,
    decoration: BoxDecoration(color: appConstants.themeColor),
    child: DrawerHeader(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.only(top: 10, left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 60,
              width: 60,
              child: CircleAvatar(
                child: CommonWidget.imageBuilder(imageUrl: "assets/photos/dummy/dummy_avtar.png"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bakery Shop",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  CommonWidget.commonText(
                    text: "bakeryshopadmin12@gmai.com",
                    textOverflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: CommonWidget.commonButton(
                      context: context,
                      onTap: () {
                        //  CommonRouter.pushNamed(RouteList.edit_profile__screen)
                      },
                      text: "Edit",
                      textColor: Colors.black,
                      width: 90,
                      color: Colors.blue.shade100,
                      alignment: Alignment.center,
                      borderRadius: 15,
                    ),
                  ),
                  // MaterialButton(
                  //   padding: const EdgeInsets.all(6),
                  //   height: 8,
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  //   minWidth: 90,
                  //   color: Colors.blue.shade100,
                  //   onPressed: () => CommonRouter.pushNamed(RouteList.edit_profile__screen),
                  //   textColor: Colors.black,
                  //   child: const Text(
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget drawerList({required BuildContext context}) {
  List<DrawerListModel> listOfDrawerData = [
    DrawerListModel(
      title: 'Customer',
      image: "assets/photos/svg/side_menu/customer.svg",
      routeName: RouteList.customer_list_screen,
    ),
    DrawerListModel(
      title: 'Reminder',
      image: "assets/photos/svg/side_menu/reminder.svg",
      routeName: RouteList.reminder_screen,
      subList: [
        DrawerListModel(
          title: 'Birthday',
          routeName: RouteList.reminder_screen,
        ),
        DrawerListModel(
          title: 'Anniversary',
          routeName: RouteList.reminder_screen,
        ),
        DrawerListModel(
          title: 'Events',
          routeName: RouteList.reminder_screen,
        ),
      ],
    ),
    DrawerListModel(
      title: 'Product List',
      image: "assets/photos/svg/side_menu/product_list.svg",
      routeName: RouteList.product_list_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.routine_order.translate(context),
      image: "assets/photos/svg/side_menu/routine_order.svg",
      routeName: RouteList.routine_order_screen,
    ),
    DrawerListModel(
      title: 'Combo list',
      image: "assets/photos/svg/side_menu/combo_list.svg",
      routeName: RouteList.combo_screen,
    ),
    DrawerListModel(
      title: 'Marketing',
      image: "assets/photos/svg/side_menu/marketing.svg",
      routeName: RouteList.marketing_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.supplier.translate(context),
      image: "assets/photos/svg/side_menu/supplier.svg",
      routeName: RouteList.supplier_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.expenses.translate(context),
      image: "assets/photos/svg/side_menu/expenses.svg",
      routeName: RouteList.expenses_category_list_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.upcoming_events.translate(context),
      image: "assets/photos/svg/side_menu/upcoming_events.svg",
      routeName: RouteList.upcoming_events_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.app_layouts.translate(context),
      image: "assets/photos/svg/side_menu/app_layouts.svg",
      routeName: RouteList.app_layouts_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.role_management.translate(context),
      image: "assets/photos/svg/side_menu/role_management.svg",
      routeName: RouteList.role_management_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.offers.translate(context),
      image: "assets/photos/svg/side_menu/offers.svg",
      routeName: RouteList.offers_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.return_order.translate(context),
      image: "assets/photos/svg/side_menu/return_order.svg",
      routeName: RouteList.return_order_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.purchase_list.translate(context),
      image: "assets/photos/svg/side_menu/purchase_list.svg",
      routeName: RouteList.purchse_list_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.product_inventory.translate(context),
      image: "assets/photos/svg/side_menu/product_inventory.svg",
      routeName: RouteList.product_inventory_screen,
    ),
    DrawerListModel(
      title: TranslationConstants.profit_or_loss_sheet.translate(context),
      image: "assets/photos/svg/side_menu/profit_or_loss_sheet.svg",
      routeName: RouteList.profit_loss_sheet_screen,
    ),
  ];

  return SizedBox(
    width: 150.w,
    height: ScreenUtil().screenHeight * 0.9,
    child: ListView.builder(
      padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
      itemCount: listOfDrawerData.length,
      itemBuilder: (context, index) {
        return listOfDrawerData[index].subList == null
            ? commonTile(
                text: listOfDrawerData[index].title,
                onTap: () => CommonRouter.pushNamed(listOfDrawerData[index].routeName),
                imagePath: listOfDrawerData[index].image!,
                context: context)
            : listOfDrawerData[index].subList?.isNotEmpty == true
                ? Theme(
                    data: ThemeData(splashColor: appConstants.transparent),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.only(right: 15.w),
                      childrenPadding: EdgeInsets.zero,
                      collapsedIconColor: appConstants.themeColor,
                      collapsedTextColor: appConstants.themeColor,
                      iconColor: appConstants.themeColor,
                      leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/side_menu/reminder.svg",
                          color: appConstants.themeColor,
                        ),
                      ),
                      title: Text(
                        listOfDrawerData[index].title,
                        style: TextStyle(
                          color: appConstants.themeColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      expandedAlignment: Alignment.centerLeft,
                      shape: Border.all(color: Colors.transparent, width: 0),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: commonVerticalDashLine(
                                height: 80.h,
                                width: 18.w,
                                color: appConstants.themeColor,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    listOfDrawerData[index].subList!.length,
                                    (subListIndx) {
                                      return GestureDetector(
                                        onTap: () {
                                          CommonRouter.pop();
                                          if (listOfDrawerData[index].subList![subListIndx].title == 'Birthday') {
                                            CommonRouter.pushNamed(
                                              listOfDrawerData[index].routeName,
                                              arguments: ReminderType.birthday,
                                            );
                                          } else if (listOfDrawerData[index].subList![subListIndx].title ==
                                              'Anniversary') {
                                            CommonRouter.pushNamed(
                                              listOfDrawerData[index].routeName,
                                              arguments: ReminderType.anniversary,
                                            );
                                          } else if (listOfDrawerData[index].subList![subListIndx].title == 'Events') {
                                            CommonRouter.pushNamed(
                                              listOfDrawerData[index].routeName,
                                              arguments: ReminderType.event,
                                            );
                                          } else {
                                            CommonRouter.pushNamed(listOfDrawerData[index].routeName);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 10.h),
                                          child: Text(
                                            listOfDrawerData[index].subList![subListIndx].title,
                                            style: TextStyle(color: appConstants.themeColor),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
      },
    ),
  );
}

Widget commonTile({
  required String text,
  required VoidCallback onTap,
  required String imagePath,
  required BuildContext context,
}) {
  return drawerCommonBox(
    onTap: () {
      CommonRouter.pop();
      onTap.call();
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
          CommonWidget.sizedBox(
            width: 20.w,
            child: CommonWidget.imageBuilder(
              imageUrl: svgPicturePath ?? '',
              fit: BoxFit.contain,
              height: 20.h,
              color: appConstants.themeColor,
            ),
          ),
          CommonWidget.sizedBox(width: 15.w),
          CommonWidget.commonText(text: text, style: TextStyle(color: appConstants.themeColor, fontSize: 18.sp)),
        ],
      ),
    ),
  );
}

class DrawerListModel {
  final String title;
  final String? image;
  final String routeName;
  List<DrawerListModel>? subList = [];

  DrawerListModel({
    required this.title,
    required this.routeName,
    this.image,
    this.subList,
  });
}

Widget commonVerticalDashLine({
  double? fontSize,
  double? height,
  double? width,
  FontWeight? fontWeight,
  Color? color,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const Text(
        "|",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 7),
      ),
    ),
  );
}
