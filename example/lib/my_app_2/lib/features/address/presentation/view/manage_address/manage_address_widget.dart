// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/address/data/models/manage_address_model.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/manage_address/manage_address_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ManageAddressWidget extends State<ManageAddressScreen> {
  @override
  void initState() {
    addAddressCubit = getItInstance<AddAddressCubit>();
    addAddressCubit.loadInitialData(isLoadingShow: false);
    super.initState();
  }

  @override
  void dispose() {
    addAddressCubit.loadingCubit.hide();
    addAddressCubit.close();
    super.dispose();
  }

  Widget image() {
    return CommonWidget.container(
      color: appConstants.greyBackgroundColor,
      width: ScreenUtil().screenWidth,
      height: 130,
      child: CommonWidget.imageBuilder(
        imageUrl: "assets/photos/png/address_screen/delivery_to.png",
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget addAddressButton(BuildContext context) {
    return PhysicalShape(
      color: appConstants.whiteBackgroundColor,
      elevation: 5,
      shadowColor: appConstants.default6Color,
      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(borderRadius: CommonWidget.boaderRadius(appConstants.buttonRadius)),
      ),
      child: ListTile(
        tileColor: appConstants.whiteBackgroundColor,
        splashColor: Colors.transparent,
        leading: CommonWidget.imageBuilder(
          imageUrl: "assets/photos/svg/setting_screen/address_screen/add_address.svg",
          height: 22.h,
        ),
        title: CommonWidget.commonText(
          text: TranslationConstants.add_address.translate(context),
          color: appConstants.primary1Color,
          style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.primary1Color),
        ),
        trailing: CommonWidget.imageBuilder(
          imageUrl: "assets/photos/svg/common/right_arrow.svg",
          color: appConstants.primary1Color,
          height: 16.h,
        ),
        onTap: () async {
          PermissionStatus status = await Permission.location.request();
          if (status.isGranted) {
            if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
              await CommonRouter.pushNamed(
                RouteList.location_picker_screen,
                arguments: const LoactionArguments(
                  checkLoactionNavigator: CheckLoactionNavigation.addAddress,
                  isNew: true,
                ),
              );
              // addAddressCubit.loadInitialData();
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
      ),
    );
  }

  Widget addressesList({required BuildContext context, required AddAddressLoadedState state}) {
    return state.manageAddressEntity != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.deliver_to.translate(context)}...",
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                primary: false,
                itemCount: state.manageAddressEntity!.addresses.length,
                itemBuilder: (context, index) {
                  AddressDetailes addressDetailes = state.manageAddressEntity!.addresses[index];
                  return addressView(state: state, addressDetailes: addressDetailes);
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget addressView({
    required AddAddressLoadedState state,
    required AddressDetailes addressDetailes,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          if (addressDetailes.isDefaultAddress) {
            CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: 'This address is defaulted to already.');
          } else {
            addAddressCubit.setDefaultAddress(id: addressDetailes.id, state: state);
          }
        },
        splashFactory: NoSplash.splashFactory,
        child: CommonWidget.container(
          borderColor: appConstants.default7Color,
          borderWidth: 1,
          color: addressDetailes.isDefaultAddress == false
              ? appConstants.whiteBackgroundColor
              : appConstants.secondary2Color,
          borderRadius: appConstants.buttonRadius,
          isBorder: addressDetailes.isDefaultAddress == false ? true : false,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                distantCount(state: state, addressDetailes: addressDetailes),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.sizedBox(height: 3),
                        addressType(state: state, addressDetailes: addressDetailes),
                        CommonWidget.sizedBox(height: 6),
                        contactDetails(state: state, addressDetailes: addressDetailes),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 60.h, maxWidth: 250.w),
                          child: CommonWidget.commonText(
                            maxLines: 3,
                            text: addressDetailes.fullAddress,
                            textOverflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                  color: appConstants.default3Color,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addressType({required AddAddressLoadedState state, required AddressDetailes addressDetailes}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: addressDetailes.isDefaultAddress
                      ? ScreenUtil().screenWidth * 0.35
                      : ScreenUtil().screenWidth * 0.5),
              child: CommonWidget.commonText(
                text: addressDetailes.addresstype != AddAddressType.someone_Else
                    ? addressDetailes.addresstype.name.toCamelcase()
                    : addressDetailes.name.toCamelcase(),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
              ),
            ),
            Visibility(
              visible: addressDetailes.isDefaultAddress == true,
              child: CommonWidget.commonText(
                text: TranslationConstants.default_.translate(context),
                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default4Color),
              ),
            ),
          ],
        ),
        iconsButtons(state: state, addressDetailes: addressDetailes),
      ],
    );
  }

  Widget iconsButtons({
    required AddAddressLoadedState state,
    required AddressDetailes addressDetailes,
  }) {
    return Row(
      children: [
        iconImage(
          color: appConstants.primary1Color,
          imageUrl: "assets/photos/svg/setting_screen/address_screen/edit_pen.svg",
          onTap: () async {
            AddressScreenArguments addressScreenArguments = AddressScreenArguments(
              longitude: 0,
              latitude: 0,
              isNew: false,
              id: addressDetailes.id,
              name: addressDetailes.name,
              mobile: addressDetailes.mobileNo,
              floatNo: addressDetailes.address.flatNo,
              landmark: addressDetailes.address.landmark,
              aeriaName: addressDetailes.address.landmark,
              cityName: addressDetailes.address.city,
              stateName: addressDetailes.address.state,
              countryName: addressDetailes.address.country,
              pinCode: addressDetailes.address.zipCode,
              fullAddress: addressDetailes.fullAddress
                  .replaceAll('${addressDetailes.address.flatNo}, ', '')
                  .replaceAll(addressDetailes.address.landmark, '')
                  .replaceAll(', ,', ','),
              addresstype: addressDetailes.addresstype.name,
            );

            await CommonRouter.pushNamed(
              RouteList.add_address_screen,
              arguments: addressScreenArguments,
            );
          },
        ),
        iconImage(
          imageUrl: "assets/photos/svg/setting_screen/address_screen/theme_trash.svg",
          color: appConstants.primary1Color,
          onTap: () async {
            var data = await CommonWidget.showAlertDialog(
              context: context,
              text: TranslationConstants.want_delete_family_name.translate(context),
            );
            if (data) {
              addAddressCubit.deleteAddressDetails(id: addressDetailes.id, state: state);
            }
          },
        ),
        // iconImage(
        //   imageUrl: "assets/photos/svg/common/share.svg",
        //   color: appConstants.primary1Color,
        //   onTap: () {},
        // )
      ],
    );
  }

  Widget iconImage({required String imageUrl, void Function()? onTap, required Color color}) {
    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        height: 30.h,
        width: 30.w,
        alignment: Alignment.center,
        child: CommonWidget.imageButton(
          svgPicturePath: imageUrl,
          iconSize: 14.h,
          color: color,
        ),
      ),
    );
  }

  Widget contactDetails({required AddAddressLoadedState state, required AddressDetailes addressDetailes}) {
    return Visibility(
      visible: addressDetailes.addresstype == AddAddressType.someone_Else,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h, top: 3.h),
        child: Row(
          children: [
            CommonWidget.commonText(
              text: "+91 ${addressDetailes.mobileNo}",
              style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.default1Color),
            ),
          ],
        ),
      ),
    );
  }

  Widget distantCount({required AddAddressLoadedState state, required AddressDetailes addressDetailes}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: addressDetailes.isDefaultAddress == false
              ? appConstants.greyBackgroundColor
              : appConstants.secondary1Color,
          child: CommonWidget.imageBuilder(
            fit: BoxFit.contain,
            height: 20.h,
            color: addressDetailes.isDefaultAddress == true ? appConstants.default1Color : appConstants.default3Color,
            imageUrl: addressDetailes.addresstype == AddAddressType.home
                ? "assets/photos/svg/setting_screen/address_screen/home_address.svg"
                : addressDetailes.addresstype == AddAddressType.work
                    ? "assets/photos/svg/setting_screen/address_screen/work.svg"
                    : "assets/photos/svg/setting_screen/address_screen/other.svg",
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.only(top: 8.h),
        //   child: CommonWidget.commonText(
        //     text: 'distance',
        //     style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default3Color),
        //   ),
        // ),
      ],
    );
  }
}
