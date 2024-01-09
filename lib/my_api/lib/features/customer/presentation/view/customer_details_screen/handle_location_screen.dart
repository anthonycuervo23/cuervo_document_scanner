import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/handle_location_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/handle_location_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HandleLocationScreen extends StatefulWidget {
  final HandleLocationArgs args;
  const HandleLocationScreen({super.key, required this.args});

  @override
  State<HandleLocationScreen> createState() => _HandleLocationScreenState();
}

class _HandleLocationScreenState extends HandleLoctionWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(context,
            trailing: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: CommonWidget.commonButton(
                alignment: Alignment.center,
                height: 40.h,
                width: 80.w,
                textColor: appConstants.white,
                text: widget.args.navigateFrom == CheckLoactionNavigation.addAddress
                    ? TranslationConstants.save.translate(context)
                    : TranslationConstants.update.translate(context),
                context: context,
                onTap: () => CommonRouter.pop(
                  args: AddressData(
                    addressType: selectedAddress,
                    adddress: txtaddress.text,
                    flatNo: flatNo.text,
                    landMark: landMark.text,
                  ),
                ),
              ),
            ),
            titleCenter: false,
            onTap: () => CommonRouter.pop(),
            title: widget.args.navigateFrom == CheckLoactionNavigation.addAddress
                ? TranslationConstants.add_address.translate(context)
                : TranslationConstants.change_address.translate(context)),
        body: shippingAddview(),
      ),
    );
  }
}
