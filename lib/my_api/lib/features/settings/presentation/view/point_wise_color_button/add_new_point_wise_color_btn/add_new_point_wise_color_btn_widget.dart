import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/point_wise_color_btn/point_wise_color_btn_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/add_new_point_wise_color_btn/add_new_point_wise_color_btn_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AddNewPointWiseColorBtnWidget extends State<AddNewPointWiseColorBtnScreen> {
  AddNewPointWiseColorBtnWidget();
  Color? selectedColors;

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget? appBar({required PointWiseColorBtnLoadedState state}) {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: state.isEdited == true
          ? TranslationConstants.edit.translate(context)
          : TranslationConstants.add_new.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget commonTextField({
    required String titleText,
    required String hintText,
    required TextEditingController controller,
    TextInputType? textInputType,
    double? borderRadius,
    Widget? prefixWidget,
    bool? isPrefixWidget,
    bool? readOnly,
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
          readOnly: readOnly,
          prefixWidget: prefixWidget,
          isPrefixWidget: isPrefixWidget,
          borderRadius: borderRadius ?? 5.0,
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

  Widget commonStatusButton({
    required int index,
    required String text,
    required VoidCallback onTap,
    required int state,
  }) {
    bool isSelected = (state == index);
    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 8.h),
      child: CommonWidget.commonButton(
        height: 35.h,
        width: 90.w,
        color: isSelected ? appConstants.lightBlue : appConstants.backGroundColor,
        borderColor: isSelected ? appConstants.editbuttonColor : appConstants.transparent,
        isBorder: true,
        borderRadius: 5.r,
        borderWidth: 1.5,
        context: context,
        onTap: onTap,
        child: Center(
          child: CommonWidget.commonText(
            text: text,
            color: isSelected ? appConstants.editbuttonColor : appConstants.neutral1Color,
            fontSize: 12.sp,
            bold: true,
          ),
        ),
      ),
    );
  }

  Widget status() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.status.translate(context),
          fontSize: 12.sp,
          bold: true,
        ),
        BlocBuilder<CounterCubit, int>(
          bloc: pointWiseColorBtnCubit.counterCubit,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) {
                  return commonStatusButton(
                    index: index,
                    state: state,
                    text: index == 0
                        ? TranslationConstants.active.translate(context)
                        : TranslationConstants.inactive.translate(context).toCamelcase(),
                    onTap: () => pointWiseColorBtnCubit.counterCubit.chanagePageIndex(index: index),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget colorCode({required PointWiseColorBtnLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.commonText(
            text: TranslationConstants.color_code.translate(context),
            fontSize: 12.sp,
            bold: true,
          ),
        ),
        CommonWidget.sizedBox(width: 10),
        selectedColorAndText(state: state),
      ],
    );
  }

  Widget selectedColorAndText({required PointWiseColorBtnLoadedState state}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: appConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(8),
              content: SingleChildScrollView(
                child: ColorPicker(
                  colorPickerWidth: ScreenUtil().screenWidth * 0.7,
                  pickerColor: appConstants.black,
                  onColorChanged: (value) {
                    selectedColors = value;
                  },
                  onApplyClicked: () {
                    pointWiseColorBtnCubit.onApplyClicked(state: state, colors: selectedColors);
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      },
      child: CommonWidget.container(
        height: 50.h,
        width: ScreenUtil().screenWidth,
        isBorder: true,
        borderColor: appConstants.borderColor2,
        borderRadius: 5.r,
        borderWidth: 2,
        child: Row(
          children: [
            SizedBox(width: 5.w),
            CommonWidget.container(
              padding: EdgeInsets.all(6.r),
              color: appConstants.lightBlue1,
              borderRadius: 3.r,
              child: Row(
                children: [
                  CommonWidget.container(
                    height: 20.h,
                    width: 20.w,
                    borderRadius: 3.r,
                    color: state.selectedColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: CommonWidget.commonText(
                      text: state.colorCode ?? "#0065CA",
                      color: appConstants.black,
                      fontSize: 10.sp,
                      bold: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CommonWidget.commonText(
                text: TranslationConstants.choose_color_code.translate(context),
                fontSize: 12.sp,
                color: appConstants.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButton({required PointWiseColorBtnLoadedState state}) {
    return GestureDetector(
      onTap: () {
        if (state.isEdited == true) {
          pointWiseColorBtnCubit.editListItem(
            state: state,
            index: state.index!,
            pointWiseColorBtnList: state.pointWiseColorBtnList,
          );
        } else {
          pointWiseColorBtnCubit.addNew(state: state);
        }
        CommonRouter.pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: CommonWidget.container(
          height: 45.h,
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
    );
  }
}
