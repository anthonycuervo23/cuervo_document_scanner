import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/models/delivery_time_slot.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/delivery_time_slot/delivery_time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/delivery_time_slot/delivery_time_slot_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/widget/time_text_input_formatter.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class DeliveryTimeSlotWidget extends State<DeliveryTimeSlotScreen> {
  late DeliveryTimeSlotCubit deliveryTimeSlotCubit;

  @override
  void initState() {
    deliveryTimeSlotCubit = getItInstance<DeliveryTimeSlotCubit>();
    super.initState();
  }

  @override
  void dispose() {
    deliveryTimeSlotCubit.loadingCubit.close();
    deliveryTimeSlotCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      elevation: 0.5,
      shadowColor: true,
      shadowcolor: appConstants.successAnimationColor,
      title: TranslationConstants.delivery_time_slot.translate(context),
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
    );
  }

  Widget tabBarView({required DeliveryTimeSlotLoadedState state}) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.only(bottom: 5.h),
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
        onTap: (value) => deliveryTimeSlotCubit.changeTabMode(state: state, value: value),
        tabs: [
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.standard,
            title: TranslationConstants.standard.translate(context).toCamelcase(),
          ),
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.midnight,
            title: TranslationConstants.mid_night.translate(context).toCamelcase(),
          ),
          commonTab(
            selectedTab: state.selectedTab,
            tabName: SelectedTab.fixTime,
            title: TranslationConstants.fix_time.translate(context).toCamelcase(),
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
        fontSize: 14,
        color: selectedTab == tabName ? appConstants.editbuttonColor : appConstants.black38,
      ),
    );
  }

  Widget listTitle() {
    return CommonWidget.container(
      height: 40.h,
      width: ScreenUtil().screenWidth,
      color: appConstants.theme1Color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r),
        child: Row(
          children: [
            CommonWidget.commonText(
              text: "#",
              color: appConstants.white,
              fontSize: 12.sp,
            ),
            CommonWidget.sizedBox(width: 20),
            Expanded(
              flex: 4,
              child: CommonWidget.commonText(
                text: TranslationConstants.time.translate(context),
                color: appConstants.white,
                textAlign: TextAlign.start,
                fontSize: 12.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CommonWidget.commonText(
                text: TranslationConstants.action.translate(context),
                color: appConstants.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listView({required DeliveryTimeSlotLoadedState state}) {
    int selectedTab = state.selectedTab.index;
    return Expanded(
      child: (selectedTab == 0
              ? state.standardTimeList?.isNotEmpty == true
              : selectedTab == 1
                  ? state.midNightTimeList?.isNotEmpty == true
                  : state.fixTimeList?.isNotEmpty == true)
          ? ListView.builder(
              itemCount: selectedTab == 0
                  ? state.standardTimeList?.length
                  : selectedTab == 1
                      ? state.midNightTimeList?.length
                      : state.fixTimeList?.length,
              itemBuilder: (context, index) {
                DeliveryTimeSlotModel deliveryTimeSlotModel = selectedTab == 0
                    ? state.standardTimeList![index]
                    : selectedTab == 1
                        ? state.midNightTimeList![index]
                        : state.fixTimeList![index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                      child: Row(
                        children: [
                          CommonWidget.commonText(
                            text: "${index + 1}",
                            color: appConstants.black,
                            fontSize: 14.sp,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            flex: 4,
                            child: CommonWidget.commonText(
                              text: selectedTab == 0
                                  ? "${deliveryTimeSlotModel.fromDate} to ${deliveryTimeSlotModel.toDate}".toLowerCase()
                                  : selectedTab == 1
                                      ? "${deliveryTimeSlotModel.fromDate} to ${deliveryTimeSlotModel.toDate}"
                                          .toLowerCase()
                                      : "${deliveryTimeSlotModel.fromDate} to ${deliveryTimeSlotModel.toDate}"
                                          .toLowerCase(),
                              color: appConstants.black,
                              textAlign: TextAlign.start,
                              fontSize: 14.sp,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CommonWidget.svgIconButton(
                              onTap: () {
                                deliveryTimeSlotCubit.oldDataSet(
                                  state: state,
                                  index: index,
                                  tabIndex: selectedTab,
                                );
                                bottomSheetView(state: state, tabIndex: state.selectedTab.index);
                              },
                              svgPicturePath: 'assets/photos/svg/common/edit.svg',
                              color: appConstants.neutral1Color,
                              iconSize: 14.sp,
                            ),
                          ),
                          CommonWidget.svgIconButton(
                            svgPicturePath: 'assets/photos/svg/common/trash.svg',
                            color: appConstants.neutral1Color,
                            iconSize: 15.sp,
                            onTap: () {
                              deliveryTimeSlotCubit.deleteItem(
                                state: state,
                                itemIndex: index,
                                tabIndex: selectedTab,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(color: appConstants.dividerColor, height: 1),
                  ],
                );
              },
            )
          : CommonWidget.dataNotFound(
              context: context,
              actionButton: const SizedBox.shrink(),
            ),
    );
  }

  Widget addNewButton({required DeliveryTimeSlotLoadedState state}) {
    return GestureDetector(
      onTap: () {
        deliveryTimeSlotCubit.addNewButtonClick(state: state);

        bottomSheetView(
          state: state,
          tabIndex: state.selectedTab.index,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 75.w,
          vertical: 20.h,
        ),
        child: CommonWidget.container(
          height: 50,
          color: appConstants.theme1Color,
          borderRadius: 10.sp,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/common/add_icon.svg",
                height: 20,
              ),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                text: TranslationConstants.add_new.translate(context),
                color: appConstants.white,
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future bottomSheetView({
    required DeliveryTimeSlotLoadedState state,
    required int tabIndex,
  }) {
    return openBottomBar(
      context: context,
      backgroundColor: appConstants.drawerBackgroundColor,
      child: Container(
        color: appConstants.drawerBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
              child: Row(
                children: [
                  CommonWidget.commonText(
                    text: state.isEdited == true
                        ? TranslationConstants.edit_time.translate(context)
                        : TranslationConstants.add_time.translate(context),
                    bold: true,
                    color: appConstants.theme1Color,
                    fontSize: 16,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(),
                    child: Icon(
                      Icons.close_rounded,
                      size: 25.r,
                      color: appConstants.theme1Color,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: appConstants.dividerColor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Row(
                children: [
                  commonTimePicker(
                    state: state,
                    controller: deliveryTimeSlotCubit.fromTimePickController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CommonWidget.commonText(
                      text: 'To',
                      fontSize: 14,
                      bold: true,
                    ),
                  ),
                  commonTimePicker(
                    state: state,
                    controller: deliveryTimeSlotCubit.toTimePickController,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (state.isEdited == true) {
                  deliveryTimeSlotCubit.updateOrAddTimeSlot(
                    state: state,
                    index: tabIndex,
                    itemIndex: state.itemIndex!,
                  );
                } else {
                  deliveryTimeSlotCubit.updateOrAddTimeSlot(
                    state: state,
                    index: tabIndex,
                  );
                }

                if (deliveryTimeSlotCubit.fromTimePickController.text.isNotEmpty &&
                    deliveryTimeSlotCubit.toTimePickController.text.isNotEmpty) {
                  CommonRouter.pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: CommonWidget.container(
                  height: 45.h,
                  color: appConstants.theme1Color,
                  borderRadius: 5.sp,
                  alignment: Alignment.center,
                  child: CommonWidget.commonText(
                    text: TranslationConstants.save.translate(context),
                    color: appConstants.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget commonTimePicker({
    required DeliveryTimeSlotLoadedState state,
    required TextEditingController controller,
  }) {
    return Expanded(
      child: CommonWidget.textField(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        controller: controller,
        textInputType: TextInputType.datetime,
        maxLength: 5,
        hintText: TranslationConstants.time_hint_text.translate(context),
        inputFormatters: [
          TimeTextInputFormatter(
            hourMaxValue: 24,
            minuteMaxValue: 59,
          ),
        ],
      ),
    );
  }
}
