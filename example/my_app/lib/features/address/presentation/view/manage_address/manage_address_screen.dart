// ignore_for_file: library_private_types_in_public_api

import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/manage_address/manage_address_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageAddressScreen extends StatefulWidget {
  final CheckLoactionNavigation checkLoactionNavigation;
  const ManageAddressScreen({super.key, required this.checkLoactionNavigation});

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends ManageAddressWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: TranslationConstants.my_address.translate(context).toCamelcase(),
        onTap: () => CommonRouter.pop(),
      ),
      backgroundColor: appConstants.whiteBackgroundColor,
      body:  BlocBuilder<AddAddressCubit, AddAddressState>(
        bloc: addAddressCubit,
        builder: (context, state) {
          if (state is AddAddressLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: CommonWidget.commonText(
                            text: TranslationConstants.select_address.translate(context),
                            style: Theme.of(context)
                                .textTheme
                                .subTitle2MediumHeading
                                .copyWith(color: appConstants.default1Color),
                          ),
                        ),
                        addAddressButton(context),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: CommonWidget.commonText(
                              text: TranslationConstants.saved_address.translate(context),
                              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                    color: appConstants.default4Color,
                                    letterSpacing: 5.w,
                                    wordSpacing: 4.w,
                                    fontSize: 15.sp,
                                  ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state.manageAddressEntity?.addresses.isEmpty ?? true,
                          child: Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: CommonWidget.sizedBox(
                              child: CommonWidget.dataNotFound(
                                context: context,
                                actionButton: const SizedBox.shrink(),
                                bgColor: appConstants.whiteBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: state.manageAddressEntity?.addresses.isNotEmpty ?? false,
                          child: addressesList(context: context, state: state),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AddAddressLoadingState) {
            return Center(child: CommonWidget.loadingIos());
          } else if (state is AddAddressErrorState) {
            return Center(
              child: CommonWidget.dataNotFound(
                context: context,
                bgColor: appConstants.whiteBackgroundColor,
                heading: TranslationConstants.something_went_wrong.translate(context),
                subHeading: state.errorMessage,
                buttonLabel: TranslationConstants.try_again.translate(context),
                onTap: () => addAddressCubit.loadInitialData(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
