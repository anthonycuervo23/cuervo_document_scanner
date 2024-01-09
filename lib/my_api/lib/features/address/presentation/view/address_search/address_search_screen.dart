import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/address_search/address_search_widgets.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

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
      appBar: CustomAppBar(
        context,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusScope.of(context).unfocus();
          }
          CommonRouter.pop();
        },
        title: TranslationConstants.search_address.translate(context),
      ),
      body: Column(
        children: [
          searchBar(),
          currentLocation(),
          CommonWidget.sizedBox(height: 20),
          Expanded(child: suggetionsBox()),
        ],
      ),
    );
  }
}
