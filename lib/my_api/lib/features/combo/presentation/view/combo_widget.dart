import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/combo/data/models/combo_model.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/combo_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/combo_state.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/combo_screen.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/create_combo/create_combo_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/sort_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ComboWidget extends State<ComboScreen> with WidgetsBindingObserver {
  late ComboCubit comboCubit;

  @override
  void initState() {
    super.initState();
    comboCubit = getItInstance<ComboCubit>();
  }

  @override
  void dispose() {
    comboCubit.close();
    super.dispose();
  }

  // String comboOfferProducts({required int index}) {
  //   String allProducts = comboOfferList[index].comboProducts.join(" + ");
  //   return allProducts;
  // }

  Widget screenView(BuildContext context) {
    return BlocBuilder<ComboCubit, ComboState>(
      bloc: comboCubit,
      builder: (context, state) {
        if (state is ComboLoadedState) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: commonSearchAndFilterField(
                  context: context,
                  onTapSearchCalenderButton: () {},
                  onTapForFilter: () async {
                    // String value = await sortFilterDialogs(
                    //   context: context,
                    //   counterCubit: comboCubit.counterCubit,
                    //   sortFilterCubit: comboCubit.sortFilterCubit,
                    // );
                  },
                  onChanged: (v) {},
                  controller: comboCubit.searchController,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.listOfCombo.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ComboModel comboModel = state.listOfCombo[index];
                    return comboBox(comboModel: comboModel, index: index, state: state);
                  },
                ),
              ),
              createComboButton(context),
            ],
          );
        } else if (state is ComboLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ComboErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget comboBox({required ComboModel comboModel, required int index, required ComboLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: comboModel.isExpired ? const Color.fromARGB(255, 254, 243, 245) : appConstants.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(
              color: comboModel.isExpired ? appConstants.red.withOpacity(0.6) : appConstants.black12,
              blurRadius: comboModel.isExpired ? 1.r : 4.r,
              offset: Offset(0, 3.r),
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.w, top: 2.h, bottom: 2.h),
              child: CommonWidget.imageBuilder(
                imageUrl: comboModel.imagePath,
                height: 80.r,
                width: 80.r,
                borderRadius: 5.r,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  comboProductDetails(comboModel: comboModel, index: index),
                  comboValidatationDetail(comboModel: comboModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comboProductDetails({required ComboModel comboModel, required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonWidget.commonText(
                  text: "#${index + 1} ",
                  fontSize: 12.sp,
                  bold: true,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 5.w),
                SizedBox(
                  width: 162.w,
                  child: CommonWidget.commonText(
                      text: comboModel.comboName,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start),
                ),
              ],
            ),
            Row(
              children: [
                CommonWidget.commonText(
                  text: "${TranslationConstants.combo_price.translate(context)}: ",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                CommonWidget.commonText(
                  text: "₹${comboModel.comboPrice}",
                  color: appConstants.editbuttonColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Row(
            children: [
              CommonWidget.imageButton(
                iconSize: 18.r,
                svgPicturePath: "assets/photos/svg/common/edit.svg",
                onTap: () {
                  CommonRouter.pushNamed(RouteList.create_combo_screen, arguments: ComboType.Edit);
                },
              ),
              SizedBox(width: 12.w),
              CommonWidget.imageButton(
                svgPicturePath: "assets/photos/svg/common/trash.svg",
                iconSize: 18.r,
                onTap: () {
                  showAlertDialog(
                    noButtonColor: appConstants.theme7Color,
                    context: context,
                    isTitle: true,
                    titleText: TranslationConstants.confirm_delete.translate(context),
                    text: TranslationConstants.sure_delete_combo_offer.translate(context),
                    titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                          color: appConstants.themeColor,
                        ),
                    contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                          color: appConstants.textColor,
                        ),
                    width: 200.w,
                    maxLine: 2,
                    onNoTap: () {
                      CommonRouter.pop();
                    },
                    onTap: () {
                      CommonRouter.pop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget comboValidatationDetail({required ComboModel comboModel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonWidget.commonText(
                  text: "${TranslationConstants.start_date.translate(context)} : ",
                  color: appConstants.editbuttonColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                CommonWidget.commonText(
                  text: comboModel.startDate,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CommonWidget.commonText(
                      text: "${TranslationConstants.end_date.translate(context)} : ",
                      color: appConstants.editbuttonColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CommonWidget.commonText(
                      text: comboModel.endDate,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        comboModel.isExpired
            ? CommonWidget.commonText(
                text: TranslationConstants.combo_expired.translate(context),
                color: appConstants.red,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.app_live_status.translate(context),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  BlocBuilder<ToggleCubit, bool>(
                    bloc: comboCubit.appLiveStatus,
                    builder: (context, state) {
                      return SizedBox(
                        height: 30.h,
                        width: 40.w,
                        child: CommonWidget.toggleButton(
                          value: comboModel.isAppLive,
                          onChanged: (bool value) {
                            setState(() {
                              comboModel.isAppLive = value;
                            });
                            comboCubit.appLiveStatus.setValue(value: value);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ],
    );
  }

  Widget createComboButton(BuildContext context) {
    return Container(
      height: 80.h,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 90.w),
      decoration: BoxDecoration(
        color: appConstants.white,
        boxShadow: [
          BoxShadow(
            color: appConstants.theme7Color,
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: CommonWidget.commonButton(
        width: 150.w,
        context: context,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/add_icon.svg",
              height: 16.r,
            ),
            SizedBox(width: 10.w),
            CommonWidget.commonText(
              text: TranslationConstants.create_combo.translate(context),
              color: appConstants.white,
              fontSize: 13.sp,
            ),
          ],
        ),
        onTap: () {
          CommonRouter.pushNamed(RouteList.create_combo_screen, arguments: ComboType.Create);
        },
      ),
    );
  }

  // Widget searchTextField({required ComboLoadedState state}) {
  //   return SizedBox(
  //     height: newDeviceType == NewDeviceType.phone
  //         ? 45.h
  //         : newDeviceType == NewDeviceType.tablet
  //             ? 50.h
  //             : 40.h,
  //     child: CommonWidget.textField(
  //       controller: comboCubit.searchController,
  //       isPrefixIcon: true,
  //       prefixIconPath: "assets/photos/svg/customer/search.svg",
  //       hintText: TranslationConstants.search_here.translate(context),
  //       cursorColor: appConstants.neutral3Color,
  //       borderColor: const Color(0xffD3E8FF),
  //       focusedBorderColor: const Color(0xffD3E8FF),
  //       disabledBorderColor: const Color(0xffD3E8FF),
  //       enabledBorderColor: const Color(0xffD3E8FF),
  //       isfocusedBorderColor: true,
  //       borderRadius: 8.r,
  //       textInputType: TextInputType.text,
  //       onChanged: (text) {
  //         comboCubit.searchFromComboList(state: state, value: text);
  //       },
  //       contentPadding: newDeviceType == NewDeviceType.phone
  //           ? EdgeInsets.symmetric(horizontal: 10.w)
  //           : newDeviceType == NewDeviceType.tablet
  //               ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h)
  //               : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
  //     ),
  //   );
  // }

  Future sortFilterDialogs({
    required BuildContext context,
    required CounterCubit counterCubit,
    required SortFilterCubit sortFilterCubit,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<SortFilterCubit, SortFilterState>(
          bloc: sortFilterCubit,
          builder: (context, state) {
            if (state is SortFilterLoadedState) {
              return AlertDialog(
                surfaceTintColor: appConstants.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                ),
                insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
                contentPadding: EdgeInsets.zero,
                titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                title: SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: dialogView(
                    context: context,
                    counterCubit: counterCubit,
                    sortFilterCubit: sortFilterCubit,
                    state: state,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget dialogView({
    required BuildContext context,
    required CounterCubit counterCubit,
    required SortFilterCubit sortFilterCubit,
    required SortFilterLoadedState state,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        dialogTitle(context: context),
        SizedBox(height: 200.h, child: customerList(counterCubit: counterCubit)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            comonButton(
              context: context,
              onTap: () => CommonRouter.pop(args: 'clear'),
              text: TranslationConstants.clear.translate(context),
              textColor: appConstants.themeColor,
              bgColor: const Color(0xffDCE8F3),
            ),
            SizedBox(width: 15.w),
            comonButton(
              context: context,
              text: TranslationConstants.apply.translate(context),
              textColor: appConstants.white,
              onTap: () => CommonRouter.pop(args: filterCategoryByName[counterCubit.state]),
              bgColor: appConstants.themeColor,
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget customerList({required CounterCubit counterCubit}) {
    return ListView.builder(
      primary: false,
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filterByNameAndCategory.length,
      itemBuilder: (context, index) => commonFilterItem(
        index: index,
        counterCubit: counterCubit,
      ),
    );
  }

  Widget commonFilterItem({required int index, required CounterCubit counterCubit}) {
    return BlocBuilder<CounterCubit, int>(
      bloc: counterCubit,
      builder: (context, state) {
        filterIndex = state;
        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            counterCubit.chanagePageIndex(index: index);
            // supplierCubit.filterIndex = index;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: filterByNameAndCategory[index],
                style: TextStyle(
                  fontSize: 16.r,
                  color: index == state ? const Color(0xff4392F1) : const Color(0xff293847).withOpacity(0.8),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  value: index,
                  groupValue: state,
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xff4392F1);
                      } else {
                        return appConstants.black45;
                      }
                    },
                  ),
                  onChanged: (value) {
                    counterCubit.chanagePageIndex(index: value!);
                    // supplierCubit.filterIndex = index;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dialogTitle({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: "Sort Filter",
          style: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                color: appConstants.theme1Color,
              ),
        ),
        IconButton(
          onPressed: () => CommonRouter.pop(args: 'error'),
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/close_icon.svg",
            height: 22.r,
          ),
        ),
      ],
    );
  }
}
