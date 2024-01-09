import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/drawer/drawer_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';

Widget drawer({required BuildContext context}) {
  return Drawer(
    elevation: 0,
    backgroundColor: appConstants.drawerBackgroundColor,
    child: SizedBox(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          profileDetails(context: context),
          drawerList(context: context),
        ],
      ),
    ),
  );
}
