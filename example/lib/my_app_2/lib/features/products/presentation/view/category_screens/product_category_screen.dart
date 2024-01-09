import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_category_model.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/category/product_category_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/category/product_category_state.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/category_screens/product_category_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key});

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends ProductCategoryWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        title: TranslationConstants.category.translate(context),
        onTap: () => CommonRouter.pop(),
      ),
      body: BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
        bloc: productCategoryCubit,
        builder: (context, state) {
          if (state is ProductCategopryLoadedState) {
            return GridView.builder(
              itemCount: state.categoryList.length,
              padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 18.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 150.h,
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.h,
              ),
              itemBuilder: (context, index) {
                CategoryModel category = state.categoryList[index];
                return categoryView(category, context);
              },
            );
          } else if (state is ProductCategopryLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is ProductCategopryErrorState) {
            return CommonWidget.dataNotFound(
              context: context,
              heading: TranslationConstants.something_went_wrong.translate(context),
              subHeading: state.errorMessage,
              buttonLabel: TranslationConstants.try_again.translate(context),
              onTap: () => productCategoryCubit.getCategory(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
