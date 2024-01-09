// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressCommonWidgets {
  static Widget saveAddressButton({
    required BuildContext context,
    required GlobalKey<FormState> textFieldKey,
    required AddAddressCubit addAddressCubit,
    required AddAddressLoadedState state,
    required AddressScreenArguments addressData,
    required TextEditingController addressController,
    required TextEditingController flatNoController,
    required TextEditingController naerbyLandmarkController,
    required String contactNameController,
    required String contactNumberController,
    required String addreesType,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 45.h, bottom: 20.h),
      child: CommonWidget.commonButton(
        onTap: () {
          if (textFieldKey.currentState!.validate()) {
            addAddressCubit.addAddressDetail(
              state: state,
              id: addressData.id,
              name: contactNameController,
              mobile: contactNumberController,
              floatNo: flatNoController.text,
              landmark: naerbyLandmarkController.text,
              addressController: addressController.text,
              addressType: addreesType,
            );
          }
        },
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
        color: appConstants.primary1Color,
        alignment: Alignment.center,
        text: TranslationConstants.save_address.translate(context).replaceAll("A", "a"),
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
              color: appConstants.buttonTextColor,
            ),
        context: context,
      ),
    );
  }

  static commonAddressFiled({
    required TextEditingController flatNoController,
    required BuildContext context,
    required AddressScreenArguments addressData,
    required AddAddressCubit addAddressCubit,
    required TextEditingController addressController,
    required TextEditingController naerbyLandmarkController,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 15),
        requideTitle(context: context, text: TranslationConstants.flat_no_building_name.translate(context)),
        CommonWidget.sizedBox(height: 5),
        AddressCommonWidgets.commonAddressTextField(
          controller: flatNoController,
          context: context,
          textInputType: TextInputType.streetAddress,
          isPrefixWidget: true,
          hintText: TranslationConstants.enter_flat_house_no.translate(context),
          validator: (value) {
            if (value!.isEmpty) {
              return TranslationConstants.enter_your_flat_number.translate(context);
            }
            return null;
          },
        ),
        CommonWidget.sizedBox(height: 15),
        requideTitle(context: context, text: TranslationConstants.area_locality.translate(context)),
        CommonWidget.sizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            PermissionStatus status = await Permission.location.request();
            if (status.isGranted) {
              if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                var args = await CommonRouter.pushNamed(
                  RouteList.location_picker_screen,
                  arguments: LoactionArguments(
                    checkLoactionNavigator: CheckLoactionNavigation.cart,
                    isNew: addressData.isNew,
                  ),
                );
                if (args is AddressScreenArguments) {
                  addAddressCubit.cityName = args.cityName ?? '';
                  addAddressCubit.stateName = args.stateName ?? '';
                  addAddressCubit.countryName = args.countryName ?? '';
                  addAddressCubit.pinCode = args.pinCode ?? '';
                  addAddressCubit.fullAddress = args.fullAddress;
                  addressController.text = args.fullAddress;
                  addAddressCubit.args = args;
                }
              } else {
                CustomSnackbar.show(
                  snackbarType: SnackbarType.ERROR,
                  message: TranslationConstants.please_enalble_location.translate(context),
                );
              }
            } else if (status.isPermanentlyDenied) {
              CustomSnackbar.show(
                snackbarType: SnackbarType.ERROR,
                message: TranslationConstants.location_permission_required.translate(context),
              );
              await Future.delayed(const Duration(seconds: 1)).then((value) => openAppSettings());
            } else {
              CustomSnackbar.show(
                snackbarType: SnackbarType.ERROR,
                message: TranslationConstants.location_permission_required.translate(context),
              );
            }
          },
          child: CommonWidget.locationTextFiled(controller: addressController, context: context),
        ),
        CommonWidget.sizedBox(height: 15),
        Row(
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.nearby_landmark.translate(context),
              style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
            ),
            CommonWidget.commonText(
              text: " (${TranslationConstants.optional.translate(context)})",
              style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default5Color),
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 5),
        AddressCommonWidgets.commonAddressTextField(
          controller: naerbyLandmarkController,
          context: context,
          textInputType: TextInputType.streetAddress,
          isPrefixWidget: true,
          hintText: TranslationConstants.enter_nearby.translate(context),
        ),
      ],
    );
  }

  static Row requideTitle({required BuildContext context, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: text,
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
        ),
        CommonWidget.commonRequiredStatr(context: context),
      ],
    );
  }

  static Widget commonAddressTextField({
    required BuildContext context,
    dynamic validator,
    bool enabled = true,
    Color? hintTextColor,
    TextEditingController? controller,
    bool? isPrefixWidget,
    Widget? prefixWidget,
    int? maxLength,
    TextInputType? textInputType,
    String? hintText,
  }) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 25),
      onTapOutside: (event) => CommonWidget.keyboardClose(context: context),
      validator: validator,
      enabled: enabled,
      maxLines: 5,
      minLines: 1,
      obscureText: false,
      textInputAction: TextInputAction.done,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.number,
      autofocus: false,
      maxLength: maxLength ?? 150,
      style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: appConstants.textFiledColor,
        prefixIcon: isPrefixWidget == true ? prefixWidget : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.default6Color),
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.requiredColor),
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.primary1Color),
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.primary1Color),
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.default6Color),
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        counterText: "",
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.captionBookHeading.copyWith(
              color: hintTextColor ?? appConstants.default5Color,
            ),
      ),
    );
  }
}
