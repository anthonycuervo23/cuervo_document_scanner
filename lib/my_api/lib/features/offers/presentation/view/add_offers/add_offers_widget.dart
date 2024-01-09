// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/add_offers/add_offers_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/add_offers/add_offers_state.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/add_offers/add_offers_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class AddOffersWidgets extends State<AddOffersScreen> {
  late AddOffersCubit addOffersCubitCubit;
  OfferDetailsModel? model;
  @override
  void initState() {
    super.initState();
    addOffersCubitCubit = getItInstance<AddOffersCubit>();
    model = widget.arguments;
    addOffersCubitCubit.loadcontroller(model: model!);
  }

  @override
  void dispose() {
    addOffersCubitCubit.close();
    super.dispose();
  }

  Widget textfileText({required String text}) {
    return CommonWidget.commonText(
      text: text,
      color: appConstants.neutral1Color,
      fontWeight: FontWeight.w600,
      fontSize: 11.sp,
    );
  }

  Widget datePickerTextField({
    required String hintText,
    required TextEditingController controller,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.435,
        child: textFormField(
          controller: controller,
          context: context,
          enabled: false,
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

  Widget radioButton({
    required BuildContext context,
    required String label,
    required dynamic groupValue,
    required dynamic radioButtonValue,
    required VoidCallback onTap,
    required void Function(dynamic) onChanged,
  }) {
    return SizedBox(
      height: 43.h,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: radioButtonValue == groupValue
                  ? TextStyle(
                      color: appConstants.editbuttonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    )
                  : TextStyle(
                      color: appConstants.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
            ),
            Radio(
              activeColor: appConstants.editbuttonColor,
              value: radioButtonValue,
              groupValue: groupValue,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return appConstants.editbuttonColor;
                  } else {
                    return const Color(0xff293847).withOpacity(0.2);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectDiscountBottomSheet({
    required String title,
    required AddOffersLoadedState state,
  }) {
    return openBottomBar(
      context: context,
      heightFactor: 0.25.h,
      child: Container(
        color: appConstants.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: appConstants.theme1Color,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.sp,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(),
                    child: Icon(Icons.close_rounded, size: 25.r, color: appConstants.theme1Color),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            BlocBuilder<AddOffersCubit, AddOffersState>(
              bloc: addOffersCubitCubit,
              builder: (context, state) {
                if (state is AddOffersLoadedState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      children: [
                        radioButton(
                          context: context,
                          label: "Percentage",
                          groupValue: addOffersCubitCubit.selectedDiscountValue,
                          radioButtonValue: 1,
                          onTap: () {
                            addOffersCubitCubit.updateDiscountValue(value: 1, state: state);
                            CommonRouter.pop();
                          },
                          onChanged: (value) {
                            addOffersCubitCubit.updateDiscountValue(value: value, state: state);
                            CommonRouter.pop();
                          },
                        ),
                        radioButton(
                          context: context,
                          label: "Discount",
                          onTap: () {
                            addOffersCubitCubit.updateDiscountValue(value: 2, state: state);
                            CommonRouter.pop();
                          },
                          groupValue: addOffersCubitCubit.selectedDiscountValue,
                          radioButtonValue: 2,
                          onChanged: (value) {
                            addOffersCubitCubit.updateDiscountValue(value: value, state: state);
                            CommonRouter.pop();
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is AddOffersLoadingState) {
                  return CommonWidget.loadingIos();
                } else if (state is AddOffersErrorState) {
                  return CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: state.errorMessage);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget datePickView({required AddOffersLoadedState state}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfileText(text: TranslationConstants.start_date.translate(context)),
            CommonWidget.sizedBox(height: 5.h),
            datePickerTextField(
              controller: addOffersCubitCubit.startDateController,
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
                  firstDate: addOffersCubitCubit.startDateController.text.isEmpty ? DateTime.now() : state.startDate,
                );
                List<DateTime?>? date = await CommonWidget.datePicker(
                  value: [state.startDate],
                  context: context,
                  lastDate: state.endDate?.subtract(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  config: configSy,
                );
                if (date != null) {
                  addOffersCubitCubit.startDatePicker(date: date, state: state);
                }
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfileText(text: TranslationConstants.end_date.translate(context)),
            CommonWidget.sizedBox(height: 5.h),
            datePickerTextField(
              controller: addOffersCubitCubit.endDateController,
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
                if (addOffersCubitCubit.startDateController.text.isNotEmpty) {
                  List<DateTime?>? date = await CommonWidget.datePicker(
                    context: context,
                    firstDate: state.startDate!.isAfter(DateTime.now()) ? state.startDate : DateTime.now(),
                    value: [
                      addOffersCubitCubit.endDateController.text.isEmpty ? state.startDate : state.endDate,
                    ],
                    config: configSy,
                  );

                  if (date != null && date[0]!.isAfter(DateTime.now())) {
                    if (DateFormat("mm-dd-yyyy")
                        .parse("${date[0]!}")
                        .isAfter(DateFormat("mm-dd-yyyy").parse("${state.startDate}"))) {
                      addOffersCubitCubit.endDatePicker(date: date, state: state);
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

  Column textfildAndLabel({
    required String title,
    required TextEditingController textEditingController,
    required String hint,
    TextCapitalization? textCapitalization,
    required TextInputType textInputType,
    int? maxline,
    bool? enabled,
    Widget? suffixwidget,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 5.h),
        textfileText(text: title),
        SizedBox(height: 5.h),
        textFormField(
            controller: textEditingController,
            hintText: hint,
            enabled: enabled ?? true,
            keyboardType: textInputType,
            validator: validator,
            suffixwidget: suffixwidget ?? const SizedBox.shrink(),
            context: context,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            maxline: maxline ?? 1),
        CommonWidget.sizedBox(height: 10.h),
      ],
    );
  }

  Widget textFormField({
    required TextEditingController controller,
    required dynamic hintText,
    required BuildContext context,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    VoidCallback? oncalenderTap,
    Color? fillcolor,
    Widget? suffixwidget,
    BoxConstraints? suffixIconConstraints,
    int? maxlength,
    int maxline = 1,
    bool readonly = false,
    bool? enabled,
    dynamic keyboardType,
    TextCapitalization? textCapitalization,
    VoidCallback? onTap,
    TextStyle? style,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    bool? issuffixWidget,
  }) {
    return TextFormField(
      cursorColor: appConstants.editbuttonColor,
      controller: controller,
      onTap: onTap,
      maxLines: maxline,
      validator: validator,
      onSaved: onSaved,
      maxLength: maxlength,
      readOnly: readonly,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType ?? keyboardType,
      style: style ??
          Theme.of(context).textTheme.body1BookHeading.copyWith(
                color: appConstants.textColor,
                fontSize: 13.sp,
              ),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        counterText: "",
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixwidget ?? const SizedBox.shrink(),
        hintStyle: Theme.of(context).textTheme.body1BookHeading.copyWith(
              color: appConstants.neutral6Color,
              fontSize: 13.sp,
            ),
        border: InputBorder.none,
        hintText: hintText,
        enabled: enabled ?? true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: appConstants.neutral6Color,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: appConstants.neutral6Color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: appConstants.theme1Color,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: appConstants.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: appConstants.theme1Color,
          ),
        ),
      ),
    );
  }
}
