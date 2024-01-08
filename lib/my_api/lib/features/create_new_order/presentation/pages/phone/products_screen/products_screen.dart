import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/product_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OpeneingOrderScreenFrom { customerDetails, createCustomer }

class ProductScreen extends StatefulWidget {
  final ProductScreenArgs args;
  const ProductScreen({super.key, required this.args});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ProductWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.args.displayAppBar
            ? CustomAppBar(
                context,
                onTap: () {
                  productsCubit.clearAllSelectedDate();
                  CommonRouter.pop();
                },
                titleCenter: false,
                title: TranslationConstants.add_product.translate(context),
              )
            : null,
        backgroundColor: const Color(0xffEDF6FF),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          bloc: productsCubit,
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoadedState) {
              return Column(
                children: [
                  CommonWidget.sizedBox(height: 10),
                  searchBar(context: context, state: state),
                  CommonWidget.sizedBox(height: 10),
                  displayCategory(state: state),
                  CommonWidget.sizedBox(height: 10),
                  Expanded(child: products(state: state)),
                ],
              );
            } else if (state is ProductsErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
