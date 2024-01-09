import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/area_with_pincode/area_with_pincode_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/area_with_pincode/area_with_pincode_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AreaWithPinCodeWidget extends State<AreaWithPinCodeScreen> {
  late AreaWithPincodeCubit areaWithPincodeCubit;

  @override
  void initState() {
    areaWithPincodeCubit = getItInstance<AreaWithPincodeCubit>();

    super.initState();
  }

  @override
  void dispose() {
    areaWithPincodeCubit.loadingCubit.hide();
    areaWithPincodeCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.area_with_pin_code.translate(context),
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
        padding: EdgeInsets.symmetric(horizontal: 5.r),
        child: Row(
          children: [
            CommonWidget.commonText(
              text: "#",
              color: appConstants.white,
              fontSize: 12.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 4,
              child: CommonWidget.commonText(
                text: TranslationConstants.delivery_area_with_name.translate(context),
                color: appConstants.white,
                textAlign: TextAlign.start,
                fontSize: 12.sp,
              ),
            ),
            Expanded(
              flex: 3,
              child: CommonWidget.commonText(
                text: TranslationConstants.pin_code.translate(context),
                color: appConstants.white,
                fontSize: 12.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CommonWidget.commonText(
                text: TranslationConstants.action.translate(context),
                color: appConstants.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listOfAreaWithPincode({required AreaWithPincodeLoadedState state}) {
    if (state.areaWithPincodeList.isNotEmpty) {
      return ListView.builder(
        itemCount: state.areaWithPincodeList.length,
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
                        flex: 4,
                        child: CommonWidget.commonText(
                          text: state.areaWithPincodeList[index].areaName,
                          color: appConstants.black,
                          textAlign: TextAlign.start,
                          fontSize: 12.sp,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CommonWidget.commonText(
                          text: state.areaWithPincodeList[index].pinCode,
                          color: appConstants.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CommonWidget.svgIconButton(
                            onTap: () {
                              areaWithPincodeCubit.editButtonClick(state: state, index: index);
                              bottomSheetView(state: state, index: index);
                            },
                            svgPicturePath: 'assets/photos/svg/common/edit.svg',
                            color: appConstants.neutral1Color,
                            iconSize: 14.sp),
                      ),
                      CommonWidget.svgIconButton(
                        svgPicturePath: 'assets/photos/svg/common/trash.svg',
                        color: appConstants.neutral1Color,
                        iconSize: 14.sp,
                        onTap: () {
                          areaWithPincodeCubit.deleteItem(
                            state: state,
                            itemIndex: index,
                            areaWithPincodeList: state.areaWithPincodeList,
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
      return const SizedBox.shrink();
    }
  }

  Widget addNewButton({required AreaWithPincodeLoadedState state}) {
    return GestureDetector(
      onTap: () {
        bottomSheetView(state: state, index: 0);
      },
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

  Future bottomSheetView({required AreaWithPincodeLoadedState state, required int index}) {
    return openBottomBar(
      context: context,
      backgroundColor: appConstants.drawerBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
            child: Row(
              children: [
                Text(
                  state.isEdited == true
                      ? TranslationConstants.edit.translate(context)
                      : TranslationConstants.add_new.translate(context),
                  style: TextStyle(
                    color: appConstants.theme1Color,
                    fontWeight: FontWeight.w800,
                    fontSize: 13.sp,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    CommonRouter.pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 25.r,
                    color: appConstants.theme1Color,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: appConstants.dividerColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              children: [
                commonTextField(
                  textInputType: TextInputType.streetAddress,
                  titleText: TranslationConstants.area_name.translate(context),
                  hintText: TranslationConstants.ex_yogi_chowk.translate(context),
                  controller: areaWithPincodeCubit.areaNameController,
                ),
                CommonWidget.sizedBox(width: 10),
                commonTextField(
                  textInputType: TextInputType.number,
                  titleText: TranslationConstants.pin_code.translate(context),
                  hintText: TranslationConstants.ex_395006.translate(context),
                  controller: areaWithPincodeCubit.pinCodeController,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (state.isEdited == true) {
                areaWithPincodeCubit.editListItem(
                  state: state,
                  itemIndex: index,
                  areaWithPincodeList: state.areaWithPincodeList,
                );
              } else {
                areaWithPincodeCubit.addNew(state: state);
              }

              CommonRouter.pop();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: CommonWidget.container(
                height: 40.h,
                color: appConstants.theme1Color,
                borderRadius: 5.sp,
                alignment: Alignment.center,
                child: CommonWidget.commonText(
                  text: TranslationConstants.submit.translate(context),
                  color: appConstants.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonTextField({
    required String titleText,
    required String hintText,
    required TextEditingController controller,
    TextInputType? textInputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: titleText,
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        CommonWidget.textField(
          controller: controller,
          textInputType: textInputType,
          fillColor: appConstants.drawerBackgroundColor,
          hintText: hintText,
          hintSize: 12.sp,
          contentPadding: EdgeInsets.only(left: 12.w),
          borderColor: appConstants.textFiledColor,
        ),
      ],
    );
  }
}
