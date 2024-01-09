import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/my_favorite/my_favorite_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_favorite/my_favorite_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

abstract class MyFavoriteWidget extends State<MyFavoriteScreen> {
  late MyFavoriteCubit myFavoriteCubit;
  @override
  void initState() {
    myFavoriteCubit = getItInstance<MyFavoriteCubit>();
    myFavoriteCubit.myFavoriteLoadData();
    super.initState();
  }

  @override
  void dispose() {
    myFavoriteCubit.searchController.dispose();
    myFavoriteCubit.close();
    super.dispose();
  }

  Widget searchTextField({required List<TempProductData> productData, required MyFavoriteLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      child: CommonWidget.textField(
        context: context,
        controller: myFavoriteCubit.searchController,
        isPrefixIcon: true,
        prefixIconPath: "assets/photos/svg/common/search_icon.svg",
        prefixIconHeight: 18.sp,
        issuffixIcon: myFavoriteCubit.searchController.text.isNotEmpty,
        suffixIconpath: "assets/photos/svg/common/close_icon.svg",
        hintText: "${TranslationConstants.search_your_favorites.translate(context)}...",
        hintstyle: Theme.of(context).textTheme.captionBookHeading.copyWith(
              color: appConstants.default4Color,
            ),
        textInputType: TextInputType.text,
        fontSize: 16.sp,
        focusedBorderColor: appConstants.primary1Color,
        onsuffixIconTap: () {
          CommonWidget.keyboardClose(context: context);

          myFavoriteCubit.clearFilter(state: state);
        },
        onChanged: (value) {
          myFavoriteCubit.searchProduct(
            productList: productData,
            textFieldValue: value,
            state: state,
          );
        },
      ),
    );
  }

  Widget commonBoxList({
    required TempProductData productData,
    required MyFavoriteLoadedState state,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: CommonWidget.container(
        color: appConstants.whiteBackgroundColor,
        padding: EdgeInsets.all(14.r),
        borderRadius: appConstants.buttonRadius,
        child: Column(
          children: [
            imageStackView(productData: productData),
            Padding(
              padding: EdgeInsets.only(top: 7.h),
              child: Row(
                children: [
                  productTitle(productData),
                  CommonWidget.sizedBox(width: 45),
                  commonButton(
                    color: appConstants.profileEmail2Color,
                    svgColor: appConstants.profileEmail1Color,
                    onTap: () async {
                      var data = await CommonWidget.showAlertDialog(
                        context: context,
                        isTitle: true,
                        titleText: TranslationConstants.confirm_delete.translate(context),
                        text: TranslationConstants.sure_delete_favorite_item.translate(context),
                        textColor: appConstants.default3Color,
                      );
                      if (data) {
                        myFavoriteCubit.deleteFavoriteItem(productData: productData, state: state);
                      }
                    },
                    imageUrl: "assets/photos/svg/common/trash.svg",
                  ),
                  commonButton(
                    onTap: () async => await Share.share('https://www.oceanmtech.com/'),
                    imageUrl: "assets/photos/svg/common/share.svg",
                    color: appConstants.green2Color,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productTitle(TempProductData productData) {
    return Expanded(
      child: CommonWidget.commonText(
        text: productData.productName,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
              color: appConstants.default1Color,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }

  Widget commonButton({required VoidCallback onTap, required String imageUrl, required Color color, Color? svgColor}) {
    return Padding(
      padding: EdgeInsets.only(left: 17.w),
      child: GestureDetector(
        onTap: onTap,
        child: CommonWidget.container(
          padding: EdgeInsets.all(9.r),
          borderRadius: 18.r,
          color: color,
          child: CommonWidget.imageBuilder(imageUrl: imageUrl, color: svgColor, height: 16.sp, width: 16.sp),
        ),
      ),
    );
  }

  Widget imageStackView({required TempProductData productData}) {
    return Stack(
      children: [
        CommonWidget.imageBuilder(
          imageUrl: productData.productImage,
          fit: BoxFit.cover,
          height: ScreenUtil().screenHeight * 0.18,
          width: ScreenUtil().screenWidth,
          borderRadius: appConstants.prductCardRadius,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Row(
            children: [
              CommonWidget.imageBuilder(
                imageUrl: productData.isVegProduct
                    ? "assets/photos/svg/common/vegetarian_icon.svg"
                    : "assets/photos/svg/common/nonVegetarian_icon.svg",
                height: 16.sp,
              ),
              productData.isBestSeller ? bestSellerContainer() : const SizedBox.shrink(),
              const Spacer(),
              ratingContainer(productData: productData),
            ],
          ),
        ),
      ],
    );
  }

  Padding bestSellerContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: CommonWidget.container(
        height: 20.h,
        color: appConstants.whiteBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        borderRadius: 4.r,
        alignment: Alignment.center,
        child: CommonWidget.commonText(
          height: 19.h,
          text: TranslationConstants.bestseller.translate(context),
          style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(
                color: appConstants.bestSeller1Color,
                fontSize: 9.86,
              ),
        ),
      ),
    );
  }

  Widget ratingContainer({required TempProductData productData}) {
    return CommonWidget.container(
      height: 20.h,
      color: appConstants.starRateColor,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      borderRadius: 4.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/star_icon.svg",
            height: 10.h,
            color: appConstants.buttonTextColor,
          ),
          CommonWidget.sizedBox(width: 4),
          CommonWidget.commonText(
            text: "${productData.productRating}",
            style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                  height: 1,
                  color: appConstants.buttonTextColor,
                ),
          ),
        ],
      ),
    );
  }
}
