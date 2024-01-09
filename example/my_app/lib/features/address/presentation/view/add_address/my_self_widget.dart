import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/widgets/addres_common_widgets.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget mySelfTab({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddressCommonWidgets.commonAddressFiled(
          flatNoController: flatNoController,
          context: context,
          addressData: addressData,
          addAddressCubit: addAddressCubit,
          addressController: addressController,
          naerbyLandmarkController: naerbyLandmarkController,
        ),
        CommonWidget.sizedBox(height: 15),
        CommonWidget.commonText(
          text: TranslationConstants.address_type.translate(context),
          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
        ),
        CommonWidget.sizedBox(height: 5),
        addressType(addAddressCubit, state, context),
        AddressCommonWidgets.saveAddressButton(
          context: context,
          textFieldKey: textFieldKey,
          addAddressCubit: addAddressCubit,
          state: state,
          addressData: addressData,
          addressController: addressController,
          flatNoController: flatNoController,
          naerbyLandmarkController: naerbyLandmarkController,
          contactNameController: userEntity?.name ?? '',
          contactNumberController: userEntity?.mobile ?? '',
          addreesType: state.addAddressType.name.toCamelcase(),
        ),
        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      ],
    ),
  );
}

Widget addressType(AddAddressCubit addAddressCubit, AddAddressLoadedState state, BuildContext context) {
  return Row(
    children: List.generate(
      AddAddressType.values.length - 1,
      (index) => CommonWidget.container(
        height: 40,
        padding: EdgeInsets.only(right: 8.w),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            addAddressCubit.changeAddressType(
              addAddressType: AddAddressType.values[index],
              state: state,
            );
          },
          child: CommonWidget.container(
            width: 75,
            marginAllSide: 3.h,
            color: state.addAddressType == AddAddressType.values[index]
                ? appConstants.secondary2Color
                : appConstants.whiteBackgroundColor,
            borderColor: state.addAddressType == AddAddressType.values[index]
                ? appConstants.primary1Color
                : appConstants.default6Color,
            borderRadius: appConstants.buttonRadius,
            borderWidth: 0.7,
            isBorder: true,
            alignment: Alignment.center,
            child: CommonWidget.commonText(
              text: AddAddressType.values[index].name.toCamelcase(),
              style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
          ),
        ),
      ),
    ),
  );
}
