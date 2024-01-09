import 'dart:io';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/image_crop/crop_image_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;

abstract class CropImageWidget extends State<CropImageScreen> with WidgetsBindingObserver {
  String imageURL = '';
  double? aspectRatio = 1;
  late ImageProvider provider;

  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();

  String imageExtention = '.jpeg';

  @override
  void initState() {
    imageURL = widget.cropArgs.imagePathOrURL;
    aspectRatio = widget.cropArgs.aspectRatio;

    if (imageURL.startsWith('http')) {
      provider = ExtendedNetworkImageProvider(widget.cropArgs.imagePathOrURL, cacheRawData: true);
    } else {
      provider = ExtendedFileImageProvider(File(widget.cropArgs.imagePathOrURL), cacheRawData: true);
    }
    super.initState();
  }

  Widget buildButtons() {
    return Container(
      color: appConstants.whiteBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                aspectRatio = null;
                editorKey.currentState?.reset();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/image_croper_screen/refresh.svg",
                  height: 22.r,
                  width: 22.r,
                ),
              ),
            ),
            InkWell(
              onTap: () => rotate(false),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/image_croper_screen/rotate.svg",
                  height: 22.r,
                  width: 22.r,
                ),
              ),
            ),
            InkWell(
              onTap: () => flip(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/image_croper_screen/flipicon.svg",
                  height: 22.r,
                  width: 22.r,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                crop(true);
                // editProfileCubit.uploadProfilePhoto();
              },
              child: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: appConstants.primary1Color,
                ),
                alignment: Alignment.center,
                child: Text(
                  TranslationConstants.crop.translate(context),
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                        color: appConstants.buttonTextColor,
                        height: 1,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      color: appConstants.whiteBackgroundColor,
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      child: ExtendedImage(
        image: provider,
        extendedImageEditorKey: editorKey,
        mode: ExtendedImageMode.editor,
        fit: BoxFit.contain,
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        initEditorConfigHandler: (_) => EditorConfig(
          maxScale: 8,
          cropRectPadding: EdgeInsets.all(10.r),
          hitTestSize: 20,
          cropAspectRatio: aspectRatio,
          cornerColor: appConstants.primary1Color,
          lineColor: appConstants.primary1Color,
        ),
        clearMemoryCacheWhenDispose: true,
      ),
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState? state = editorKey.currentState;
    if (state == null) {
      return;
    }
    final Rect? rect = state.getCropRect();
    if (rect == null) {
      return;
    }
    final EditActionDetails action = state.editAction!;
    final double radian = action.rotateAngle;
    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    Uint8List? img;
    try {
      img = state.rawImageData;
      // ignore: empty_catches
    } on Exception {}

    if (img == null) {
      return;
    }

    final ImageEditorOption option = ImageEditorOption();
    option.addOption(ClipOption.fromRect(rect));
    option.addOption(FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian.toInt()));
    }

    option.outputFormat = imageURL.endsWith('.png') ? const OutputFormat.png(80) : const OutputFormat.jpeg(80);
    //// print(const JsonEncoder.withIndent('  ').convert(option.toJson()));
    // final DateTime start = DateTime.now();
    final Uint8List? result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    //// print('result.length = ${result?.length}');
    // final Duration diff = DateTime.now().difference(start);
    //// print('image_editor time : $diff');
    // showToast('handle duration: $diff', duration: const Duration(seconds: 5), dismissOtherToast: true);
    if (result == null) return;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(result);
  }

  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(right: right);
  }
}
