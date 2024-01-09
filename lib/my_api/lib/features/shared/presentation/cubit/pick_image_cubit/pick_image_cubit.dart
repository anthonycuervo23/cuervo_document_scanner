import 'dart:io';
import 'dart:math';
import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/domain/args/image_crop_args.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class PickImageCubit extends Cubit<double> {
  PickImageCubit() : super(Random().nextDouble());
  ImagePicker imagePicker = ImagePicker();
  List<ImageListModel> imageList = [];
  List<ImageListModel> tempCatalogueList = [];

  Future<void> pickImage({required String pickType}) async {
    if (pickType == "gallery") {
      XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
      List<ImageListModel> listOfImage = [
        ImageListModel(
          name: xFile?.name ?? "",
          path: xFile?.path ?? "",
          bytes: await xFile!.readAsBytes(),
        )
      ];
      var file = File(listOfImage[0].path);
      final bytes = file.readAsBytesSync().lengthInBytes;
      double kb = bytes / 1024;
      double mb = kb / 1024;
      if (mb < 5.00) {
        imageList = listOfImage;
        emit(Random().nextDouble());
      }
    } else {
      XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
      List<ImageListModel> listOfImage = [
        ImageListModel(
          name: xFile?.name ?? "",
          path: xFile?.path ?? "",
          bytes: await xFile!.readAsBytes(),
        )
      ];
      var file = File(listOfImage[0].path);
      final bytes = file.readAsBytesSync().lengthInBytes;
      double kb = bytes / 1024;
      double mb = kb / 1024;
      if (mb < 5.00) {
        imageList = listOfImage;
        emit(Random().nextDouble());
      }
    }
  }

  Future<void> pickMultiImage({required String pickType}) async {
    if (pickType == "gallery") {
      List<XFile> list = await imagePicker.pickMultiImage();
      for (var e in list) {
        Future<Uint8List> bytes = e.readAsBytes();
        imageList.add(ImageListModel(name: e.path, path: e.path, bytes: await bytes));
      }
      emit(Random().nextDouble());
    } else {
      List<XFile> list = await imagePicker.pickMultipleMedia();
      for (var e in list) {
        Future<Uint8List> bytes = e.readAsBytes();
        imageList.add(ImageListModel(name: e.path, path: e.path, bytes: await bytes));
      }
      emit(Random().nextDouble());
    }
  }

  void removeData({required int index}) {
    imageList.removeAt(index);
    emit(Random().nextDouble());
  }

  void cropedImage({required int index, required Uint8List bytes}) {
    ImageListModel imageListModel = ImageListModel(
      name: imageList[index].name,
      path: imageList[index].path,
      bytes: bytes,
    );

    imageList[index] = imageListModel;
    emit(Random().nextDouble());
  }

  void tempCatalogueImageCrop({required int index, required Uint8List bytes, required String imagePathOrURL}) async {
    ImageCropArgs cropArgs = ImageCropArgs(
      imagePathOrURL: tempCatalogueList[index].path,
      aspectRatio: 0,
    );
    Uint8List bytes = await CommonRouter.pushNamed(RouteList.image_crop_screen, arguments: cropArgs) as Uint8List;
    tempCatalogueList[index].path = imagePathOrURL;
    tempCatalogueList[index].bytes = bytes;
    emit(Random().nextDouble());
  }

  void tempRemoveCatalogueImage({required int index}) {
    tempCatalogueList.removeAt(index);
    emit(Random().nextDouble());
  }

  void saveTempData() {
    imageList = tempCatalogueList;
    CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: "Images saved successfully!");
    emit(Random().nextDouble());
  }

  void cancelTempData() {
    tempCatalogueList.clear();
  }
}

class ImageListModel {
  final String name;
  String path;
  Uint8List bytes;

  ImageListModel({required this.name, required this.path, required this.bytes});
}
