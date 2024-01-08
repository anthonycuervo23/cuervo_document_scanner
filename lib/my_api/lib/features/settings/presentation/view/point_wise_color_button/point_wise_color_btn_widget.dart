import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/point_wise_color_btn/point_wise_color_btn_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/point_wise_color_btn_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class PointWiseColorBtnWidget extends State<PointWiseColorBtnScreen> {
  @override
  void initState() {
    pointWiseColorBtnCubit = getItInstance<PointWiseColorBtnCubit>();
    super.initState();
  }

  @override
  void dispose() {
    pointWiseColorBtnCubit.loadingCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.point_wise_color_button.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget listTitle() {
    return CommonWidget.container(
      height: 40.h,
      width: ScreenUtil().screenWidth,
      color: appConstants.theme1Color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        child: Row(
          children: [
            CommonWidget.commonText(
              text: "#",
              color: appConstants.white,
              fontSize: 10.sp,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: CommonWidget.commonText(
                text: TranslationConstants.mini_point.translate(context),
                color: appConstants.white,
                textAlign: TextAlign.start,
                fontSize: 10.sp,
              ),
            ),
            Expanded(
              flex: 2,
              child: CommonWidget.commonText(
                text: TranslationConstants.max_point.translate(context),
                color: appConstants.white,
                fontSize: 10.sp,
              ),
            ),
            Expanded(
              flex: 3,
              child: CommonWidget.commonText(
                text: TranslationConstants.color_code.translate(context),
                color: appConstants.white,
                fontSize: 10.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CommonWidget.commonText(
                text: TranslationConstants.action.translate(context),
                color: appConstants.white,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listOfAreaWithPincode({required PointWiseColorBtnLoadedState state}) {
    if (state.pointWiseColorBtnList.isNotEmpty) {
      return ListView.builder(
        itemCount: state.pointWiseColorBtnList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 40.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.r),
                  child: Row(
                    children: [
                      CommonWidget.commonText(
                        text: "${index + 1}",
                        color: appConstants.black,
                        fontSize: 12.sp,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: CommonWidget.commonText(
                          text: state.pointWiseColorBtnList[index].miniPoint,
                          color: appConstants.black,
                          textAlign: TextAlign.start,
                          fontSize: 12.sp,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CommonWidget.commonText(
                          text: state.pointWiseColorBtnList[index].maxPoint,
                          color: appConstants.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            CommonWidget.container(
                              height: 18,
                              width: 18,
                              borderRadius: 3,
                              color: state.pointWiseColorBtnList[index].seletcedColor,
                            ),
                            CommonWidget.sizedBox(width: 5.w),
                            CommonWidget.commonText(
                              text: state.pointWiseColorBtnList[index].colorCode,
                              color: appConstants.black,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CommonWidget.svgIconButton(
                          onTap: () {
                            pointWiseColorBtnCubit.editButtonClick(state: state, index: index);
                            CommonRouter.pushNamed(RouteList.add_new_point_wise_color_btn_screen, arguments: index);
                          },
                          svgPicturePath: 'assets/photos/svg/common/edit.svg',
                          color: appConstants.neutral1Color,
                          iconSize: 14.sp,
                        ),
                      ),
                      CommonWidget.svgIconButton(
                        svgPicturePath: 'assets/photos/svg/common/trash.svg',
                        color: appConstants.neutral1Color,
                        iconSize: 14.sp,
                        onTap: () {
                          pointWiseColorBtnCubit.deleteItem(
                            state: state,
                            itemIndex: index,
                            pointWiseColorBtnList: state.pointWiseColorBtnList,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: appConstants.dividerColor),
            ],
          );
        },
      );
    } else {
      return CommonWidget.dataNotFound(context: context);
    }
  }

  Widget addNewButton({required PointWiseColorBtnLoadedState state}) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(RouteList.add_new_point_wise_color_btn_screen),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 20.h),
        child: CommonWidget.container(
          height: 50,
          color: appConstants.theme1Color,
          borderRadius: 10.sp,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/add_icon.svg", height: 20),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                text: TranslationConstants.add_new.translate(context),
                color: appConstants.white,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
