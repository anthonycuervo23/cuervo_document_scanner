import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceFilterOptions extends StatefulWidget {
  final ProductListCubit productListCubit;
  final ProductListLoadedState state;
  final int categoryId;

  const PriceFilterOptions({
    super.key,
    required this.productListCubit,
    required this.categoryId,
    required this.state,
  });

  @override
  State<PriceFilterOptions> createState() => _PriceFilterOptionsState();
}

class _PriceFilterOptionsState extends State<PriceFilterOptions> {
  late final ProductListCubit productListCubit;
  @override
  void initState() {
    productListCubit = widget.productListCubit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          filterTitle(context),
          Divider(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: BlocBuilder<CounterCubit, int>(
              bloc: widget.productListCubit.quantityChangeCubit,
              builder: (context, state) {
                return Column(
                  children: [
                    CommonWidget.sizedBox(
                      height: 120,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productListCubit.priceFilterList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () => widget.productListCubit.quantityChangeCubit.chanagePageIndex(index: index),
                            child: ListTile(
                              minVerticalPadding: 5.h,
                              title: CommonWidget.commonText(
                                text: productListCubit.priceFilterList[index],
                                style: index == state
                                    ? Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                          color: appConstants.default1Color,
                                        )
                                    : Theme.of(context).textTheme.captionBookHeading.copyWith(
                                          color: appConstants.default3Color,
                                        ),
                              ),
                              trailing: Radio(
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return appConstants.primary1Color;
                                    } else {
                                      return appConstants.default6Color;
                                    }
                                  },
                                ),
                                value: index,
                                groupValue: state,
                                onChanged: (v) {
                                  widget.productListCubit.quantityChangeCubit.chanagePageIndex(index: v ?? 0);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        actionButton(
                          textColor: appConstants.default1Color,
                          callback: () {
                            widget.productListCubit.removeFilter(
                              index: 0,
                              item: ProductFilterEnum.pricing,
                              categoryId: widget.categoryId,
                              state: widget.state,
                            );
                            CommonRouter.pop();
                          },
                          label: TranslationConstants.clear.translate(context),
                        ),
                        CommonWidget.sizedBox(width: 16),
                        actionButton(
                          textColor: appConstants.primary1Color,
                          callback: () {
                            productListCubit.filterApply(
                              categoryId: widget.categoryId,
                              state: widget.state,
                              filter: productListCubit.priceFilterList[state],
                            );
                            CommonRouter.pop();
                          },
                          label: TranslationConstants.apply.translate(context),
                        ),
                        CommonWidget.sizedBox(width: 16),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget filterTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: TranslationConstants.filter.translate(context),
                  style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.primary1Color),
                ),
                TextSpan(
                  text: " : ",
                  style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
                ),
                TextSpan(
                  text: TranslationConstants.price.translate(context),
                  style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
                ),
              ],
            ),
          ),
          CommonWidget.imageButton(
            svgPicturePath: "assets/photos/svg/common/close_icon.svg",
            onTap: () => CommonRouter.pop(),
          )
        ],
      ),
    );
  }

  Widget actionButton({
    required Color textColor,
    required String label,
    required VoidCallback callback,
  }) {
    return CommonWidget.textButton(
      text: label,
      textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: textColor),
      onTap: callback,
    );
  }
}
