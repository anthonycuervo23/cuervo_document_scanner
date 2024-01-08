import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/offers/offers_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/offers/offers_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OffersWidget extends State<OffersScreen> {
  late OffersCubit offersCubit;
  @override
  void initState() {
    offersCubit = getItInstance<OffersCubit>();
    offersCubit.loaded();
    super.initState();
  }

  @override
  void dispose() {
    offersCubit.close();
    super.dispose();
  }

  Widget commonBox({required OffersLoadedState state, required int index}) {
    var offerDataShow = state.searcheditems[index];
    return CommonWidget.container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        color: appConstants.drawerBackgroundColor,
        borderRadius: 8.r,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonText(
                        text: "#${index + 1}",
                        color: appConstants.neutral1Color,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonWidget.commonText(
                      text: offerDataShow.offerTital,
                      color: appConstants.neutral1Color,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CommonWidget.commonText(
                        text: offerDataShow.offerDescripption,
                        color: appConstants.lightGrey1,
                        maxLines: 2,
                        textOverflow: TextOverflow.clip,
                        fontSize: 10.sp,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        CommonWidget.commonBulletPoint(size: 2.sp, color: appConstants.lightGrey1),
                        CommonWidget.sizedBox(width: 3.h),
                        CommonWidget.commonText(
                          text: "${TranslationConstants.order_above.translate(context)}${offerDataShow.price}.",
                          color: appConstants.lightGrey1,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 10.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CommonWidget.commonBulletPoint(size: 2.sp, color: appConstants.lightGrey1),
                        CommonWidget.sizedBox(width: 3.h),
                        CommonWidget.commonText(
                          text: "${TranslationConstants.max_discount.translate(context)}${offerDataShow.maxPrice}.",
                          color: appConstants.lightGrey1,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 10.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        editButton(state: state, index: index),
                        CommonWidget.sizedBox(width: 15.w),
                        deleteButton(index: index, state: state),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/offers_screen/offercoupon.svg",
                          height: 40.h,
                        ),
                        Positioned(
                          right: 0.w,
                          left: 0.w,
                          child: CommonWidget.commonText(
                            text: offerDataShow.cuponText,
                            color: appConstants.themeColor,
                            fontSize: 12.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Row(
                      children: [
                        CommonWidget.commonText(
                          text: offerDataShow.validUntil,
                          color: appConstants.neutral1Color,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        CommonWidget.sizedBox(width: 3.h),
                        CommonWidget.commonText(
                          text: offerDataShow.date,
                          color: appConstants.lightGrey1,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget editButton({required OffersLoadedState state, required int index}) {
    return CommonWidget.svgIconButton(
      svgPicturePath: "assets/photos/svg/common/edit.svg",
      iconSize: 18.h,
      color: appConstants.neutral1Color,
      onTap: () {
        CommonRouter.pushNamed(
          RouteList.add_offers_screen,
          arguments: state.searcheditems[index],
        );
      },
    );
  }

  Widget deleteButton({required int index, required OffersLoadedState state}) {
    return CommonWidget.svgIconButton(
      svgPicturePath: "assets/photos/svg/common/trash.svg",
      iconSize: 18.h,
      color: appConstants.neutral1Color,
      onTap: () => CommonWidget.showAlertDialog(
        maxLines: 2,
        leftColor: appConstants.theme1Color.withOpacity(0.2),
        context: context,
        text: TranslationConstants.delete_banner_warning.translate(context),
        textColor: appConstants.black,
        isTitle: true,
        titleText: TranslationConstants.confirm_delete.translate(context),
        titleTextStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: appConstants.theme1Color,
        ),
        onTap: () {
          offersCubit.deleteOffersDetaile(index: index, state: state);
          CommonRouter.pop();
        },
      ),
    );
  }

  Widget textfile({required BuildContext context, void Function(String)? onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextField(
        onChanged: onChanged,
        cursorColor: appConstants.orderScreenSearchFieldBorderColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: appConstants.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/customer/search.svg",
              height: 20.h,
              width: 20.w,
            ),
          ),
          hintText: TranslationConstants.search_here.translate(context),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: appConstants.orderScreenSelectedCategoryColor),
          ),
        ),
      ),
    );
  }
}
