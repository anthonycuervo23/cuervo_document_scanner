import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/cateloage/cateloge_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CatelogeScreen extends StatefulWidget {
  final ProductModel productData;
  const CatelogeScreen({super.key, required this.productData});

  @override
  State<CatelogeScreen> createState() => _CatelogeScreenState();
}

class _CatelogeScreenState extends CatelogeScreenWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEDF6FF),
        appBar: CustomAppBar(
          context,
          title: widget.productData.name,
          onTap: () => CommonRouter.pop(),
          titleCenter: false,
        ),
        body: imageView(),
      ),
    );
  }
}
