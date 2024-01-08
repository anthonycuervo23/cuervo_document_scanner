import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductWidget extends State<ProductScreen> {
  late ProductsCubit productsCubit;
  int selectedCategory = 0;
  FocusNode searchBarFocusNode = FocusNode();
  TextEditingController searchedData = TextEditingController();
  List<ProductModel> productsToDisplay = [];

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    productsCubit.fetchingInitialData(cate: "cake");
    super.initState();
  }

  Widget searchBar({required ProductsLoadedState state, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: CommonWidget.textField(
        contentPadding: EdgeInsets.zero,
        controller: searchedData,
        disabledBorderColor: appConstants.red,
        focusNode: searchBarFocusNode,
        onTap: () => productsCubit.searchFromProducts(searchBarFocusNode: searchBarFocusNode, state: state),
        onChanged: (text) => productsCubit.searchFromProducts(
          searchBarFocusNode: searchBarFocusNode,
          search: searchedData.text,
          state: state,
        ),
        enabledBorderColor: appConstants.borderColor,
        focusedBorderColor: appConstants.borderColor,
        isfocusedBorderColor: true,
        textInputType: TextInputType.text,
        isPrefixIcon: true,
        prefixWidget: Padding(
          padding: EdgeInsets.all(13.h),
          child: CommonWidget.imageButton(
            svgPicturePath: "assets/photos/svg/common/search_icon.svg",
            color: appConstants.black,
            boxFit: BoxFit.fill,
          ),
        ),
        hintText: TranslationConstants.search_product_her.translate(context),
        style: TextStyle(fontSize: 15.sp),
        borderColor: appConstants.orderScreenSearchFieldBorderColor,
      ),
    );
  }

  Widget products({required ProductsLoadedState state}) {
    productsToDisplay = state.filterdeData;
    if (searchBarFocusNode.hasFocus) {
      productsToDisplay = state.searchedData;
    }
    return GridView.builder(
      itemCount: productsToDisplay.length,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 146 / 167,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => productsCubit.sendSelectedDate(
            productCubit: productsCubit,
            product: productsToDisplay[index],
            state: state,
            checkScreen: CheckScreen.addProduct,
            openeingOrderScreenFrom: widget.args.openeingOrderScreenFrom,
            customerDetailModel: widget.args.customerDetailModel,
          ),
          child: CommonWidget.container(
            width: 10,
            color: appConstants.white,
            borderRadius: 5.r,
            child: productView(productsToDisplay, index),
          ),
        );
      },
    );
  }

  Widget productView(List<ProductModel> productsToDisplay, int index) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: CommonWidget.imageBuilder(
              height: double.infinity,
              width: double.infinity,
              isBorderOnlySide: true,
              fit: BoxFit.cover,
              imageUrl: productsToDisplay[index].image[0],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CommonWidget.container(
                width: 101,
                alignment: Alignment.centerRight,
                child: CommonWidget.commonText(
                  text: productsToDisplay[index].name,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              CommonWidget.sizedBox(
                width: 101,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonWidget.commonText(
                      text: "₹ ${productsToDisplay[index].availableQuantity[0].price}",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    CommonWidget.commonText(
                      text:
                          "(${productsToDisplay[index].availableQuantity[0].quantity}${productsToDisplay[index].availableQuantity[0].quantityType})",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayCategory({required ProductsLoadedState state}) {
    return searchBarFocusNode.hasFocus == false
        ? CommonWidget.sizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    selectedCategory = index;
                    productsCubit.filterDataProcess(categoryType: category[index], state: state);
                  },
                  child: CommonWidget.container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.all(8.h),
                    alignment: Alignment.center,
                    color:
                        index == selectedCategory ? appConstants.orderScreenSelectedCategoryColor : appConstants.white,
                    borderRadius: 8.r,
                    child: CommonWidget.commonText(
                      text: category[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: index == selectedCategory ? appConstants.white : appConstants.neutral6Color,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
