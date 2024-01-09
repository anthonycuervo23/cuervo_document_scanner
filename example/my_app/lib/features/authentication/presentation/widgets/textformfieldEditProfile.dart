// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:io';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/image_crop_args.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_state.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Widget textFormFieldEditProfile({
  required TextEditingController controller,
  required dynamic hintText,
  required BuildContext context,
  String? Function(String?)? validator,
  Function(String?)? onSaved,
  VoidCallback? oncalenderTap,
  Color? fillcolor,
  Widget? suffixwidget,
  BoxConstraints? suffixIconConstraints,
  int? maxlength,
  int? maxline,
  bool readonly = false,
  bool? enabled,
  dynamic keyboardType,
  VoidCallback? onTap,
  TextStyle? style,
  List<TextInputFormatter>? inputFormatters,
  TextInputAction? textInputAction,
  void Function(String)? onChanged,
  FocusNode? focusNode,
}) {
  return TextFormField(
    focusNode: focusNode,
    controller: controller,
    onTap: onTap,
    maxLines: maxline ?? 300,
    validator: validator,
    onSaved: onSaved,
    maxLength: maxlength,
    readOnly: readonly,
    minLines: 1,
    textInputAction: textInputAction ?? TextInputAction.next,
    inputFormatters: inputFormatters,
    cursorColor: appConstants.primary1Color,
    keyboardType: keyboardType ?? keyboardType,
    style: style ?? Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color),
    onChanged: onChanged,
    onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      counterText: "",
      fillColor: appConstants.textFiledColor,
      filled: true,
      suffixIconConstraints: suffixIconConstraints,
      suffixIcon: suffixwidget ?? const SizedBox.shrink(),
      hintStyle: Theme.of(context).textTheme.bodyBookHeading.copyWith(
            color: appConstants.default5Color,
          ),
      border: InputBorder.none,
      hintText: hintText,
      enabled: enabled ?? true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appConstants.buttonRadius),
        borderSide: BorderSide(
          color: appConstants.default6Color,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appConstants.buttonRadius),
        borderSide: BorderSide(
          color: appConstants.default6Color,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appConstants.buttonRadius),
        borderSide: BorderSide(
          color: appConstants.primary1Color,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appConstants.buttonRadius),
        borderSide: BorderSide(
          color: appConstants.requiredColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(appConstants.buttonRadius),
        borderSide: BorderSide(
          color: appConstants.primary1Color,
        ),
      ),
    ),
  );
}

Future<void> uploadProfilePicture({
  required BuildContext context,
  required EditProfileCubit editProfileCubit,
  required EditProfileLoadedState state,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    var sourceType = await showDialog(
      context: context,
      barrierColor: appConstants.default2Color,
      builder: ((context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
          actionsPadding: EdgeInsets.symmetric(vertical: 15.h),
          backgroundColor: appConstants.whiteBackgroundColor,
          surfaceTintColor: appConstants.whiteBackgroundColor,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget.sizedBox(width: 30),
                Center(
                  child: CommonWidget.commonText(
                    text: TranslationConstants.choose_option.translate(context),
                    style: Theme.of(context)
                        .textTheme
                        .subTitle2BoldHeading
                        .copyWith(color: appConstants.default1Color, height: 1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            Center(
              child: CommonWidget.commonText(
                text: TranslationConstants.upload_profile_photo.translate(context),
                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default3Color),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      CommonRouter.pop(args: "camera");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(18.r),
                          decoration: BoxDecoration(
                            color: appConstants.default10Color,
                            borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                          ),
                          alignment: Alignment.center,
                          child: CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/common/camera_icon.svg",
                            height: 25.h,
                          ),
                        ),
                        CommonWidget.sizedBox(height: 10),
                        CommonWidget.commonText(
                          text: TranslationConstants.camera.translate(context),
                          style: Theme.of(context)
                              .textTheme
                              .captionMediumHeading
                              .copyWith(color: appConstants.default1Color),
                        ),
                      ],
                    ),
                  ),
                  CommonWidget.sizedBox(
                    height: 80,
                    child: VerticalDivider(
                      endIndent: 2,
                      color: appConstants.default11Color,
                      thickness: 2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(args: "gallery"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(18.r),
                          decoration: BoxDecoration(
                            color: appConstants.greyBackgroundColor,
                            borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                          ),
                          alignment: Alignment.center,
                          child: CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/common/gallery_icon.svg",
                            height: 25.h,
                          ),
                        ),
                        CommonWidget.sizedBox(height: 10),
                        CommonWidget.commonText(
                          text: TranslationConstants.gallery.translate(context),
                          style: Theme.of(context)
                              .textTheme
                              .captionMediumHeading
                              .copyWith(color: appConstants.default1Color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
    XFile? file;
    if (sourceType == 'gallery') {
      file = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);
      if (file != null) {
        editProfileCubit.imagePath = File(file.path);
        editProfileCubit.pickImage(editProfileCubit.imagePath);
      } else {
        // User canceled the picker
      }
    } else if (sourceType == 'camera') {
      file = await picker.pickImage(source: ImageSource.camera);
      editProfileCubit.imagePath = File(file!.path);
      editProfileCubit.pickImage(editProfileCubit.imagePath);
    }

    if (file != null) {
      var croppedImage = await (Navigator.pushNamed(
        context,
        RouteList.image_crop_screen,
        arguments: ImageCropArgs(imagePathOrURL: editProfileCubit.imagePath!.path, aspectRatio: 1 / 1),
      )) as Uint8List?;
      if (croppedImage != null) {
        final tempDir = await getTemporaryDirectory();
        File file = await File(
                '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_${editProfileCubit.imagePath!.path.toString().split('/').last}')
            .create();
        await file.writeAsBytes(croppedImage);
        editProfileCubit.imagePath = File(file.path);
        editProfileCubit.uploadProfilePhoto(context: context, state: state);
        editProfileCubit.pickImage(editProfileCubit.imagePath);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
