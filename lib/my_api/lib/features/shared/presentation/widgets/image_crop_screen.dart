import 'dart:io';
import 'package:bakery_shop_admin_flutter/features/product_list/domain/args/image_crop_args.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;

class ImageCropScreen extends StatefulWidget {
  final ImageCropArgs cropArgs;

  const ImageCropScreen({Key? key, required this.cropArgs}) : super(key: key);

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  String imageURL = '';
  double? aspectRatio = 1;

  late ImageProvider provider;

  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();
  late BuildContext currentContext;

  String imageExtention = '.jpeg';

  @override
  void initState() {
    imageURL = widget.cropArgs.imagePathOrURL;
    aspectRatio = widget.cropArgs.aspectRatio;
    currentContext = context;
    if (imageURL.startsWith('http')) {
      provider = ExtendedNetworkImageProvider(widget.cropArgs.imagePathOrURL, cacheRawData: true);
    } else {
      provider = ExtendedFileImageProvider(File(widget.cropArgs.imagePathOrURL), cacheRawData: true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Crop Image"),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: buildImage(),
        bottomNavigationBar: _buildButtons());
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              aspectRatio = null;
              editorKey.currentState?.reset();
            },
            child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/image_croper_screen/refresh.svg", height: 22.r, width: 22.r),
          ),
          InkWell(
            onTap: () => rotate(false),
            child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/image_croper_screen/rotate.svg", height: 22.r, width: 22.r),
          ),
          InkWell(
            onTap: () => flip(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/image_croper_screen/flipicon.svg", height: 22.r, width: 22.r)),
          ),
          InkWell(
            onTap: () => crop(true),
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: appConstants.themeColor,
              ),
              child: Center(
                child: Text(
                  "Crop",
                  style: TextStyle(color: appConstants.white, height: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
          Color(0xffEDF6FF),
          Color(0xffDDEEFF),
        ]),
      ),
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
          cropRectPadding: EdgeInsets.zero,
          hitTestSize: 20.0,
          cropAspectRatio: aspectRatio,
          cornerColor: appConstants.themeColor,
          lineColor: appConstants.white,
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
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error while getting raw image data: $e');
      }
    }

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
    final Uint8List? result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    if (result == null) return;

    navigate(result: result);
  }

  void navigate({required Uint8List result}) {
    Navigator.of(currentContext).pop(result);
  }

  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(right: right);
  }
}
