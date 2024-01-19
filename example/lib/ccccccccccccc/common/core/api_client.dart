// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:captain_score/core/api_constants.dart';
import 'package:captain_score/core/unathorised_exception.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params, Map<String, String>? header}) async {
    final response = await _client.get(
      getPath(path, params),
      headers: header ?? ApiConstatnts().headers,
    );
    if (kDebugMode) {
      print("Get call: ${getPath(path, params)}");
      // print("Get call: ${json.decode(response.body)['status'] == 401}");
    }

    if (response.statusCode == 200) {
      try {
        if (json.decode(response.body)['status'] == 401) {
          throw UnauthorisedException();
        }
      } on UnauthorisedException {
        throw UnauthorisedException();
      }

      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic directGet({required String url, Map<dynamic, dynamic>? params, Map<String, String>? header}) async {
    final response = await _client.get(
      getDirectPath(url: url, params: params),
      headers: header ?? ApiConstatnts().headers,
    );
    if (kDebugMode) {
      print("Get call: ${getDirectPath(url: url, params: params)}");
      // print("Get call: " + AppFunctions().getUserToken().toString());
    }

    if (response.statusCode == 200) {
      try {
        if (json.decode(response.body)['status'] == 401) {
          throw UnauthorisedException();
        }
      } on UnauthorisedException {
        throw UnauthorisedException();
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {Map<dynamic, dynamic>? params, Map<String, String>? header}) async {
    final response = await _client.post(
      getPath(path, null),
      body: jsonEncode(params),
      headers: path == '/login'
          ? {'Content-Type': 'application/json', "Accept": 'application/json'}
          : ApiConstatnts().headers,
    );
    if (kDebugMode) {
      print("Post call: ${getPath(path, null)}");
      print("Post call: ${jsonEncode(params)}");
    }
    if (response.statusCode == 200) {
      try {
        if (json.decode(response.body)['status'] == 401) {
          throw UnauthorisedException();
        }
      } on UnauthorisedException {
        throw UnauthorisedException();
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic directPost({required String url, required Map<dynamic, dynamic> params, Map<String, String>? header}) async {
    final response = await _client.post(
      Uri.parse(url),
      body: jsonEncode(params),
      headers: header ?? {'Content-Type': 'application/json', "Accept": 'application/json'},
    );
    if (kDebugMode) {
      print("Direct Post call: $url");
      // print("Direct Post call: ${jsonEncode(params)}");
    }
    if (response.statusCode == 200) {
      try {
        if (json.decode(response.body)['status'] == 401) {
          throw UnauthorisedException();
        }
      } on UnauthorisedException {
        throw UnauthorisedException();
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic postFiles(
    String path, {
    required Map<String, dynamic> params,
    Map<String, String>? header,
    List<MapEntry<String, MultipartFile>>? multipleImages,
  }) async {
    try {
      var formData = FormData.fromMap(params);
      formData.files.clear();
      if (multipleImages != null && multipleImages.isNotEmpty) {
        formData.files.addAll(multipleImages);
      }
      var response = await Dio()
          .post(
            getStringPath(path),
            data: formData,
            options: Options(
              headers: path == '/login'
                  ? {'Content-Type': 'application/json', "Accept": 'application/json'}
                  : ApiConstatnts().headers,
            ),
          )
          .timeout(
            const Duration(seconds: 300),
            onTimeout: () => throw Exception("Time out on saving details, Please try again!"),
          );

      if (kDebugMode) {
        print("Direct Post call: ${getStringPath(path)}");
        // NoSuchMethodError (NoSuchMethodError: Class 'MultipartFile' has no instance method 'toJson'. for bellow line
        // print("Direct Post call: ${jsonEncode(params)}");
        print("Direct Post call: $params");
      }
      if (response.statusCode == 200) {
        try {
          if (json.decode(response.toString())['status'] == 401) {
            throw UnauthorisedException();
          }
        } on UnauthorisedException {
          throw UnauthorisedException();
        }
        return json.decode(response.toString());
      } else if (response.statusCode == 401) {
        throw UnauthorisedException();
      } else {
        throw Exception(response.statusMessage);
      }
    } on Exception catch (e, stackTrace) {
      Catcher2.reportCheckedError(e, stackTrace);
      throw Exception(e);
    }
  }

  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params, Map<String, String>? header}) async {
    http.Request request = http.Request('DELETE', getPath(path, null));
    request.headers['X-localization'] = ApiConstatnts.xLocalization;
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    request.body = jsonEncode(params);
    final response = await _client.send(request).then(
          (value) => http.Response.fromStream(value),
        );

    if (response.statusCode == 200) {
      try {
        if (json.decode(response.body)['status'] == 401) {
          throw UnauthorisedException();
        }
      } on UnauthorisedException {
        throw UnauthorisedException();
      }
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPathWithParams(String path, {Map<dynamic, dynamic>? params}) {
    var paramsString = ((params?.isNotEmpty ?? false) && !path.contains("?")) ? '?' : '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        if (paramsString.contains("=")) {
          paramsString += '&$key=$value';
        } else {
          paramsString += '$key=$value';
        }
      });
    }

    if (kReleaseMode) {
      return '${ApiConstatnts.liveBaseUrl}$path$paramsString';
    }
    return '${ApiConstatnts.baseUrl}$path$paramsString';
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = ((params?.isNotEmpty ?? false) && !path.contains("?")) ? '?' : '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        if (paramsString.contains("=")) {
          paramsString += '&$key=$value';
        } else {
          paramsString += '$key=$value';
        }
      });
    }

    if (kReleaseMode) {
      return Uri.parse('${ApiConstatnts.liveBaseUrl}$path$paramsString');
    }
    return Uri.parse('${ApiConstatnts.baseUrl}$path$paramsString');
  }

  Uri getDirectPath({required String url, Map<dynamic, dynamic>? params}) {
    var paramsString = '?';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        if (paramsString.contains("=")) {
          paramsString += '&$key=$value';
        } else {
          paramsString += '$key=$value';
        }
      });
    }

    if (kReleaseMode) {
      return Uri.parse('$url$paramsString');
    }
    return Uri.parse('$url$paramsString');
  }

  String getStringPath(String path) {
    if (kReleaseMode) {
      return '${ApiConstatnts.liveBaseUrl}$path';
    }
    return '${ApiConstatnts.baseUrl}$path';
  }
}
