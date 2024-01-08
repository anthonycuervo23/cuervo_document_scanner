import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/combo/data/models/create_combo_model.dart/create_combo_model.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/create_combo/create_combo_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/create_combo/create_combo_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_image_pick_textfeild.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class CreateComboWidget extends State<CreateComboScreen> with WidgetsBindingObserver {
  late CreateComboCubit createComboCubit;
  late ToggleCubit showSearchProductCubit;
  int totalAmountOfProduct = 0;

  // final FocusNode searchbarFocusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    createComboCubit = getItInstance<CreateComboCubit>();
    showSearchProductCubit = getItInstance<ToggleCubit>();
    createComboCubit.initialState();
  }

  @override
  void dispose() {
    createComboCubit.close();
    showSearchProductCubit.close();
    super.dispose();
  }

  Widget screenView({
    required BuildContext context,
    required CreateComboLoadedState state,
    required ComboType comboType,
  }) {
    return GestureDetector(
      onTap: () {
        createComboCubit.searchController.clear();
        showSearchProductCubit.setValue(value: false);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchTextField(context: context, comboLoadedState: state),
                    Visibility(visible: state.selectedData != null, child: selectedProductData(state: state)),
                    Visibility(
                      visible: totalAmountOfProduct != 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: CommonWidget.commonDashLine(),
                      ),
                    ),
                    Visibility(visible: totalAmountOfProduct != 0, child: totalamountWidget()),
                    titleOfTextField(title: TranslationConstants.upload_combo_image.translate(context)),
                    CommonImagePickTextFeild(
                      pickImageCubit: createComboCubit.pickImageCubitCubit,
                      isMultipleImagePick: false,
                    ),
                    comboDetailFields(),
                  ],
                ),
              ),
            ),
          ),
          submitButton(context: context, comboType: comboType),
        ],
      ),
    );
  }

  Widget selectedProductData({required CreateComboLoadedState state}) {
    return ListView.builder(
      itemCount: state.selectedData?.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return selectedProductDetail(
          state: state,
          index: index,
        );
      },
    );
  }

  Widget searchTextField({required BuildContext context, required CreateComboLoadedState comboLoadedState}) {
    return BlocBuilder<ToggleCubit, bool>(
      bloc: showSearchProductCubit,
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: createComboCubit.searchController,
              cursorColor: appConstants.neutral3Color,
              decoration: InputDecoration(
                filled: true,
                fillColor: appConstants.white,
                hintText: '${TranslationConstants.search_product.translate(context)}...',
                suffixIcon: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/customer/search.svg",
                    height: 2.h,
                    width: 2.w,
                  ),
                ),
                contentPadding: newDeviceType == NewDeviceType.phone
                    ? EdgeInsets.symmetric(horizontal: 10.w)
                    : newDeviceType == NewDeviceType.tablet
                        ? EdgeInsets.symmetric(horizontal: 10.w, vertical: 17.h)
                        : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: appConstants.orderScreenSearchFieldBorderColor),
                ),
              ),
              // focusNode: searchbarFocusNode,
              onChanged: (value) {
                createComboCubit.searchProduct(state: comboLoadedState, searchText: value);
                if (value.isEmpty || comboLoadedState.searchedData?.isEmpty == true) {
                  showSearchProductCubit.setValue(value: false);
                } else {
                  showSearchProductCubit.setValue(value: true);
                }
              },
            ),
            Visibility(
              visible: showSearchProductCubit.state,
              child: Visibility(
                visible: comboLoadedState.searchedData?.isNotEmpty ?? false,
                child: Container(
                  height: 130.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: appConstants.white,
                    border: Border.all(color: appConstants.orderScreenSearchFieldBorderColor),
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color: appConstants.theme7Color,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Visibility(
                    visible: comboLoadedState.searchedData?.isNotEmpty ?? false,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                          thumbColor: MaterialStateProperty.all(appConstants.theme1Color),
                          trackColor: MaterialStatePropertyAll(
                            appConstants.orderScreenSelectedCategoryColor.withOpacity(0.3),
                          ),
                          radius: Radius.circular(20.r),
                          thickness: MaterialStatePropertyAll(5.r),
                          minThumbLength: 22.r,
                          mainAxisMargin: 2.r,
                        ),
                      ),
                      child: Scrollbar(
                        controller: scrollController,
                        trackVisibility: true,
                        thumbVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: comboLoadedState.searchedData?.length,
                          itemBuilder: (context, index) {
                            CreateComboModel createComboModel = comboLoadedState.searchedData![index];
                            return searchBarHintProductDetails(
                              createComboModel: createComboModel,
                              state: comboLoadedState,
                              onTap: () {
                                createComboCubit.selectProduct(
                                  state: comboLoadedState,
                                  createComboModel: createComboModel,
                                );
                                totalComboAmount(
                                  price: createComboModel.price,
                                  state: comboLoadedState,
                                  isAdd: true,
                                );
                                showSearchProductCubit.setValue(value: false);
                                createComboCubit.searchController.clear();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget selectedProductDetail({required CreateComboLoadedState state, required int index}) {
    List<CreateComboModel> selectedData = state.selectedData ?? [];
    if (selectedData.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: CommonWidget.commonBulletPoint(size: 4.r, color: appConstants.theme1Color),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: CommonWidget.commonText(
                            text: selectedData[index].productName,
                            fontSize: 14.sp,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        CommonWidget.commonText(
                          text: '(${selectedData[index].weight})',
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 18.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonWidget.commonText(
                  text: "₹${selectedData[index].price}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  textOverflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 15.w),
                GestureDetector(
                  onTap: () {
                    CreateComboModel createComboModel = state.selectedData![index];
                    createComboCubit.removeProduct(createComboModel: createComboModel, state: state);
                    totalComboAmount(price: createComboModel.price, state: state, isAdd: false);
                  },
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/common/trash.svg",
                    height: 18.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget searchBarHintProductDetails({
    required CreateComboModel createComboModel,
    required VoidCallback onTap,
    required CreateComboLoadedState state,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 7.h, right: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: CommonWidget.commonText(
                      text: createComboModel.productName,
                      fontSize: 13.sp,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  CommonWidget.commonText(
                    text: '(${createComboModel.weight})',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 18.w),
            CommonWidget.commonText(
              text: "₹${createComboModel.price}",
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget totalamountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.total_amount.translate(context),
          fontSize: 15.sp,
        ),
        Padding(
          padding: EdgeInsets.only(right: 24.w, bottom: 12.w),
          child: CommonWidget.commonText(
            text: "₹$totalAmountOfProduct",
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }

  Widget titleOfTextField({required String title}) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
      child: CommonWidget.commonText(
        text: title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget comboDetailFields() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleOfTextField(title: TranslationConstants.combo_name.translate(context)),
        CommonWidget.textField(
          hintText: "Ex: Cookies + Black forest cake...",
          hintSize: 14.sp,
          hintColor: appConstants.theme5Color,
          textInputType: TextInputType.text,
        ),
        titleOfTextField(title: TranslationConstants.combo_amount.translate(context)),
        CommonWidget.textField(
          hintText: "Ex: ₹1550",
          hintSize: 14.sp,
          hintColor: appConstants.theme5Color,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleOfTextField(title: TranslationConstants.combo_start_date.translate(context)),
                  CommonWidget.textField(
                    controller: createComboCubit.startDateController,
                    hintText: formatter.format(DateTime.now()),
                    hintSize: 14.sp,
                    hintColor: appConstants.theme5Color,
                    issuffixIcon: true,
                    suffixIconpath: "assets/photos/svg/common/calender.svg",
                    suffixIconColor: appConstants.theme3Color,
                    readOnly: true,
                    focusedBorderColor: appConstants.theme4Color,
                    onTap: () async {
                      List<DateTime?>? selectedDate = await CommonWidget.datePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        String formattedDate = formatter.format(selectedDate.first!);
                        createComboCubit.startDateController.text = formattedDate;
                        createComboCubit.comboOfferStartDate = selectedDate.first;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleOfTextField(title: TranslationConstants.create_combo.translate(context)),
                  CommonWidget.textField(
                    hintText: formatter.format(DateTime.now()),
                    hintSize: 14.sp,
                    hintColor: appConstants.theme5Color,
                    controller: createComboCubit.endDateController,
                    issuffixIcon: true,
                    suffixIconpath: "assets/photos/svg/common/calender.svg",
                    suffixIconColor: appConstants.theme3Color,
                    readOnly: true,
                    focusedBorderColor: appConstants.theme4Color,
                    onTap: () async {
                      if (createComboCubit.comboOfferStartDate != null) {
                        List<DateTime?>? selectedDate = await CommonWidget.datePicker(
                          context: context,
                          firstDate: createComboCubit.comboOfferStartDate,
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (selectedDate != null) {
                          String formattedDate = formatter.format(selectedDate.first!);
                          createComboCubit.endDateController.text = formattedDate;
                        }
                      } else {
                        return CustomSnackbar.show(
                          snackbarType: SnackbarType.ERROR,
                          message: "Select Combo start date First",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget submitButton({required BuildContext context, required ComboType comboType}) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: appConstants.white,
        boxShadow: [
          BoxShadow(
            color: appConstants.theme7Color,
            blurRadius: 4,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: CommonWidget.commonButton(
        width: ScreenUtil().screenWidth,
        context: context,
        text: comboType == ComboType.Edit
            ? TranslationConstants.edit_combo.translate(context)
            : TranslationConstants.submit.translate(context),
        alignment: Alignment.center,
        textColor: appConstants.white,
        onTap: () {
          CommonRouter.pop();
        },
      ),
    );
  }

  void totalComboAmount({required CreateComboLoadedState state, required int price, required bool isAdd}) {
    if (isAdd) {
      totalAmountOfProduct = totalAmountOfProduct + price;
    } else {
      totalAmountOfProduct = totalAmountOfProduct - price;
    }
  }
}
