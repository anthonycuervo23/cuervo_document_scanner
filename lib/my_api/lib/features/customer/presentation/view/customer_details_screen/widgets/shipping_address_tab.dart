import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/handle_location_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_view_cubit/customer_view_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget shippingAddressTab({
  required CustomerViewLoadedState state,
  required CustomerViewCubit customerViewCubit,
  required CustomerDetailModel customerDetailModel,
}) {
  return ListView.builder(
    itemCount: state.addressList.length,
    itemBuilder: (context, index) => CommonWidget.container(
      margin: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
      borderRadius: 10.r,
      shadow: [
        BoxShadow(color: appConstants.black12, blurRadius: 1, offset: const Offset(0, 2)),
      ],
      color: appConstants.white,
      padding: EdgeInsets.all(10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: state.addressList[index].addressType.name.toCamelcase(),
                style: Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.textColor),
              ),
              CommonWidget.sizedBox(
                width: 250,
                child: CommonWidget.commonText(
                  textAlign: TextAlign.left,
                  text: state.addressList[index].adddress,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption1LightHeading.copyWith(color: appConstants.black45),
                ),
              ),
            ],
          ),
          Row(
            children: [
              CommonWidget.svgIconButton(
                svgPicturePath: 'assets/photos/svg/common/edit.svg',
                onTap: () async {
                  AddressData? address = (await CommonRouter.pushNamed(RouteList.handle_location_screen,
                      arguments: HandleLocationArgs(
                        navigateFrom: CheckLoactionNavigation.updateAddress,
                        flanNo: state.addressList[index].flatNo,
                        address: state.addressList[index].adddress,
                        landmark: state.addressList[index].landMark,
                        addresstype: state.addressList[index].addressType,
                      ))) as AddressData?;
                  if (address != null) {
                    customerViewCubit.updateAddress(address: address, state: state, index: index);
                  }
                },
              ),
              CommonWidget.sizedBox(width: 15),
              CommonWidget.svgIconButton(
                svgPicturePath: 'assets/photos/svg/common/bin.svg',
                iconSize: 20.h,
                onTap: () {
                  CommonWidget.showAlertDialog(
                      context: context,
                      onTap: () {
                        // customerViewCubit.deleteCustomer(customerDetailModel: customerDetailModel);
                        customerViewCubit.removeAddress(index: index);
                        CommonRouter.pop();
                      },
                      titleText: TranslationConstants.confirm_delete.translate(context),
                      isTitle: true,
                      text: TranslationConstants.sure_delete_address.translate(context),
                      maxLines: 2,
                      leftColor: appConstants.theme1Color,
                      leftTextColor: appConstants.white,
                      titleTextStyle: TextStyle(color: appConstants.theme1Color, fontWeight: FontWeight.bold));
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
