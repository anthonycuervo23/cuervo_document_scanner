// ignore_for_file: must_be_immutable

import 'package:bakery_shop_flutter/features/products/domain/args/product_details.args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/update_data/update_data_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/product_details_bar_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBar extends StatefulWidget {
  ProductDetailsArgs productDetailsArgs;
  ProductDetailsBar({super.key, required this.productDetailsArgs});

  @override
  State<ProductDetailsBar> createState() => _ProductDetailsBarState();
}

class _ProductDetailsBarState extends ProductDetailsBarWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDataCubit, double>(
      bloc: productListCubit.updateDataCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appConstants.whiteBackgroundColor,
          body: screenView(context: context),
          bottomNavigationBar: bottomAddButton(context: context),
        );
      },
    );
  }
}
