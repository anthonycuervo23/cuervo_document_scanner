// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_state.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/add_details_screen/add_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/widget/marketing_text_form_field.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_image_pick_textfeild.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class AddAdsWidget extends State<AddAdsScreen> {
  late AddDeataisCubit addDeataisCubit;
  late PickImageCubit pickImageCubit;
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pickImageCubit = getItInstance<PickImageCubit>();
    addDeataisCubit = getItInstance<AddDeataisCubit>();
    addDeataisCubit.inilationLoading(selectedTab: widget.arguments.selectedTab);
    if (widget.arguments.marketingDataModel.startDate != "") {
      addDeataisCubit.marketingDataModel = widget.arguments.marketingDataModel;
      addDeataisCubit.fillModelData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    addDeataisCubit.loadingCubit.hide();
    addDeataisCubit.close();
  }

  PreferredSizeWidget? appbar(BuildContext context, {required AddDetailsLoadedState state}) {
    return CustomAppBar(
      context,
      title: widget.arguments.fromEditScreen
          ? TranslationConstants.edit_details.translate(context).toCamelcase()
          : TranslationConstants.add_details.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget tabbar(BuildContext context, AddDetailsLoadedState state) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: appConstants.shadowColor,
            spreadRadius: 3,
          )
        ],
        color: appConstants.white,
      ),
      child: Visibility(
        visible: widget.arguments.fromEditScreen ? false : true,
        child: TabBar(
          onTap: (value) => addDeataisCubit.inilationLoading(selectedTab: SelectedTab.values[value]),
          dividerColor: appConstants.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          indicatorColor: appConstants.editbuttonColor,
          tabs: [
            tab(
              state: state,
              title: TranslationConstants.banner.translate(context).toCamelcase(),
              selectedTab: SelectedTab.banner,
            ),
            tab(
              state: state,
              title: TranslationConstants.popup.translate(context).toCamelcase(),
              selectedTab: SelectedTab.popUp,
            ),
            tab(
              state: state,
              title: TranslationConstants.notification.translate(context).toCamelcase(),
              selectedTab: SelectedTab.notification,
            ),
          ],
        ),
      ),
    );
  }

  Widget tab({required AddDetailsLoadedState state, required String title, required SelectedTab selectedTab}) {
    return Tab(
      child: CommonWidget.commonText(
        text: title,
        fontSize: 14.sp,
        color: state.selectedTab == selectedTab ? appConstants.editbuttonColor : appConstants.black38,
      ),
    );
  }

  Widget tabView({required AddDetailsLoadedState state}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleAndTextFild(
              title: TranslationConstants.title.translate(context),
              hintText: TranslationConstants.marketing_cake_title.translate(context),
              textEditingController: addDeataisCubit.titleController,
            ),
            Visibility(
              visible: state.selectedTab.name == SelectedTab.notification.name,
              child: titleAndTextFild(
                title: TranslationConstants.short_description.translate(context),
                hintText: TranslationConstants.marketing_cake_short_descrption.translate(context),
                textEditingController: addDeataisCubit.shortDesController,
              ),
            ),
            uploadImage(),
            typeLink(state: state),
            titleAndTextFild(
              title: state.typeLink == TranslationConstants.in_app.translate(context)
                  ? TranslationConstants.show_app_link.translate(context)
                  : state.typeLink == TranslationConstants.whatsapp.translate(context)
                      ? TranslationConstants.mobile_number.translate(context)
                      : TranslationConstants.show_web_link.translate(context),
              hintText: state.typeLink == TranslationConstants.in_app.translate(context)
                  ? TranslationConstants.ex_in_app.translate(context)
                  : state.typeLink == TranslationConstants.whatsapp.translate(context)
                      ? TranslationConstants.ex_mobie_number.translate(context)
                      : TranslationConstants.ex_web_link.translate(context),
              textEditingController: addDeataisCubit.linkController,
              inputType:
                  state.typeLink == TranslationConstants.whatsapp.translate(context) ? TextInputType.phone : null,
            ),
            datePickView(state: state),
            statusView(state: state),
            Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
          ],
        ),
      ),
    );
  }

  Widget titleAndTextFild({
    required String title,
    required String hintText,
    required TextEditingController textEditingController,
    TextInputType? inputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldTitle(title: title),
        CommonWidget.sizedBox(height: 5.h),
        CommonWidget.sizedBox(
          // height: 53.h,
          child: marketingTextformfield(
            context: context,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return TranslationConstants.validtion.translate(context);
              }
              return null;
            },
            keyboardType: inputType ?? TextInputType.text,
            controller: textEditingController,
            hintText: hintText,
          ),
        ),
        CommonWidget.sizedBox(height: 10.h),
      ],
    );
  }

  Widget textFieldTitle({required String title}) {
    return CommonWidget.commonText(
      text: title,
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
  }

  Widget uploadImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldTitle(title: TranslationConstants.upload_image.translate(context)),
        CommonWidget.sizedBox(height: 5.h),
        CommonImagePickTextFeild(isMultipleImagePick: false, pickImageCubit: pickImageCubit),
      ],
    );
  }

  Widget typeLink({required AddDetailsLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldTitle(title: TranslationConstants.type_link.translate(context)),
        CommonWidget.sizedBox(height: 5.h),
        CustomDropdownButton(
          titleTextAlignment: Alignment.centerLeft,
          height: 96.h,
          useTextField: false,
          padding: EdgeInsets.all(11.h),
          selectedOptions: state.typeLink,
          style: TextStyle(fontSize: 15.sp),
          onOptionSelected: (v) {
            addDeataisCubit.changeTypeLink(state: state, value: v);
          },
          dataList: [
            TranslationConstants.whatsapp.translate(context),
            TranslationConstants.website.translate(context),
            TranslationConstants.in_app.translate(context),
          ],
        ),
        CommonWidget.sizedBox(height: 10.h)
      ],
    );
  }

  Widget datePickView({required AddDetailsLoadedState state}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldTitle(title: TranslationConstants.start_date.translate(context)),
            CommonWidget.sizedBox(height: 5.h),
            datePickerTextField(
              controller: addDeataisCubit.startDateController,
              hintText: TranslationConstants.enter_event_date_hint.translate(context),
              onTap: () async {
                final configSy = CalendarDatePicker2Config(
                  themeColor: appConstants.themeColor,
                  calendarType: CalendarDatePicker2Type.single,
                  applyButtonSize: Size(140.w, 45.h),
                  cancleButtonTextColor: appConstants.white,
                  weekNameTextStyle:
                      Theme.of(context).textTheme.caption2BookHeading.copyWith(color: appConstants.black),
                  notSelectedDataTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                        color: appConstants.black,
                      ),
                  selectedDataTextStyle:
                      Theme.of(context).textTheme.body2LightHeading.copyWith(color: appConstants.white),
                  cancleButtonSize: Size(140.w, 45.h),
                  spaceBetweenCalenderAndButtons: 15,
                  firstDate: addDeataisCubit.startDateController.text.isEmpty ? DateTime.now() : state.startDate,
                );
                List<DateTime?>? date = await CommonWidget.datePicker(
                  value: [state.startDate],
                  context: context,
                  lastDate: state.endDate?.subtract(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  config: configSy,
                );
                if (date != null) {
                  addDeataisCubit.startDatePicker(
                    date: date,
                    state: state,
                  );
                }
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldTitle(title: TranslationConstants.end_date.translate(context)),
            CommonWidget.sizedBox(height: 5.h),
            datePickerTextField(
              controller: addDeataisCubit.endDateController,
              hintText: TranslationConstants.enter_event_date_hint.translate(context),
              onTap: () async {
                final configSy = CalendarDatePicker2Config(
                  themeColor: appConstants.themeColor,
                  calendarType: CalendarDatePicker2Type.single,
                  applyButtonSize: Size(140.w, 45.h),
                  cancleButtonTextColor: appConstants.white,
                  weekNameTextStyle:
                      Theme.of(context).textTheme.caption2BookHeading.copyWith(color: appConstants.black),
                  notSelectedDataTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                        color: appConstants.black,
                      ),
                  selectedDataTextStyle:
                      Theme.of(context).textTheme.body2LightHeading.copyWith(color: appConstants.white),
                  cancleButtonSize: Size(140.w, 45.h),
                  spaceBetweenCalenderAndButtons: 15,
                  firstDate: state.startDate,
                );
                if (addDeataisCubit.startDateController.text.isNotEmpty) {
                  List<DateTime?>? date = await CommonWidget.datePicker(
                    context: context,
                    firstDate: state.startDate!.isAfter(DateTime.now()) ? state.startDate : DateTime.now(),
                    value: [addDeataisCubit.endDateController.text.isEmpty ? state.startDate : state.endDate],
                    config: configSy,
                  );

                  if (date != null && date[0]!.isAfter(DateTime.now())) {
                    if (DateFormat("mm-dd-yyyy")
                        .parse("${date[0]!}")
                        .isAfter(DateFormat("mm-dd-yyyy").parse("${state.startDate}"))) {
                      addDeataisCubit.endDatePicker(date: date, state: state);
                    } else {
                      CustomSnackbar.show(
                        snackbarType: SnackbarType.ERROR,
                        message: TranslationConstants.date_warning.translate(context),
                      );
                    }
                  } else {
                    if (state.endDate == DateTime.now().add(const Duration(days: 1))) {
                      CustomSnackbar.show(
                        snackbarType: SnackbarType.ERROR,
                        message: TranslationConstants.date_warning.translate(context),
                      );
                    }
                  }
                } else {
                  CustomSnackbar.show(
                    snackbarType: SnackbarType.ERROR,
                    message: TranslationConstants.select_start_date.translate(context),
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }

  Widget datePickerTextField(
      {required String hintText, required TextEditingController controller, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.435,
        child: marketingTextformfield(
          controller: controller,
          context: context,
          isEnable: false,
          hintText: hintText,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return TranslationConstants.validtion.translate(context);
            }
            return null;
          },
          suffixwidget: CommonWidget.container(
            width: 20.w,
            height: 20.h,
            color: appConstants.transparent,
            alignment: Alignment.center,
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/calender_icon.svg",
              height: 25.h,
              width: 25.w,
            ),
          ),
        ),
      ),
    );
  }

  Widget statusView({required AddDetailsLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 10.h),
        textFieldTitle(title: TranslationConstants.status.translate(context)),
        CommonWidget.sizedBox(height: 5.h),
        Row(
          children: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () => addDeataisCubit.changeStatus(state: state, value: true),
              child: CommonWidget.container(
                height: 35.h,
                width: 100.w,
                borderColor: state.status ? appConstants.editbuttonColor : appConstants.transparent,
                isBorder: true,
                borderWidth: 1.5,
                color: state.status ? appConstants.editbuttonColor.withOpacity(0.2) : appConstants.backgroundColor,
                borderRadius: 5.r,
                alignment: Alignment.center,
                child: CommonWidget.commonText(
                  text: TranslationConstants.active.translate(context).toCamelcase(),
                  color: state.status ? appConstants.editbuttonColor : appConstants.black,
                  fontSize: 13.sp,
                  bold: state.status ? true : false,
                ),
              ),
            ),
            CommonWidget.sizedBox(width: 12.w),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () => addDeataisCubit.changeStatus(state: state, value: false),
              child: CommonWidget.container(
                height: 35.h,
                width: 100.w,
                borderColor: state.status ? appConstants.transparent : appConstants.editbuttonColor,
                isBorder: true,
                borderWidth: 1.5,
                color: state.status ? appConstants.backgroundColor : appConstants.editbuttonColor.withOpacity(0.2),
                borderRadius: 5.r,
                alignment: Alignment.center,
                child: CommonWidget.commonText(
                  text: TranslationConstants.inactive.translate(context).toCamelcase(),
                  color: state.status ? appConstants.black : appConstants.editbuttonColor,
                  fontSize: 13.sp,
                  bold: state.status ? false : true,
                ),
              ),
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 10.h),
      ],
    );
  }

  Widget submitButton({required BuildContext context, required AddDetailsLoadedState state}) {
    return CommonWidget.commonButton(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      padding: EdgeInsets.all(15.h),
      width: double.infinity,
      color: appConstants.theme1Color,
      alignment: Alignment.center,
      borderRadius: 10.r,
      text: TranslationConstants.submit.translate(context),
      style: TextStyle(color: appConstants.white, fontSize: 15.sp),
      context: context,
      onTap: () {
        if (formKey.currentState!.validate()) {
          if (pickImageCubit.imageList.isNotEmpty) {
            if (state.typeLink != "Select link type") {
              CommonRouter.pop();
            } else {
              CustomSnackbar.show(
                snackbarType: SnackbarType.ERROR,
                message: TranslationConstants.select_link_type.translate(context),
              );
            }
          } else {
            CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.image_validtion.translate(context),
            );
          }
        }
      },
    );
  }
}
