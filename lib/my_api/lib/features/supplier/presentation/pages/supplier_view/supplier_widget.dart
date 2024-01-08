import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/sort_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/supplier_cubit/supplier_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_view/supplier_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SupplierWidget extends State<SupplierScreen> {
  late SupplierCubit supplierCubit;

  @override
  void initState() {
    super.initState();
    supplierCubit = getItInstance<SupplierCubit>();
    supplierCubit.loadSupplierData();
  }

  Widget supplierDetails({
    required SupplierDetailModel supplierDetailModel,
    required BuildContext context,
    required SupplierLoadedState state,
    required int index,
  }) {
    return InkWell(
      onTap: () => CommonRouter.pushNamed(
        RouteList.supplier_details_screen,
        arguments: supplierDetailModel,
      ),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        shadowColor: appConstants.theme8Color,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    profileImage(supplierDetailModel, context),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () => makePhoneCall(supplierDetailModel.mobileNumber),
                      child: Container(
                        height: newDeviceType == NewDeviceType.phone ? 35.h : 45.h,
                        width: newDeviceType == NewDeviceType.phone ? 35.w : 45.w,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appConstants.green,
                        ),
                        padding: newDeviceType == NewDeviceType.phone
                            ? EdgeInsets.only(top: 11.h, left: 11.w, right: 11.w, bottom: 11.h)
                            : newDeviceType == NewDeviceType.tablet
                                ? EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w, bottom: 15.h)
                                : EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 10.h),
                        child: CommonWidget.imageBuilder(
                          height: newDeviceType == NewDeviceType.phone ? 10.h : 30.h,
                          width: newDeviceType == NewDeviceType.phone ? 10.w : 30.w,
                          imageUrl: "assets/photos/svg/customer/call.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.h, right: 11.w, left: 5.w, top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonWidget.commonText(
                            text: supplierDetailModel.name,
                            style: TextStyle(fontSize: 15.sp, color: Colors.black),
                          ),
                          SizedBox(width: 10.w),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 15.w, right: 10.w, bottom: 1.h),
                            child: InkWell(
                              onTap: () => CommonRouter.pushNamed(RouteList.create_new_screen, arguments: {
                                "Navigate": CreateNewNavigate.supplier,
                                "supplierModel": supplierDetailModel,
                              }),
                              child: CommonWidget.container(
                                height: 30.h,
                                width: 30.w,
                                alignment: Alignment.center,
                                child: CommonWidget.imageBuilder(
                                  height: 20.h,
                                  width: 20.w,
                                  imageUrl: "assets/photos/svg/customer/edit.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 10.w, bottom: 1.h),
                            child: InkWell(
                              onTap: () {
                                showAlertDialog(
                                  noButtonColor: appConstants.theme7Color,
                                  context: context,
                                  isTitle: true,
                                  titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                                        color: appConstants.themeColor,
                                      ),
                                  contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                                        color: appConstants.textColor,
                                      ),
                                  width: 200.w,
                                  maxLine: 2,
                                  onTap: () {
                                    supplierCubit.deleteSupplier(supplierDetailModel: supplierDetailModel);
                                    CommonRouter.pop();
                                  },
                                  titleText: TranslationConstants.confirm_delete.translate(context),
                                  text: TranslationConstants.sure_delete_supplier.translate(context),
                                );
                              },
                              splashFactory: InkRipple.splashFactory,
                              child: CommonWidget.container(
                                height: 30.h,
                                width: 30.w,
                                alignment: Alignment.center,
                                child: CommonWidget.imageBuilder(
                                  height: 20.h,
                                  width: 20.w,
                                  imageUrl: "assets/photos/svg/customer/delete.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CommonWidget.commonText(
                        text: supplierDetailModel.mobileNumber,
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Row(
                          children: [
                            CommonWidget.commonText(
                              text: "${TranslationConstants.total_item.translate(context)} : ",
                              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                            ),
                            CommonWidget.commonText(
                              text:
                                  "${supplierDetailModel.productList.length.toString()} ${TranslationConstants.items.translate(context)}",
                              style: TextStyle(fontSize: 10.sp, color: Colors.black),
                            ),
                            const Spacer(),
                            CommonWidget.commonText(
                              text: supplierDetailModel.dateTime,
                              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      amountBox(supplierDetailModel: supplierDetailModel, context: context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell profileImage(SupplierDetailModel supplierDetailModel, BuildContext context) {
    return InkWell(
      onTap: () {
        CommonWidget.commonImageDialog(
          path: supplierDetailModel.profileImage ?? "assets/photos/svg/common/users.svg",
          context: context,
        );
      },
      child: Container(
        height: newDeviceType == NewDeviceType.phone ? 45.h : 50.h,
        width: newDeviceType == NewDeviceType.phone ? 45.w : 50.w,
        decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: CommonWidget.imageBuilder(
            height: supplierDetailModel.profileImage != null ? 45.h : 30.h,
            width: supplierDetailModel.profileImage != null ? 45.h : 30.h,
            imageUrl: supplierDetailModel.profileImage ?? "assets/photos/svg/common/users.svg",
          ),
        ),
      ),
    );
  }

  Widget amountBox({required SupplierDetailModel supplierDetailModel, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(top: 9.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: supplierDetailModel.totalOrderAmount != null,
            child: Container(
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  color: const Color(0xffDEDEDE),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w, bottom: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TranslationConstants.total_order_amount.translate(context),
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: appConstants.theme2Color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CommonWidget.commonText(
                      text: supplierDetailModel.totalOrderAmount?.formatCurrency() ?? "",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: appConstants.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: supplierDetailModel.balance != null,
            child: balanceBox(supplierDetailModel: supplierDetailModel, context: context),
          ),
        ],
      ),
    );
  }

  Widget balanceBox({required SupplierDetailModel supplierDetailModel, required BuildContext context}) {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
        color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
            ? const Color(0xffF2FBF0)
            : const Color(0xffFFEFEF),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
              ? const Color(0xff86D173)
              : const Color(0xffFF8888),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, top: 5.h, right: 10.w, bottom: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TranslationConstants.balance.translate(context),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: appConstants.theme2Color,
                  ),
                ),
                const Spacer(),
                Text(
                  supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                      ? TranslationConstants.to_collect.translate(context)
                      : TranslationConstants.to_pay.translate(context),
                  style: TextStyle(
                    color: supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                        ? const Color(0xff25B800)
                        : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                CommonWidget.commonText(
                  text: supplierDetailModel.balance?.formatCurrency() ?? "",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: appConstants.themeColor,
                  ),
                ),
                const Spacer(),
                supplierDetailModel.balanceType == CustomerBalanceType.ToCollect
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          size: 15.sp,
                          color: appConstants.green,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 15.sp,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog({
    required BuildContext context,
    required VoidCallback onTap,
    required String text,
    String? titleText,
    Color? textColor,
    Color? noButtonColor,
    bool isTitle = false,
    VoidCallback? onNoTap,
    List<Widget>? actions,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    double? width,
    int? maxLine,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          surfaceTintColor: appConstants.white,
          backgroundColor: appConstants.white,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actionsPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: SizedBox(
            width: newDeviceType != NewDeviceType.phone ? 350 : ScreenUtil().screenWidth * 0.9,
            child: Column(
              children: [
                CommonWidget.sizedBox(height: 20),
                isTitle
                    ? Column(
                        children: [
                          Center(
                            child: CommonWidget.commonText(
                              lineThrough: true,
                              style: titleTextStyle ??
                                  Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                                        color: appConstants.black,
                                        height: 1,
                                      ),
                              text: titleText ?? '',
                            ),
                          ),
                          CommonWidget.sizedBox(height: 15),
                        ],
                      )
                    : const SizedBox.shrink(),
                CommonWidget.container(
                  width: width ?? double.infinity,
                  child: CommonWidget.commonText(
                    style: contentTextStyle ??
                        Theme.of(context)
                            .textTheme
                            .body1BookHeading
                            .copyWith(color: appConstants.introScreenDescriptionText),
                    text: text,
                    fontSize: 13.sp,
                    textAlign: TextAlign.center,
                    color: textColor ?? appConstants.introScreenDescriptionText,
                    maxLines: maxLine ?? 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonWidget.commonButton(
                          context: context,
                          alignment: Alignment.center,
                          onTap: onNoTap ?? () => CommonRouter.pop(),
                          text: TranslationConstants.no.translate(context),
                          textColor: appConstants.themeColor,
                          color: noButtonColor ?? appConstants.orenge,
                          borderRadius: 8.r,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: CommonWidget.commonButton(
                          context: context,
                          onTap: onTap,
                          alignment: Alignment.center,
                          text: TranslationConstants.yes.translate(context),
                          textColor: appConstants.white,
                          color: appConstants.themeColor,
                          borderRadius: 8.r,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Container bottomButton(BuildContext context) {
    return Container(
      height: 80.h,
      width: newDeviceType == NewDeviceType.phone
          ? ScreenUtil().screenWidth
          : newDeviceType == NewDeviceType.tablet
              ? ScreenUtil().screenWidth
              : double.infinity,
      color: Colors.white,
      child: Center(
        child: GestureDetector(
          onTap: () =>
              CommonRouter.pushNamed(RouteList.create_new_screen, arguments: {"Navigate": CreateNewNavigate.supplier}),
          child: Container(
            height: 40.h,
            width: newDeviceType == NewDeviceType.phone
                ? 200.w
                : newDeviceType == NewDeviceType.tablet
                    ? ScreenUtil().screenWidth / 1.5
                    : ScreenUtil().screenWidth / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: appConstants.themeColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/customer/add_new.svg",
                  height: 20.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  TranslationConstants.add_new.translate(context),
                  style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? appbar(BuildContext context) {
    return CustomAppBar(
      titleCenter: false,
      context,
      title: TranslationConstants.supplier.translate(context),
      onTap: () => CommonRouter.pop(),
      trailing: Row(
        children: [
          BlocBuilder<SupplierCubit, SupplierState>(
            bloc: supplierCubit,
            builder: (context, state) {
              if (state is SupplierLoadedState) {
                return InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => supplierCubit.reset(),
                    child: CommonWidget.commonText(
                      text: TranslationConstants.reset.translate(context),
                      color: appConstants.paidColor,
                    ));
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(
            width: 30.h,
          ),
        ],
      ),
    );
  }

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
              onTap: () {
                int value = supplierCubit.filterIndex;

                CommonRouter.pop(args: value);
              },
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
            supplierCubit.filterIndex = index;
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
                    supplierCubit.filterIndex = index;
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
