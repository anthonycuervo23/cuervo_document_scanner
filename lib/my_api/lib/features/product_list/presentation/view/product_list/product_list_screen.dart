import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_list/product_list_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ProductListWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appConstants.backGroundColor,
      appBar: CustomAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.products.translate(context),
        titleCenter: false,
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: productListCubit,
        builder: (context, state) {
          if (state is ProductListLodedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: commonSearchAndFilterField(
                    controller: productListCubit.searchController,
                    onChanged: (v) {},
                    context: context,
                    onTapForFilter: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      filterDialog(context: context);
                    },
                    onTapSearchCalenderButton: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      searchFilterDialog(
                        context: context,
                        searchFilterCubit: productListCubit.searchFilterCubit,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        text: "${TranslationConstants.total_product.translate(context)}:",
                        fontWeight: FontWeight.w400,
                        color: appConstants.black,
                        fontSize: 12.sp,
                      ),
                      CommonWidget.commonText(
                        text: productModelList.length.toString(),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: appConstants.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: productModelList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                        child: productListCard(
                          productListModel: productModelList[index],
                          index: index,
                          toggleState: state,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductListLodingState) {
            return CommonWidget.loadingIos();
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: addNewButton(),
    );
  }
}
