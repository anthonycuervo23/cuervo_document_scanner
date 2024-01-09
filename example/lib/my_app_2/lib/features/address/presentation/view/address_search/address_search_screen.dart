import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/address_search_cubit/address_search_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/address_search/address_search_widgets.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSearchScreen extends StatefulWidget {
  final AddressScreenArguments args;
  const AddressSearchScreen({super.key, required this.args});

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends AddressSearchWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () {
          CommonWidget.keyboardClose(context: context);
          CommonRouter.pop();
        },
        title: TranslationConstants.search_address.translate(context),
      ),
      body: Column(
        children: [
          searchBar(),
          currentLocation(),
          CommonWidget.sizedBox(height: 20),
          Expanded(
            child: BlocBuilder<AddressSearchCubit, AddressSearchState>(
              bloc: addressSearchCubit,
              builder: (context, state) {
                if (state is AddressSearchLoadedState) {
                  return state.places.isNotEmpty
                      ? suggetionsBox(state: state)
                      : CommonWidget.dataNotFound(
                          context: context,
                          bgColor: appConstants.whiteBackgroundColor,
                          actionButton: const SizedBox.shrink(),
                        );
                } else if (state is AddressSearchLoadingState) {
                  return CommonWidget.loadingIos();
                } else if (state is AddressSearchErrorState) {
                  return CommonWidget.dataNotFound(
                    bgColor: appConstants.whiteBackgroundColor,
                    context: context,
                    heading: TranslationConstants.something_went_wrong.translate(context),
                    subHeading: state.errorMessage,
                    buttonLabel: TranslationConstants.try_again.translate(context),
                  );
                }
                return CommonWidget.dataNotFound(
                  context: context,
                  bgColor: appConstants.whiteBackgroundColor,
                  actionButton: const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
