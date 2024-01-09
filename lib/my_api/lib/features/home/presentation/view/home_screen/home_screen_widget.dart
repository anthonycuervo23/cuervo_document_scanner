import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/home_screen/home_screen_view.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

abstract class HomeScreenWidget extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget dashboardDetails() {
    final double verticalPadding = 15.h;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.dashboard.translate(context),
            style: TextStyle(
              fontSize: 18.sp,
              color: appConstants.themeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            child: ResponsiveGridList(
              horizontalGridMargin: verticalPadding,
              verticalGridMargin: verticalPadding,
              minItemWidth: 200,
              listViewBuilderOptions: ListViewBuilderOptions(shrinkWrap: true, primary: false),
              children: List.generate(
                8,
                (index) => orderDetailBox(index: index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderDetailBox({required int index}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: dashBoardGridview[index].withOpacity(0.15),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CommonWidget.commonText(
                text: "Supplier Pending Order",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: dashBoardGridview[index],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            CommonWidget.commonText(
              text: "₹100",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: appConstants.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionsHere(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/dash_screen/transaction_icon.svg",
            height: 55.h,
          ),
          SizedBox(height: 10.h),
          Text(
            TranslationConstants.transactions_here.translate(context),
            style: TextStyle(
              fontSize: newDeviceType == NewDeviceType.web ? 10.sp : 12.sp,
              color: appConstants.theme6Color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> dashBoardGridview = const [
    Color.fromRGBO(255, 176, 56, 1),
    Color.fromRGBO(41, 164, 102, 1),
    Color.fromRGBO(106, 82, 255, 1),
    Color.fromRGBO(255, 95, 172, 1),
    Color.fromRGBO(85, 153, 255, 1),
    Color.fromRGBO(215, 103, 255, 1),
    Color.fromRGBO(255, 61, 61, 1),
    Color.fromRGBO(64, 61, 255, 1),
  ];
}
