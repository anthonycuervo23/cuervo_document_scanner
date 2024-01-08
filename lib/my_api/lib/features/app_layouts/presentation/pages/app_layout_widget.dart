import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/cubit/app_layouts_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/pages/app_layout_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppLayoutWidget extends State<AppLayoutsScreen> {
  late AppLayoutsCubit appLayoutsCubit;
  Color? selectedColors;

  final List<String> fontNames = [
    "Poppins",
    "Open Sans",
    "Lato",
    "Montserrat",
    "Roboto",
    "Poppinscxc",
    "Open Sansxcxc",
    "Latoxcxc",
    "Montserratxcxc",
    "Robotoxcc",
  ];

  @override
  void initState() {
    appLayoutsCubit = getItInstance<AppLayoutsCubit>();
    appLayoutsCubit.initialDataLoad();
    super.initState();
  }

  @override
  void dispose() {
    appLayoutsCubit.pickImageCubitCubit.close();
    appLayoutsCubit.counterCubit.close();
    appLayoutsCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar(BuildContext context, {required AppLayoutsLoadedState state}) {
    return CustomAppBar(
      titleCenter: false,
      elevation: 0.5,
      shadowcolor: appConstants.grey,
      iconColor: appConstants.neutral1Color,
      context,
      title: TranslationConstants.app_layout.translate(context),
      onTap: () => CommonRouter.pop(),
      trailing: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CommonWidget.commonButton(
          borderRadius: 20.r,
          text: TranslationConstants.save.translate(context),
          color: appConstants.theme1Color,
          context: context,
          textColor: appConstants.white,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          alignment: Alignment.center,
          onTap: () => CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: "Saved"),
        ),
      ),
    );
  }

  Widget uploadLogo({required AppLayoutsLoadedState state}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.r),
          child: GestureDetector(
            onTap: () async {
              appLayoutsCubit.uploadLogo(state: state);
            },
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: appLayoutsCubit.pickImageCubitCubit.imageList.isNotEmpty
                  ? CommonWidget.imageBuilder(
                      imageUrl: appLayoutsCubit.pickImageCubitCubit.imageList[0].path,
                      borderRadius: 10,
                    )
                  : CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/upload.svg",
                      borderRadius: 10,
                    ),
            ),
          ),
        ),
        CommonWidget.commonText(
          text: TranslationConstants.upload_logo.translate(context),
          color: appConstants.neutral1Color,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.r),
          child: CommonWidget.commonText(
            text: TranslationConstants.file_size_5_mb_upload.translate(context),
            color: appConstants.lightGrey,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget imageList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.r),
      child: CommonWidget.container(
        borderRadius: 8.r,
        height: 85.h,
        width: ScreenUtil().screenWidth,
        isBorder: true,
        borderColor: appConstants.greyBorder,
        child: appLayoutsCubit.pickImageCubitCubit.imageList.isNotEmpty
            ? Row(
                children: List.generate(
                  appLayoutsCubit.pickImageCubitCubit.imageList.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CommonWidget.imageBuilder(
                          imageUrl: appLayoutsCubit.pickImageCubitCubit.imageList[0].path,
                          borderRadius: 6.r,
                        ),
                      ),
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget themeMode() {
    return BlocBuilder<CounterCubit, int>(
      bloc: appLayoutsCubit.counterCubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.theme_mode.translate(context),
              color: appConstants.neutral1Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            Row(
              children: List.generate(
                2,
                (index) {
                  return commonThemeModeButton(
                    index: index,
                    state: state,
                    text: index == 0
                        ? TranslationConstants.light.translate(context)
                        : TranslationConstants.dark.translate(context),
                    imagePath: index == 0
                        ? "assets/photos/svg/common/light_theme.svg"
                        : "assets/photos/svg/common/dark_theme.svg",
                    onTap: () => appLayoutsCubit.counterCubit.chanagePageIndex(index: index),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget commonThemeModeButton({
    required int index,
    required String text,
    required String imagePath,
    required VoidCallback onTap,
    required int state,
  }) {
    bool isSelected = (state == index);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonWidget.commonButton(
        height: 30.h,
        width: 70.w,
        color: isSelected ? appConstants.lightBlue : appConstants.backGroundColor,
        borderColor: isSelected ? appConstants.editbuttonColor : appConstants.transparent,
        isBorder: true,
        borderRadius: 5.r,
        borderWidth: 1.5,
        context: context,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.svgPicture(
              isChangeColor: true,
              height: 14.sp,
              svgPicturePath: imagePath,
              color: isSelected ? appConstants.editbuttonColor : appConstants.neutral1Color,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.r),
              child: CommonWidget.commonText(
                  text: text,
                  color: isSelected ? appConstants.editbuttonColor : appConstants.neutral1Color,
                  fontSize: 12.sp,
                  bold: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget themeColor({required AppLayoutsLoadedState state}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(
              text: TranslationConstants.theme_color.translate(context),
              color: appConstants.neutral1Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonThemeColorButton(
              text: state.primaryColorText,
              color: state.primaryColor,
              state: state,
              index: 0,
            ),
            commonThemeColorButton(
              text: state.secondoryColorText,
              color: state.secendoryColor,
              state: state,
              index: 1,
            ),
            commonThemeColorButton(
              text: state.defualtColorText,
              color: state.defualtColor,
              state: state,
              index: 2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonThemeColorName(text: TranslationConstants.primary.translate(context)),
              commonThemeColorName(text: TranslationConstants.secondary.translate(context)),
              commonThemeColorName(text: TranslationConstants.defaultt.translate(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget commonThemeColorButton({
    required String text,
    required Color color,
    required AppLayoutsLoadedState state,
    required int index,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: CommonWidget.commonButton(
          height: 35.h,
          color: appConstants.white,
          borderColor: appConstants.greyBorder,
          isBorder: true,
          borderRadius: 5.r,
          borderWidth: 1.5,
          context: context,
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
                      pickerColor: color,
                      onColorChanged: (value) {
                        selectedColors = value;
                        // appLayoutsCubit.onColorChanged(pickcolor: value, state: state);
                      },
                      onApplyClicked: () {
                        appLayoutsCubit.onApplyClicked(state: state, index: index, colors: selectedColors);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.container(
                height: 22.h,
                width: 22.w,
                borderRadius: 3.r,
                color: color,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: CommonWidget.commonText(
                  text: text,
                  color: appConstants.grey,
                  fontSize: 10.sp,
                  bold: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonThemeColorName({required String text}) {
    return CommonWidget.commonText(
      text: text,
      color: appConstants.neutral1Color,
      fontSize: 12.sp,
      bold: true,
    );
  }

  Widget fontFamilyDropDown() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(
              text: TranslationConstants.font_family.translate(context),
              color: appConstants.neutral1Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomDropdownButton(
          useTextField: true,
          height: 200.h,
          mainContainerRadius: 5.0,
          selectedOptions: "Poppins",
          padding: EdgeInsets.all(10.r),
          scrolllingHeight: 132.h,
          style: TextStyle(
            color: appConstants.neutral1Color,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
          titleTextAlignment: Alignment.centerLeft,
          dataList: fontNames,
          onOptionSelected: (String option) {},
        ),
      ],
    );
  }

  Widget buttonStyle({required AppLayoutsLoadedState state}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(
              text: TranslationConstants.button_style.translate(context),
              color: appConstants.neutral1Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            commonCheckBox(
              state: state,
              checkbox: Checkbox(
                value: state.buttonStyleCheckBox,
                activeColor: appConstants.editbuttonColor,
                onChanged: (value) {
                  if (value != null) {
                    appLayoutsCubit.onCheckBoxChange(value: true, state: state);
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () => appLayoutsCubit.onCheckBoxChange(value: true, state: state),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.container(
                  height: 25.h,
                  width: 60.w,
                  isBorder: true,
                  borderColor: state.buttonStyleCheckBox == true ? appConstants.greyBorder1 : appConstants.greyBorder,
                  borderRadius: 5.sp,
                ),
              ),
            ),
            commonCheckBox(
              state: state,
              checkbox: Checkbox(
                value: (!state.buttonStyleCheckBox),
                activeColor: appConstants.editbuttonColor,
                onChanged: (value) {
                  if (value != null) {
                    appLayoutsCubit.onCheckBoxChange(value: false, state: state);
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () => appLayoutsCubit.onCheckBoxChange(value: false, state: state),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.container(
                  height: 25.h,
                  width: 60.w,
                  isBorder: true,
                  borderColor: !state.buttonStyleCheckBox ? appConstants.greyBorder1 : appConstants.greyBorder,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ],
    );
  }

  Widget commonCheckBox({required AppLayoutsLoadedState state, required Checkbox checkbox}) {
    return SizedBox(
      height: 30.h,
      width: 30.w,
      child: Theme(
        data: ThemeData(
          checkboxTheme: CheckboxThemeData(
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(color: Colors.transparent),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              side: BorderSide.none,
            ),
            fillColor: MaterialStateProperty.all<Color>(appConstants.greyBorder),
          ),
        ),
        child: Transform.scale(scale: 1.2, child: checkbox),
      ),
    );
  }
}
