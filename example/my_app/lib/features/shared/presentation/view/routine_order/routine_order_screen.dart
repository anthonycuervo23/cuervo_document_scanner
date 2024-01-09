import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/view/my_cart_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RoutineOrderScreen extends StatefulWidget {
  const RoutineOrderScreen({super.key});

  @override
  State<RoutineOrderScreen> createState() => _RoutineOrderScreenState();
}

class _RoutineOrderScreenState extends State<RoutineOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: TranslationConstants.routine_order.translate(context),
        onTap: () {
          Navigator.pop(context);
          // BlocProvider.of<CartCubit>(context).updateAllData(
          //   nevigateToDrawers: RoutineOrder.cart,
          //   routineOrderss: false,
          // );
        },
      ),
      body: const MyCartScreen(),
    );
  }
}
