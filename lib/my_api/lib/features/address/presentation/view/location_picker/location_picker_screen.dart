import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/location_picker_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/location_picker/location_picker_widgets.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationPickerScreen extends StatefulWidget {
  final LocationPickerScreenArguments args;
  const LocationPickerScreen({
    super.key,
    required this.args,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends LocationPickerWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: 'Choose Delivery Location',
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          googleMap(),
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
                  selectedAddress(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
