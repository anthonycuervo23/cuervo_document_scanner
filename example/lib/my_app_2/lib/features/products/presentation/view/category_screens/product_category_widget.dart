import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_category_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_category_args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/category/product_category_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/category_screens/product_category_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductCategoryWidget extends State<ProductCategoryScreen> {
  late ProductCategoryCubit productCategoryCubit;

  @override
  void initState() {
    productCategoryCubit = getItInstance<ProductCategoryCubit>();
    productCategoryCubit.getCategory();
    super.initState();
  }

  @override
  void dispose() {
    productCategoryCubit.loadingCubit.hide();
    productCategoryCubit.close();
    super.dispose();
  }

  Widget categoryView(CategoryModel category, BuildContext context) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(
        RouteList.product_list_screen,
        arguments: ProductCategoryArgs(
          categroyId: category.id,
          categoryName: category.name,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: appConstants.whiteBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonWidget.imageBuilder(
                  imageUrl: category.image,
                  borderRadius: 10.r,
                  fit: BoxFit.cover,
                ),
              ),
              CommonWidget.sizedBox(height: 15),
              CommonWidget.commonText(
                text: category.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appConstants.default1Color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
