import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/search/search_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/search/search_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class SearchWidget extends State<SearchScreen> {
  late SearchCubit searchCubit;
  late ProductListCubit productListCubit;

  @override
  void initState() {
    super.initState();
    searchCubit = getItInstance<SearchCubit>();
    productListCubit = getItInstance<ProductListCubit>();
    // productListCubit.loadProductData();
  }

  @override
  void dispose() {
    super.dispose();
    searchCubit.searchNameController.clear();
    searchCubit.close();
  }

  Widget textfild({required SearchLoadedState state}) {
    return CommonWidget.container(
      height: 50.h,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: CommonWidget.textField(
        context: context,
        textAlignVertical: TextAlignVertical.center,
        controller: searchCubit.searchNameController,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        isPrefixIcon: true,
        cursorColor: appConstants.primary1Color,
        prefixIconPath: "assets/photos/svg/common/brown_back_arrow.svg",
        hintText: TranslationConstants.looking_for_something_specific.translate(context),
        hintSize: 13.sp,
        autoFocus: true,
        textInputType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color),
        focusedBorderColor: appConstants.primary1Color,
        issuffixWidget: true,
        suffixWidget: Visibility(
          visible: state.issuffixShow ?? false,
          child: GestureDetector(
            onTap: () {
              CommonWidget.keyboardClose(context: context);
              searchCubit.searchNameController.clear();
              searchCubit.searchitem(searchText: searchCubit.searchNameController.text, state: state);
            },
            child: CommonWidget.commonIcon(
              icon: Icons.close,
              iconColor: appConstants.default1Color,
              iconSize: 22.r,
            ),
          ),
        ),
        onPrefixIconTap: () => CommonRouter.pop(),
        onChanged: (text) => searchCubit.searchitem(searchText: text, state: state),
      ),
    );
  }

  Widget categoryView() {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is SearchLoadedState) {
          var data = state.searcheditems;
          return Column(
            children: [
              textfild(state: state),
              Container(
                color: Colors.white,
                height: data.isNotEmpty ? 120 : 0,
                child: ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CommonWidget.container(
                    padding: EdgeInsets.only(right: 10.w, top: 15.h),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: CommonWidget.imageBuilder(
                            height: 75.h,
                            width: 75.h,
                            imageUrl: data[index].productImage,
                          ),
                        ),
                        CommonWidget.sizedBox(height: 10),
                        CommonWidget.container(
                          width: 80.w,
                          child: CommonWidget.commonText(
                            text: data[index].productName,
                            style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                  color: appConstants.default1Color,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is SearchLoadingState) {
          return CommonWidget.loadingIos();
        } else if (state is SearchErrorState) {
          return CommonWidget.dataNotFound(
            context: context,
            heading: TranslationConstants.something_went_wrong.translate(context),
            subHeading: state.errorMessage,
            buttonLabel: TranslationConstants.try_again.translate(context),
            // onTap: () => productCategoryCubit.getCategory(),
          );
        }
        return CommonWidget.container();
      },
    );
  }
}
