import 'dart:async';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/address_search_cubit/address_search_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/address_search/address_search_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_location_picker/map_location_picker.dart';

abstract class AddressSearchWidget extends State<AddressSearchScreen> {
  late AddressSearchCubit addressSearchCubit;
  TextEditingController txtAddress = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    addressSearchCubit = getItInstance<AddressSearchCubit>();
    addressSearchCubit.loadingCubit.show();
    stopLoading();
    super.initState();
  }

  void stopLoading() {
    Timer(const Duration(milliseconds: 700), () {
      addressSearchCubit.loadingCubit.hide();
      _focusNode.requestFocus();
    });
  }

  Widget searchBar() {
    return CommonWidget.container(
      isMarginAllSide: false,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      height: 60,
      color: appConstants.transparent,
      child: CommonWidget.textField(
        contentPadding: EdgeInsets.zero,
        focusNode: _focusNode,
        onChanged: (searchString) => addressSearchCubit.search(searchString: searchString),
        controller: txtAddress,
        borderColor: appConstants.appTitle,
        textInputType: TextInputType.streetAddress,
        focusedBorderColor: appConstants.themeColor,
        prefixWidget: CommonWidget.container(
          color: Colors.transparent,
          padding: EdgeInsets.all(13.h),
          child: CommonWidget.imageButton(
            svgPicturePath: "assets/photos/svg/common/search_icon.svg",
            color: appConstants.black,
            iconSize: 10,
            onTap: () {},
          ),
        ),
        // prefixIconPath: ,
        isPrefixIcon: true,
        hintText: TranslationConstants.search_for_area.translate(context),
      ),
    );
  }

  Widget currentLocation() {
    return InkWell(
      onTap: () async {
        addressSearchCubit.loadingCubit.show();
        Position position = await Geolocator.getCurrentPosition();
        addressSearchCubit.loadingCubit.hide();
        CommonRouter.pop(
          args: widget.args.copyWith(latitude: position.latitude, longitude: position.longitude),
        );
      },
      child: CommonWidget.container(
        color: appConstants.transparent,
        isMarginAllSide: false,
        margin: EdgeInsets.symmetric(horizontal: 18.h),
        height: 40,
        width: ScreenUtil().screenWidth,
        child: Row(
          children: [
            CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/google_map_scree/current_location.svg",
                height: 23.r,
                color: appConstants.theme1Color),
            CommonWidget.sizedBox(width: 10),
            CommonWidget.commonText(
                text: TranslationConstants.use_current_location.translate(context), fontSize: 15),
            const Spacer(),
            CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/common/right_arrow.svg", height: 20.h, color: appConstants.theme1Color)
          ],
        ),
      ),
    );
  }

  Widget suggetionsBox() {
    return BlocBuilder<AddressSearchCubit, AddressSearchState>(
      bloc: addressSearchCubit,
      builder: (context, state) {
        if (state is AddressSearchLoadedState) {
          return ListView.builder(
            itemCount: state.places.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async => addressSearchCubit.applySelectedLocation(index, args: widget.args),
                child: CommonWidget.container(
                  width: ScreenUtil().screenWidth,
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
                  color: appConstants.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.sizedBox(
                        child: CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/google_map_scree/map_icon_brown.svg",
                            height: 23.r,
                            color: appConstants.theme1Color),
                      ),
                      CommonWidget.sizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                                text: state.places[index].primaryText,
                                fontSize: 15),
                            CommonWidget.sizedBox(height: 3),
                            CommonWidget.commonText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                                text: state.places[index].secondaryText,
                                color: appConstants.black45,
                                fontSize: 13)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is AddressSearchErrorState) {
          return CommonWidget.commonText(text: state.errorMessage);
        } else if (state is AddressSearchLoadingState) {
          return CommonWidget.loadingIos();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
