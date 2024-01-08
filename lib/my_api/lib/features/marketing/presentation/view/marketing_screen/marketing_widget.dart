import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/domain/entities/argumets/add_ads_argumets.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/marketing_screen/marketing_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class MarketingWidget extends State<MarketingScreen> {
  late MarketingCubit marketingCubit;
  late CounterCubit counterCubit;

  @override
  void initState() {
    marketingCubit = getItInstance<MarketingCubit>();
    counterCubit = getItInstance<CounterCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    marketingCubit.loadingCubit.hide();
    marketingCubit.close();
    counterCubit.close();
  }

  PreferredSizeWidget? appbar(BuildContext context, MarketingLoadedState state) {
    return CustomAppBar(
      context,
      title: TranslationConstants.marketing.translate(context),
      leadingIcon: true,
      leadingIconUrl: "assets/photos/svg/common/app_bar_back_arrow.svg",
      onTap: () => CommonRouter.pop(),
      titleCenter: false,
      trailing: Visibility(
        visible: state.displayFilter,
        child: CommonWidget.textButton(
            padding: EdgeInsets.only(right: 20.w),
            text: "Reset",
            fontSize: 15.sp,
            onTap: () {
              marketingCubit.resetData(state: state);
            },
            textColor: appConstants.editbuttonColor),
      ),
    );
  }

  Widget tabBarView({required BuildContext context, required MarketingLoadedState state}) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: appConstants.shadowColor,
            spreadRadius: 3,
          )
        ],
        color: appConstants.white,
        border: Border(
          top: BorderSide(
            color: appConstants.black26,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        padding: EdgeInsets.zero,
        dividerColor: appConstants.transparent,
        indicatorColor: appConstants.editbuttonColor,
        onTap: (value) => marketingCubit.changeMarketingMode(state: state, value: value),
        tabs: [
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.banner,
            title: TranslationConstants.banner.translate(context).toCamelcase(),
          ),
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.popUp,
            title: TranslationConstants.popup.translate(context).toCamelcase(),
          ),
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.notification,
            title: TranslationConstants.notification.translate(context).toCamelcase(),
          ),
        ],
      ),
    );
  }

  Tab commonTab({
    required SelectedTab selectedTab,
    required String title,
    required SelectedTab tabName,
  }) {
    return Tab(
      child: CommonWidget.commonText(
        text: title,
        fontSize: 14.sp,
        color: selectedTab == tabName ? appConstants.editbuttonColor : appConstants.black38,
      ),
    );
  }

  Widget addAdsButton(MarketingLoadedState state, BuildContext context) {
    return CommonWidget.container(
      height: 80.h,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          AddAdsScreebArgs addAdsScreebArgs = AddAdsScreebArgs(
            marketingDataModel: MarketingDataModel(
              desription: "",
              endDate: "",
              image: "",
              link: "",
              liveStatus: false,
              startDate: "",
              title: "",
              linkType: "",
            ),
            selectedTab: state.selectedTab,
            fromEditScreen: false,
          );
          CommonRouter.pushNamed(RouteList.add_ads_screen, arguments: addAdsScreebArgs);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          width: newDeviceType == NewDeviceType.phone
              ? 180.w
              : newDeviceType == NewDeviceType.tablet
                  ? ScreenUtil().screenWidth / 1.5
                  : ScreenUtil().screenWidth / 1.2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: appConstants.themeColor),
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
                state.selectedTab.name == SelectedTab.banner.name
                    ? TranslationConstants.add_banner.translate(context).toCamelcase()
                    : state.selectedTab.name == SelectedTab.popUp.name
                        ? TranslationConstants.add_popup.translate(context).toCamelcase()
                        : TranslationConstants.add_notification.translate(context).toCamelcase(),
                style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget marketingFilterAndSearchField({required MarketingLoadedState state}) {
    return commonSearchAndFilterField(
      onChanged: (v) {
        marketingCubit.commonFilter(state: state);
      },
      controller: marketingCubit.searchField,
      context: context,
      onTapSearchCalenderButton: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusScope.of(context).unfocus();
        }
        String value = await searchFilterDialog(
          context: context,
          searchFilterCubit: orderHistoryCubit.searchFilterCubit,
        );
        marketingCubit.filterForDate(value: value, state: state);
      },
      onTapForFilter: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusScope.of(context).unfocus();
        }
        FocusScope.of(context).unfocus();
        var value = await generalFilterView(state: state);
        if (value != null) {
          marketingCubit.filterData(state: state, value: value);
        }
      },
    );
  }

  Future generalFilterView({required MarketingLoadedState state}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: appConstants.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          contentPadding: EdgeInsets.all(16.h),
          titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
          content: SizedBox(
            width: ScreenUtil().screenWidth,
            child: BlocBuilder<CounterCubit, int>(
              bloc: counterCubit,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonDialogTitle(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: marketingCubit.dataArangeFilter.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            counterCubit.chanagePageIndex(index: index);
                          },
                          child: CommonWidget.sizedBox(
                            height: 50.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonWidget.commonText(
                                  text: marketingCubit.dataArangeFilter[index],
                                  style: TextStyle(
                                    fontSize: 16.r,
                                    color: index == state ? appConstants.editbuttonColor : appConstants.black,
                                    fontWeight: index == state ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                                commonRadioButton(index: index, state: state),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    applyClearButton(state: state),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget commonDialogTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.sort_filter.translate(context),
          color: appConstants.theme1Color,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onPressed: () => CommonRouter.pop(),
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/close_icon.svg",
            height: 22.r,
            color: appConstants.theme1Color,
          ),
        ),
      ],
    );
  }

  Widget applyClearButton({required int state}) {
    return Row(
      children: [
        Expanded(
          child: CommonWidget.commonButton(
            context: context,
            alignment: Alignment.center,
            onTap: () {
              counterCubit.chanagePageIndex(index: 0);
              CommonRouter.pop(args: marketingCubit.dataArangeFilter[state]);
            },
            text: TranslationConstants.clear.translate(context),
            textColor: appConstants.theme1Color,
            color: appConstants.theme1Color.withOpacity(0.2),
            borderRadius: 8.r,
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
        CommonWidget.sizedBox(width: 10.w),
        Expanded(
          child: CommonWidget.commonButton(
            context: context,
            alignment: Alignment.center,
            onTap: () {
              CommonRouter.pop(args: marketingCubit.dataArangeFilter[state]);
            },
            text: TranslationConstants.apply.translate(context),
            textColor: appConstants.white,
            color: appConstants.theme1Color,
            borderRadius: 8.r,
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
        ),
      ],
    );
  }

  Widget commonRadioButton({required int index, required int state}) {
    return Transform.scale(
      scale: 1,
      child: Radio(
        visualDensity:
            const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: state,
        groupValue: index,
        overlayColor: MaterialStatePropertyAll(appConstants.red),
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return appConstants.editbuttonColor;
            } else {
              return appConstants.black26;
            }
          },
        ),
        onChanged: (value) {
          counterCubit.chanagePageIndex(index: value ?? 0);
        },
      ),
    );
  }
}
