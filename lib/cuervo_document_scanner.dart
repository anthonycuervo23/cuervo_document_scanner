import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

enum Source { CAMERA, GALLERY }

class CuervoDocumentScanner {
  static const MethodChannel _channel =
      MethodChannel('cuervo_document_scanner');

  /// Call this to start get Picture workflow.
  static Future<List<String>?> getPictures(Source source) async {
    if (source == Source.CAMERA) {
      return _getPicturesFromCamera();
    } else {
      return _getPicturesFromGallery();
    }
  }

  static Future<List<String>?> _getPicturesFromCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    if (statuses.containsValue(PermissionStatus.denied)) {
      throw Exception("Permission not granted");
    }

    final List<dynamic>? pictures =
        await _channel.invokeMethod('getPictures', "camera");
    return pictures?.map((e) => e as String).toList();
  }

  static Future<List<String>?> _getPicturesFromGallery() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses.containsValue(PermissionStatus.denied)) {
      throw Exception("Permission not granted");
    }

    final List<dynamic>? pictures =
        await _channel.invokeMethod('getPictures', "gallery");
    return pictures?.map((e) => e as String).toList();
  }
}
