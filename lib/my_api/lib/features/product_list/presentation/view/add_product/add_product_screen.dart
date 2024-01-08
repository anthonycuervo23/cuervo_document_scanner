import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_state.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/add_product/add_product_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends AddProductWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.add_product.translate(context),
        titleCenter: false,
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: CommonWidget.container(
            color: appConstants.buttonColor,
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
            borderRadius: 25.r,
            child: CommonWidget.commonText(
              text: TranslationConstants.save.translate(context),
              style: TextStyle(color: appConstants.white),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AddNewProductCubit, AddNewProductState>(
        bloc: addNewCategoryCubit,
        builder: (context, state) {
          if (state is AddNewProductLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        commonTextField(
                          hinttext: TranslationConstants.product_name.translate(context),
                          title: "${TranslationConstants.product_name.translate(context).toCamelcase()}:",
                          height: 50.h,
                          width: double.infinity,
                          textInputType: TextInputType.multiline,
                        ),
                        productTextFields(
                          title: "${TranslationConstants.product_category.translate(context)}:",
                          hintText: TranslationConstants.product_category.translate(context),
                          onTap: () => selectCategoryBottomSheet(state: state),
                        ),
                        productTextFields(
                          title: "${TranslationConstants.product_brand.translate(context)}:",
                          hintText: TranslationConstants.product_brand.translate(context),
                          onTap: () {
                            selectBrandBottomSheet(state: state);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          child: CommonWidget.commonText(
                            text: "${TranslationConstants.product_attributes.translate(context)}:",
                            style: TextStyle(
                              color: appConstants.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        productAttribute(state: state),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                          child: CommonWidget.commonText(
                            text: TranslationConstants.choose_attributes.translate(context),
                            style: TextStyle(
                              color: appConstants.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                        chooseAttribute(state: state),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: variant(state: state),
                        ),
                        commonTextField(
                          title: TranslationConstants.product_details.translate(context),
                          hinttext: TranslationConstants.detail.translate(context),
                          maxline: 5,
                          hintMaxline: 2,
                          width: double.infinity,
                          textInputType: TextInputType.multiline,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.pin_priority.translate(context),
                              style: TextStyle(
                                color: appConstants.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocBuilder<ToggleCubit, bool>(
                              bloc: addNewCategoryCubit.pinPriorityCubit,
                              builder: (context, state) {
                                return CommonWidget.toggleButton(
                                  value: state,
                                  onChanged: (bool value1) {
                                    addNewCategoryCubit.pinPriorityCubit.setValue(value: value1);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.app_live_status.translate(context),
                              style: TextStyle(
                                color: appConstants.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocBuilder<ToggleCubit, bool>(
                              bloc: addNewCategoryCubit.appliveCubit,
                              builder: (context, state) {
                                return CommonWidget.toggleButton(
                                  value: state,
                                  onChanged: (bool value1) {
                                    addNewCategoryCubit.appliveCubit.setValue(value: value1);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                          child: productSelling(state: state),
                        ),
                        CommonWidget.commonText(
                          text: "Upload Img/Video",
                          style: TextStyle(
                            color: appConstants.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          child: uploadImag(),
                        ),
                        CommonWidget.commonText(
                          text: "Upload Catalogue Img",
                          style: TextStyle(
                            color: appConstants.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: catalogeImage(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.show_cataloge.translate(context),
                              style: TextStyle(
                                color: appConstants.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            BlocBuilder<ToggleCubit, bool>(
                              bloc: addNewCategoryCubit.showCatelogeCubit,
                              builder: (context, state) {
                                return CommonWidget.toggleButton(
                                  value: state,
                                  onChanged: (bool value1) {
                                    addNewCategoryCubit.showCatelogeCubit.setValue(value: value1);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AddNewProductLoadedState) {
            return CommonWidget.loadingIos();
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CommonWidget.container(
        shadow: [
          BoxShadow(
            blurRadius: 5.r,
            color: appConstants.dividerColor,
            offset: const Offset(0, -3),
          ),
        ],
        color: appConstants.white,
        height: 80,
        width: ScreenUtil().screenWidth,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: CommonWidget.container(
                borderRadius: 10.r,
                color: appConstants.buttonColor,
                child: Center(
                  child: CommonWidget.commonText(
                    text: TranslationConstants.submit.translate(context),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: appConstants.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
