import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/address_search_cubit/address_search_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/address_search/address_search_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_location_picker/map_location_picker.dart';

abstract class AddressSearchWidget extends State<AddressSearchScreen> {
  late AddressSearchCubit addressSearchCubit;
  TextEditingController txtAddress = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    addressSearchCubit = getItInstance<AddressSearchCubit>();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    addressSearchCubit.loadingCubit.hide();
    addressSearchCubit.close();
    super.dispose();
  }

  Widget searchBar() {
    return CommonWidget.container(
      isMarginAllSide: false,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
      color: Colors.transparent,
      child: CommonWidget.textField(
        context: context,
        focusNode: _focusNode,
        onChanged: (searchString) => addressSearchCubit.checkOnChanged(searchString: searchString),
        controller: txtAddress,
        cursorColor: appConstants.primary1Color,
        contentPadding: EdgeInsets.zero,
        textInputType: TextInputType.streetAddress,
        focusedBorderColor: appConstants.primary1Color,
        prefixIconPath: 'assets/photos/svg/common/search_icon.svg',
        isPrefixIcon: true,
        hintText: TranslationConstants.search_for_area.translate(context),
        hintStyle: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default3Color),
      ),
    );
  }

  Widget currentLocation() {
    return InkWell(
      onTap: () async {
        addressSearchCubit.loadingCubit.show();
        try {
          Position position = await Geolocator.getCurrentPosition();
          addressSearchCubit.loadingCubit.hide();
          CommonRouter.pop(
            args: widget.args.copyWith(latitude: position.latitude, longitude: position.longitude),
          );
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      child: CommonWidget.container(
        color: Colors.transparent,
        isMarginAllSide: false,
        margin: EdgeInsets.symmetric(horizontal: 18.h),
        height: 40.h,
        width: ScreenUtil().screenWidth,
        child: Row(
          children: [
            CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/google_map_scree/current_location.svg",
              height: 23.r,
            ),
            CommonWidget.sizedBox(width: 5),
            CommonWidget.commonText(
              text: TranslationConstants.use_current_location.translate(context),
              style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.primary1Color),
            ),
            const Spacer(),
            CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/right_arrow.svg", height: 16.h),
            CommonWidget.sizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  Widget suggetionsBox({required AddressSearchLoadedState state}) {
    return ListView.builder(
      itemCount: state.places.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async => addressSearchCubit.applySelectedLocation(index, args: widget.args),
          child: CommonWidget.container(
            width: ScreenUtil().screenWidth,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.sizedBox(
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/google_map_scree/map_icon_brown.svg",
                    height: 23.r,
                  ),
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
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                      CommonWidget.sizedBox(height: 3),
                      CommonWidget.commonText(
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        text: state.places[index].secondaryText,
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default3Color,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
