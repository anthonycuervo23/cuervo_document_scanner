import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/add_inventory/add_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/add_inventory_screen/add_inventory_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductInventoryScreen extends StatefulWidget {
  final ProductInventoryModel productInventoryModel;
  const AddProductInventoryScreen({super.key, required this.productInventoryModel});

  @override
  State<AddProductInventoryScreen> createState() => _AddProductInventoryScreenState();
}

class _AddProductInventoryScreenState extends AddProductInventoryWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        titleCenter: false,
        title: TranslationConstants.add_inventory.translate(context),
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: CommonWidget.container(
            borderRadius: 30.r,
            color: appConstants.themeColor,
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
            child: CommonWidget.commonText(
              text: TranslationConstants.save.translate(context),
              color: appConstants.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: BlocBuilder<AddProductInventoryCubit, AddProductInventoryState>(
          bloc: addProductInventoryCubit,
          builder: (context, state) {
            ProductInventoryModel data = widget.productInventoryModel;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  commonTextField(
                    hinttext: data.productName ?? TranslationConstants.enter_product_name.translate(context),
                    title: TranslationConstants.product_name.translate(context),
                    hintStyle: data.productName == null
                        ? TextStyle(
                            fontSize: 13.sp,
                            color: appConstants.grey,
                          )
                        : TextStyle(
                            fontSize: 13.sp,
                            color: appConstants.black,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 15.h),
                    child: categoryTextField(
                      hinttext: TranslationConstants.select_category.translate(context),
                      title: TranslationConstants.product_category.translate(context),
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  orderDetails(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
