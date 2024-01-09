// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/domain/args/image_crop_args.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonImagePickTextFeild extends StatefulWidget {
  final bool isMultipleImagePick;
  final PickImageCubit pickImageCubit;
  bool? isEdit = false;
  bool? isShowImag = true;
  Color? borderColor;
  double? borderRadius;
  CommonImagePickTextFeild({
    super.key,
    required this.isMultipleImagePick,
    required this.pickImageCubit,
    this.isEdit,
    this.isShowImag,
    this.borderColor,
    this.borderRadius,
  });

  @override
  State<CommonImagePickTextFeild> createState() => _CommonImagePickTextFeildState();
}

class _CommonImagePickTextFeildState extends State<CommonImagePickTextFeild> {
  late PickImageCubit pickImageCubit;

  @override
  void initState() {
    pickImageCubit = widget.pickImageCubit;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickImageCubit, double>(
      bloc: pickImageCubit,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: widget.borderColor ?? const Color(0xff084277).withOpacity(0.6)),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => commonImagePickerBottomSheet(
                      context: context,
                      pickImageCubit: pickImageCubit,
                      isMultipleImagePick: widget.isMultipleImagePick,
                    ),
                    child: CommonWidget.container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                      color: appConstants.cookingWarning.withOpacity(0.2),
                      borderRadius: 5.r,
                      child: CommonWidget.commonText(
                        text: TranslationConstants.browse.translate(context),
                        fontSize: 12.sp,
                        color: appConstants.neutral4Color,
                      ),
                    ),
                  ),
                  CommonWidget.sizedBox(width: 5.w),
                  CommonWidget.commonText(
                    text: pickImageCubit.imageList.isNotEmpty
                        ? "${pickImageCubit.imageList.length} Image Selected"
                        : TranslationConstants.choose_file.translate(context),
                    fontSize: 12.sp,
                  ),
                  const Spacer(),
                  widget.isEdit == true && pickImageCubit.imageList.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            CommonRouter.pushNamed(RouteList.catalogue_screen, arguments: pickImageCubit);
                          },
                          child: CommonWidget.container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3),
                            color: appConstants.buttonColor,
                            borderRadius: 5.r,
                            child: CommonWidget.commonText(
                              text: TranslationConstants.edit.translate(context),
                              fontSize: 12.sp,
                              color: appConstants.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            CommonWidget.sizedBox(height: 5),
            CommonWidget.commonText(
              text: TranslationConstants.choose_file_note.translate(context),
              color: appConstants.neutral9Color,
              fontSize: 10.sp,
            ),
            CommonWidget.sizedBox(height: 8),
            Visibility(
              visible: widget.isShowImag ?? true,
              child: widget.isMultipleImagePick && pickImageCubit.imageList.isNotEmpty
                  ? CommonWidget.sizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pickImageCubit.imageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                image: DecorationImage(
                                  image: MemoryImage(pickImageCubit.imageList[index].bytes),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      ImageCropArgs cropArgs = ImageCropArgs(
                                        imagePathOrURL: pickImageCubit.imageList[index].path,
                                        aspectRatio: 0,
                                      );
                                      Uint8List bytes =
                                          await CommonRouter.pushNamed(RouteList.image_crop_screen, arguments: cropArgs)
                                              as Uint8List;
                                      pickImageCubit.cropedImage(bytes: bytes, index: index);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.r),
                                        bottomRight: Radius.circular(15.r),
                                      ),
                                      child: CommonWidget.container(
                                        height: 27,
                                        width: 25,
                                        color: appConstants.editbuttonColor,
                                        alignment: Alignment.center,
                                        child: CommonWidget.imageBuilder(
                                          imageUrl: "assets/photos/svg/setting_screen/address_screen/edit_pen.svg",
                                          height: 15.h,
                                          color: appConstants.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => pickImageCubit.removeData(index: index),
                                    child: CommonWidget.container(
                                      height: 27,
                                      width: 25,
                                      color: appConstants.editbuttonColor,
                                      isBorderOnlySide: true,
                                      bottomLeft: 15.r,
                                      topRight: 7.r,
                                      alignment: Alignment.center,
                                      child: CommonWidget.imageBuilder(
                                        imageUrl: "assets/photos/svg/common/close_icon.svg",
                                        height: 20.h,
                                        color: appConstants.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

void commonImagePickerBottomSheet({
  required BuildContext context,
  required PickImageCubit pickImageCubit,
  required bool isMultipleImagePick,
}) {
  openBottomBar(
    context: context,
    heightFactor: 0.22.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.uploadImg.translate(context),
                style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 13.sp),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  CommonRouter.pop();
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 25.r,
                  color: appConstants.buttonColor,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: appConstants.dividerColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/add_product/camera.svg",
                    iconSize: 30.r,
                    onTap: () {
                      if (isMultipleImagePick) {
                        pickImageCubit.pickMultiImage(pickType: "camara");
                        CommonRouter.pop();
                      } else {
                        pickImageCubit.pickImage(pickType: "camara");
                        CommonRouter.pop();
                      }
                    },
                  ),
                  CommonWidget.sizedBox(height: 10),
                  CommonWidget.commonText(
                    text: TranslationConstants.camera.translate(context),
                    style: TextStyle(
                      color: appConstants.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(width: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/add_product/gallery.svg",
                    onTap: () {
                      if (isMultipleImagePick) {
                        pickImageCubit.pickMultiImage(pickType: "gallery");
                        CommonRouter.pop();
                      } else {
                        pickImageCubit.pickImage(pickType: "gallery");
                        CommonRouter.pop();
                      }
                    },
                    iconSize: 30.r,
                  ),
                  CommonWidget.sizedBox(height: 10),
                  CommonWidget.commonText(
                    text: TranslationConstants.gallery.translate(context),
                    style: TextStyle(
                      color: appConstants.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
