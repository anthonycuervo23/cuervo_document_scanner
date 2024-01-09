// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/widgets/addres_common_widgets.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

Widget someoneElseTab({
  required AddAddressLoadedState state,
  required BuildContext context,
  required AddAddressCubit addAddressCubit,
  required AddressScreenArguments addressData,
  required GlobalKey<FormState> textFieldKey,
  required TextEditingController addressController,
  required TextEditingController flatNoController,
  required TextEditingController naerbyLandmarkController,
  required TextEditingController contactNameController,
  required TextEditingController contactNumberController,
}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CommonWidget.sizedBox(height: 10),
        AddressCommonWidgets.requideTitle(context: context, text: TranslationConstants.name.translate(context)),
        CommonWidget.sizedBox(
          child: Row(
            children: [
              Expanded(
                child: AddressCommonWidgets.commonAddressTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TranslationConstants.enter_your_name.translate(context);
                    }
                    return null;
                  },
                  context: context,
                  textInputType: TextInputType.streetAddress,
                  controller: contactNameController,
                  hintText: TranslationConstants.enter_name.translate(context),
                ),
              ),
              CommonWidget.sizedBox(width: 15),
              phoneNumberPiker(
                addAddressCubit: addAddressCubit,
                contactNameController: contactNameController,
                contactNumberController: contactNumberController,
                context: context,
              ),
            ],
          ),
        ),
        CommonWidget.sizedBox(height: 10),
        AddressCommonWidgets.requideTitle(
          context: context,
          text: TranslationConstants.mobile_number.translate(context),
        ),
        CommonWidget.sizedBox(height: 5),
        AddressCommonWidgets.commonAddressTextField(
          validator: (value) {
            if (value!.isEmpty) {
              return TranslationConstants.enter_mobile_number.translate(context);
            }
            return null;
          },
          maxLength: 10,
          context: context,
          controller: contactNumberController,
          isPrefixWidget: true,
          prefixWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.num_ninie_one.translate(context),
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
              )
            ],
          ),
          hintText: TranslationConstants.enter_mobile_number.translate(context),
        ),
        AddressCommonWidgets.commonAddressFiled(
          flatNoController: flatNoController,
          context: context,
          addressData: addressData,
          addAddressCubit: addAddressCubit,
          addressController: addressController,
          naerbyLandmarkController: naerbyLandmarkController,
        ),
        AddressCommonWidgets.saveAddressButton(
          context: context,
          textFieldKey: textFieldKey,
          addAddressCubit: addAddressCubit,
          state: state,
          addressData: addressData,
          addressController: addressController,
          flatNoController: flatNoController,
          naerbyLandmarkController: naerbyLandmarkController,
          contactNameController: contactNameController.text,
          contactNumberController: contactNumberController.text.replaceAll(' ', ''),
          addreesType: 'Someone Else',
        ),
        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      ],
    ),
  );
}

Column phoneNumberPiker({
  required AddAddressCubit addAddressCubit,
  required TextEditingController contactNameController,
  required TextEditingController contactNumberController,
  required BuildContext context,
}) {
  return Column(
    children: [
      CommonWidget.commonSvgIconButton(
        height: 30.h,
        svgPicturePath: "assets/photos/svg/address_screen/contact_icon.svg",
        onTap: () async {
          var permission = await Permission.contacts.request().isGranted;
          if (permission == true) {
            Contact? contact = await addAddressCubit.contactPicker.selectContact();
            if (contact?.fullName != '') {
              contactNameController.text = contact?.fullName ?? '';
              String data = "";
              data = (contact?.phoneNumbers![0][0] == "+"
                  ? contact?.phoneNumbers![0].replaceRange(0, 4, "")
                  : contact?.phoneNumbers![0])!;
              contactNumberController.text = data;
            }
          } else {
            CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.contact_permission_required.translate(context),
            );
          }
        },
      ),
      CommonWidget.commonText(
        text: TranslationConstants.Contacts.translate(context),
        style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
      )
    ],
  );
}
