import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/product_inventory/product_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/product_inventory/product_inventory_state.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/product_inventory/product_inventory_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInventoryScreen extends StatefulWidget {
  const ProductInventoryScreen({super.key});

  @override
  State<ProductInventoryScreen> createState() => _ProductInventoryScreenState();
}

class _ProductInventoryScreenState extends ProductInventoryWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        titleCenter: false,
        title: TranslationConstants.product_inventory.translate(context),
      ),
      backgroundColor: appConstants.backGroundColor,
      body: BlocBuilder<ProductInventoryCubit, ProductInventoryState>(
        bloc: productInventoryCubit,
        builder: (context, state) {
          if (state is ProductInventoryLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: searchField(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productInventoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: commonInventoryBox(
                          index: index,
                          productInventoryModel: productInventoryList[index],
                          onTap: () {
                            productInventoryCubit.deleteProduct(
                              productInventoryModel: productInventoryList[index],
                            );
                            CommonRouter.pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: CommonWidget.container(
        height: 80,
        width: ScreenUtil().screenWidth,
        color: appConstants.white,
        padding: EdgeInsets.symmetric(horizontal: 70.w),
        shadow: [
          BoxShadow(
            blurRadius: 5.r,
            color: appConstants.dividerColor,
            offset: const Offset(0, -3),
          )
        ],
        child: Center(
          child: CommonWidget.container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            borderRadius: 10.r,
            color: appConstants.themeColor,
            child: GestureDetector(
              onTap: () {
                CommonRouter.pushNamed(RouteList.add_inventory_screen,arguments: ProductInventoryModel());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/customer/add_new.svg",
                    height: 20.h,
                  ),
                  CommonWidget.sizedBox(width: 10),
                  CommonWidget.commonText(
                    text: TranslationConstants.add_inventory.translate(context),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: appConstants.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
