import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/add_address/add_address_widgets.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressScreenArguments addressData;
  const AddAddressScreen({super.key, required this.addressData});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends AddAddressWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: textFieldKey,
      child: Scaffold(
        backgroundColor: appConstants.whiteBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
          context,
          title: TranslationConstants.address.translate(context),
          onTap: () {
            CommonRouter.popUntil(RouteList.manage_address_screen);
          },
        ),
        body: Column(
          children: [
            CommonWidget.container(
              height: 130,
              width: double.infinity,
              color: appConstants.greyBackgroundColor,
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/png/address_screen/add_address.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 5.h, left: 15.w),
                    child: Row(
                      children: [
                        CommonWidget.commonText(
                          text: TranslationConstants.who_are_you_ordering.translate(context),
                          style: Theme.of(context)
                              .textTheme
                              .captionBoldHeading
                              .copyWith(color: appConstants.default4Color),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<AddAddressCubit, AddAddressState>(
                      bloc: addAddressCubit,
                      builder: (context, state) {
                        if (state is AddAddressLoadedState) {
                          return tabBar(state: state);
                        } else if (state is AddAddressLoadingState) {
                          return Center(child: CommonWidget.loadingIos());
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
