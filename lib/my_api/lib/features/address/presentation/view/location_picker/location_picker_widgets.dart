import 'dart:ui' as ui;
import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/location_picker/location_picker_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationPickerWidget extends State<LocationPickerScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  late LoadingCubit loadingCubit;
  late LocationPickerCubit locationPickerCubit;

  @override
  void initState() {
    loadingCubit = getItInstance<LoadingCubit>();
    locationPickerCubit = getItInstance<LocationPickerCubit>();
    locationPickerCubit.initilize(arguments: widget.args);
    changeMarcerIcon();
    super.initState();
  }

  @override
  void dispose() {
    locationPickerCubit.close();
    locationPickerCubit.loadingCubit.hide();
    super.dispose();
  }

  Future<void> changeMarcerIcon() async {
    ByteData data = await rootBundle.load("assets/photos/svg/google_map_scree/map_icon_red.png");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon =
        BitmapDescriptor.fromBytes((await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List());
  }

  Widget googleMap() {
    return BlocBuilder<LocationPickerCubit, LocationPickerState>(
      bloc: locationPickerCubit,
      builder: (context, state) {
        if (state is LocationPickerLoadedState) {
          return GoogleMap(
            onMapCreated: (controller) => locationPickerCubit.mapController.complete(controller),
            cameraTargetBounds: CameraTargetBounds.unbounded,
            markers: {
              Marker(
                markerId: const MarkerId("marker1"),
                position: LatLng(state.lat, state.long),
                draggable: true,
                icon: markerIcon,
              )
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: LatLng(state.lat, state.long), zoom: 16),
          );
        } else if (state is LocationPickerErrorState) {
          return Center(child: CommonWidget.loadingIos());
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget searchBar() {
    return GestureDetector(
      onTap: () async {
        dynamic data =
            await CommonRouter.pushNamed(RouteList.address_search_screen, arguments: locationPickerCubit.args);
        if (data is AddressScreenArguments) {
          AddressScreenArguments address = data;
          locationPickerCubit.setCurrentLocation(address: address);
        }
      },
      child: CommonWidget.container(
        height: 56.h,
        margin: EdgeInsets.only(left: 18.w, right: 18.w, top: 14.h),
        padding: const EdgeInsets.only(left: 15),
        color: appConstants.white,
        borderRadius: 10.r,
        shadow: [
          BoxShadow(color: appConstants.black12, blurRadius: 5.0, offset: const Offset(0, 5)),
        ],
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
                  imageUrl: "assets/photos/svg/common/search_icon.svg", height: 19.h, color: appConstants.theme1Color),
            ),
            CommonWidget.sizedBox(width: 11),
            CommonWidget.commonText(text: TranslationConstants.search_for_area.translate(context), fontSize: 15),
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
          locationPickerCubit.initilize(arguments: widget.args);
        } else {
          CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.location_permission_required.translate(context.mounted));
        }
      },
      child: CommonWidget.container(
        height: 36,
        width: 175,
        borderRadius: appConstants.buttonRadius.toDouble(),
        borderColor: appConstants.themeColor,
        isBorder: true,
        child: CommonWidget.container(
          height: 36,
          width: 175.w,
          color: appConstants.themeColor.withOpacity(0.2),
          borderRadius: appConstants.buttonRadius.toDouble(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CounterCubit, int>(
                bloc: locationPickerCubit.counterCubit,
                builder: (context, state) {
                  if (state == 1) {
                    return CommonWidget.sizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: appConstants.themeColor),
                    );
                  } else if (state == 0) {
                    return CommonWidget.imageBuilder(
                      height: 20.r,
                      imageUrl: "assets/photos/svg/google_map_scree/current_location.svg",
                      color: appConstants.theme1Color,
                    );
                  }
                  return Center(child: CircularProgressIndicator(color: appConstants.red));
                },
              ),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                  text: TranslationConstants.use_current_location.translate(context),
                  fontSize: 13,
                  color: appConstants.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedAddress() {
    return BlocBuilder<LocationPickerCubit, LocationPickerState>(
      bloc: locationPickerCubit,
      builder: (context, state) {
        if (state is LocationPickerLoadedState) {
          return addressConfirmView(
            state: state,
            context: context,
          );
        } else if (state is LocationPickerLoadingState) {
          if (locationPickerCubit.loadingCubit.state) {
            return const SizedBox.shrink();
          }
          return Center(child: CommonWidget.loadingIos());
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget addressConfirmView({
    required LocationPickerLoadedState state,
    required BuildContext context,
  }) {
    return BlocBuilder<LoadingCubit, bool>(
      bloc: loadingCubit,
      builder: (context, state) {
        if (state == false) {
          AddressScreenArguments addressScreenArgs = locationPickerCubit.args;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.container(
                color: appConstants.white,
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
                          color: appConstants.theme1Color),
                    ),
                    CommonWidget.sizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.sizedBox(
                            height: 20,
                            child: CommonWidget.commonText(
                                textOverflow: TextOverflow.ellipsis,
                                text: addressScreenArgs.aeriaName.toCamelcase(),
                                fontSize: 13),
                          ),
                          CommonWidget.sizedBox(height: 5),
                          CommonWidget.sizedBox(
                            child: CommonWidget.commonText(
                              textAlign: TextAlign.left,
                              text: addressScreenArgs.fullAddress.toCamelcase(),
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              confirmLocation(
                context: context,
                fullAddres: addressScreenArgs.fullAddress,
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget confirmLocation({
    required BuildContext context,
    required String fullAddres,
  }) {
    return CommonWidget.container(
      color: appConstants.white,
      padding: EdgeInsets.only(left: 15.h, right: 15.h, bottom: 15.h),
      child: CommonWidget.commonButton(
        height: 51,
        width: 325,
        alignment: Alignment.center,
        text: TranslationConstants.comform_location.translate(context),
        textColor: appConstants.white,
        color: appConstants.themeColor,
        onTap: () => CommonRouter.pop(args: locationPickerCubit.args.fullAddress),
        context: context,
      ),
    );
  }
}
