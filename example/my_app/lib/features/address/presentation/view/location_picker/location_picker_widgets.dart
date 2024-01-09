// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui' as ui;
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/location_picker/location_picker_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationPickerWidget extends State<LocationPickerScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // late AddAddressCubit addAddressCubit;

  @override
  void initState() {
    if (widget.checkLoactionNavigation.isEditProfile ?? false) {
      addAddressCubit = getItInstance<AddAddressCubit>();
    }
    addAddressCubit.initilize();
    changeMarcerIcon();
    super.initState();
  }

  @override
  void dispose() {
    addAddressCubit.loadingCubit.hide();
    addAddressCubit.mapController = Completer();
    if (widget.checkLoactionNavigation.isEditProfile ?? false) {
      addAddressCubit.close();
    }
    super.dispose();
  }

  Future<void> changeMarcerIcon() async {
    ByteData data = await rootBundle.load("assets/photos/svg/google_map_scree/map_icon_red.png");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = BitmapDescriptor.fromBytes(
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List(),
    );
  }

  Widget googleMap({required LocationPickerLoadedState state}) {
    return GoogleMap(
      onMapCreated: (controller) {
        try {
          addAddressCubit.mapController.complete(controller);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      cameraTargetBounds: CameraTargetBounds.unbounded,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(state.lat, state.long), zoom: 16),
      zoomControlsEnabled: true,
      markers: {
        Marker(
          markerId: const MarkerId("marker1"),
          position: LatLng(state.lat, state.long),
          draggable: true,
          icon: markerIcon,
        )
      },
    );
  }

  Widget searchBar() {
    return GestureDetector(
      onTap: () async {
        dynamic data = await Navigator.pushNamed(
          context,
          RouteList.address_search_screen,
          arguments: addAddressCubit.args,
        );
        if (data is AddressScreenArguments) {
          AddressScreenArguments address = data;
          addAddressCubit.setCurrentLocation(address: address);
        }
      },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 14.h),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: appConstants.textFiledColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: appConstants.default10Color,
              blurRadius: 5.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonWidget.container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/common/search_icon.svg",
                height: 19.h,
              ),
            ),
            CommonWidget.sizedBox(width: 16),
            CommonWidget.commonText(
              text: TranslationConstants.search_for_area.translate(context),
              style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default3Color),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCurrentLocationButton({required BuildContext context}) {
    return InkWell(
      onTap: () async {
        var permission = await Permission.location.request();
        if (permission.isGranted) {
          addAddressCubit.initilize();
        } else {
          CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.location_permission_required.translate(context));
        }
      },
      child: CommonWidget.container(
        height: 36.h,
        width: 175.w,
        borderRadius: appConstants.buttonRadius,
        borderColor: appConstants.primary1Color,
        isBorder: true,
        child: CommonWidget.container(
          height: 36.h,
          width: 175.w,
          color: appConstants.secondary1Color,
          borderRadius: appConstants.buttonRadius,
          borderColor: appConstants.secondary1Color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/google_map_scree/current_location.svg",
                height: 20.r,
              ),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                text: TranslationConstants.use_current_location.translate(context),
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressConfirmView({required CheckLoactionNavigation checkLocation}) {
    AddressScreenArguments addressScreenArgs = addAddressCubit.args;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: addressScreenArgs.aeriaName.isNotEmpty || addressScreenArgs.fullAddress.isNotEmpty,
          child: CommonWidget.container(
            color: appConstants.whiteBackgroundColor,
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/google_map_scree/map_icon_brown.svg",
                    height: 23.h,
                  ),
                ),
                CommonWidget.sizedBox(width: 10.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.sizedBox(
                        height: 20,
                        child: CommonWidget.commonText(
                          textOverflow: TextOverflow.ellipsis,
                          text: addressScreenArgs.aeriaName.toCamelcase(),
                          style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                      ),
                      CommonWidget.sizedBox(height: 5),
                      CommonWidget.sizedBox(
                        child: CommonWidget.commonText(
                          text: addressScreenArgs.fullAddress.toCamelcase(),
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                color: appConstants.default3Color,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        confirmLocationButton(
          context: context,
          fullAddres: addressScreenArgs.fullAddress,
          checkLocation: checkLocation,
        ),
      ],
    );
  }

  Widget confirmLocationButton({
    required BuildContext context,
    required String fullAddres,
    required CheckLoactionNavigation checkLocation,
  }) {
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      padding: EdgeInsets.only(left: 15.h, right: 15.h, bottom: 15.h),
      child: CommonWidget.commonButton(
        height: 51.h,
        width: 325.w,
        alignment: Alignment.center,
        text: TranslationConstants.comform_location.translate(context),
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
        color: appConstants.primary1Color,
        context: context,
        onTap: () {
          AddressScreenArguments args = addAddressCubit.args;
          if (widget.checkLoactionNavigation.checkLoactionNavigator == CheckLoactionNavigation.cart) {
            CommonRouter.pop(args: addAddressCubit.args);
          } else {
            AddressScreenArguments addressScreenArguments = AddressScreenArguments(
              isNew: true,
              id: args.id,
              name: args.name,
              floatNo: args.floatNo,
              aeriaName: args.aeriaName,
              fullAddress: args.fullAddress,
              cityName: args.cityName,
              addresstype: args.addresstype,
              countryName: args.countryName,
              landmark: args.landmark,
              mobile: args.mobile,
              pinCode: args.pinCode,
              stateName: args.stateName,
              latitude: args.latitude,
              longitude: args.longitude,
            );
            CommonRouter.pushNamed(
              RouteList.add_address_screen,
              arguments: addressScreenArguments,
            );
          }
        },
      ),
    );
  }
}
