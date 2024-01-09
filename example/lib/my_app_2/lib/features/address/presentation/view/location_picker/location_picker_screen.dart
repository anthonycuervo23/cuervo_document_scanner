// ignore_for_file: library_private_types_in_public_api

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/location_picker/location_picker_widgets.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationPickerScreen extends StatefulWidget {
  final LoactionArguments checkLoactionNavigation;
  const LocationPickerScreen({super.key, required this.checkLoactionNavigation});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends LocationPickerWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.choose_delivery_location.translate(context),
      ),
      body: BlocBuilder<LocationPickerCubit, LocationPickerState>(
        bloc: addAddressCubit.locationPickerCubit,
        builder: (context, state) {
          if (state is LocationPickerLoadedState) {
            return Stack(
              fit: StackFit.expand,
              children: [
                googleMap(state: state),
                Positioned(top: 0, left: 0, right: 0, child: searchBar()),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CommonWidget.sizedBox(
                    width: ScreenUtil().screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        getCurrentLocationButton(context: context),
                        CommonWidget.sizedBox(height: 14),
                        addressConfirmView(checkLocation: widget.checkLoactionNavigation.checkLoactionNavigator),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is LocationPickerLoadingState) {
            return Center(child: CommonWidget.loadingIos());
          } else if (state is LocationPickerErrorState) {
            return CommonWidget.dataNotFound(
              context: context,
              heading: TranslationConstants.something_went_wrong.translate(context),
              subHeading: state.errorMessage,
              buttonLabel: TranslationConstants.try_again.translate(context),
              // onTap: () => productCategoryCubit.getCategory(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
