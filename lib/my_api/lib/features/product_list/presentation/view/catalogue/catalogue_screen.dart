import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatalogueScreen extends StatefulWidget {
  final PickImageCubit cubitData;
  const CatalogueScreen({super.key, required this.cubitData});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  late PickImageCubit addNewCategoryCubit;

  @override
  void initState() {
    addNewCategoryCubit = widget.cubitData;
    addNewCategoryCubit.tempCatalogueList = List.from(addNewCategoryCubit.imageList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          context,
          title: TranslationConstants.catalogue.translate(context),
          titleCenter: false,
          onTap: () => CommonRouter.pop(),
        ),
        body: BlocBuilder<PickImageCubit, double>(
          bloc: addNewCategoryCubit,
          builder: (context, state) {
            if (addNewCategoryCubit.tempCatalogueList.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15.r,
                          mainAxisSpacing: 15.r,
                        ),
                        itemCount: addNewCategoryCubit.tempCatalogueList.length,
                        itemBuilder: (context, index) {
                          ImageListModel tempCatalogueList = addNewCategoryCubit.tempCatalogueList[index];
                          return GestureDetector(
                            onTap: () {
                              catalogueImageDialog(
                                index: index,
                                path: tempCatalogueList.path,
                                context: context,
                                tempCatalogueList: tempCatalogueList,
                              );
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.r),
                                  child: Image.memory(
                                    height: 115.h,
                                    width: 104.w,
                                    tempCatalogueList.bytes,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        addNewCategoryCubit.tempCatalogueImageCrop(
                                          bytes: tempCatalogueList.bytes,
                                          imagePathOrURL: tempCatalogueList.path,
                                          index: index,
                                        );
                                      },
                                      child: CommonWidget.container(
                                        height: 28,
                                        width: 24,
                                        padding: EdgeInsets.all(6.r),
                                        color: appConstants.appliveColor,
                                        isBorderOnlySide: true,
                                        topLeft: 7.r,
                                        bottomRight: 15.r,
                                        child: CommonWidget.imageBuilder(
                                          imageUrl: "assets/photos/svg/add_product/edit.svg",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        addNewCategoryCubit.tempRemoveCatalogueImage(index: index);
                                      },
                                      child: CommonWidget.container(
                                        color: appConstants.appliveColor,
                                        isBorderOnlySide: true,
                                        height: 28,
                                        width: 24,
                                        topRight: 7.r,
                                        bottomLeft: 15.r,
                                        padding: EdgeInsets.all(7.r),
                                        child: CommonWidget.imageBuilder(
                                          imageUrl: "assets/photos/svg/add_product/remove.svg",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return CommonWidget.loadingIos();
            }
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CommonWidget.commonButton(
                    height: 50.h,
                    color: appConstants.theme4Color,
                    text: TranslationConstants.cancel.translate(context),
                    alignment: Alignment.center,
                    style: TextStyle(fontSize: 13.sp, color: appConstants.buttonColor, fontWeight: FontWeight.w600),
                    onTap: () {
                      addNewCategoryCubit.cancelTempData();
                      CommonRouter.pop();
                    },
                    context: context,
                  ),
                ),
                CommonWidget.sizedBox(width: 15),
                Expanded(
                  child: CommonWidget.commonButton(
                    height: 50.h,
                    color: appConstants.buttonColor,
                    text: TranslationConstants.save.translate(context),
                    alignment: Alignment.center,
                    style: TextStyle(fontSize: 13.sp, color: appConstants.white, fontWeight: FontWeight.w600),
                    onTap: () {
                      addNewCategoryCubit.saveTempData();
                      CommonRouter.pop();
                    },
                    context: context,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  catalogueImageDialog({
    required String path,
    required BuildContext context,
    required int index,
    required ImageListModel tempCatalogueList,
  }) {
    return showDialog(
      context: context,
      barrierColor: appConstants.barriarColor,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appConstants.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.only(left: 15.w, right: 15.r),
          contentPadding: EdgeInsets.zero,
          content: BlocBuilder<PickImageCubit, double>(
            bloc: addNewCategoryCubit,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    splashColor: appConstants.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => CommonRouter.pop(),
                    child: CommonWidget.container(
                      alignment: Alignment.topRight,
                      color: appConstants.transparent,
                      height: 38,
                      width: double.infinity,
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/customer/cancle_button.svg",
                        color: appConstants.white,
                        height: 30.h,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CommonWidget.container(
                      padding: EdgeInsets.symmetric(vertical: 2.5.r, horizontal: 2.5.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.memory(
                              height: 400.h,
                              width: ScreenUtil().screenWidth,
                              tempCatalogueList.bytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CommonWidget.sizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonWidget.commonButton(
                                  height: 50.h,
                                  width: 130.w,
                                  color: appConstants.buttonColor,
                                  text: TranslationConstants.edit_image.translate(context),
                                  alignment: Alignment.center,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: appConstants.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onTap: () {
                                    addNewCategoryCubit.tempCatalogueImageCrop(
                                      bytes: tempCatalogueList.bytes,
                                      imagePathOrURL: tempCatalogueList.path,
                                      index: index,
                                    );
                                  },
                                  context: context,
                                ),
                                CommonWidget.commonButton(
                                  height: 50.h,
                                  width: 130.w,
                                  color: appConstants.buttonColor,
                                  text: TranslationConstants.delete_image.translate(context),
                                  alignment: Alignment.center,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: appConstants.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onTap: () {
                                    addNewCategoryCubit.tempRemoveCatalogueImage(index: index);
                                    CommonRouter.pop();
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
