import 'dart:convert';
import 'dart:io';
import 'package:bakery_shop_admin_flutter/common/constants/app_config.dart';
import 'package:bakery_shop_admin_flutter/data/remote/fetch_data_exception.dart';
import 'package:dio/dio.dart';

class NetworkApiService {
  static const String baseUrl = AppConfig.baseUrl;

  static final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.plain,
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  );
  static final Dio client = Dio(_options);

//============================= GET =============================
  Future get(String url) async {
    dynamic responseJson;
    try {
      final response = await client.get(baseUrl + url);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

//============================= POST =============================
  Future post(String url, Map<String, String> jsonBody) async {
    dynamic responseJson;
    try {
      final response = await client.post(baseUrl + url, data: jsonBody);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 404:
        throw UnauthorisedException(response.data.toString());
      case 506:
      default:
        throw FetchDataException(
            'Error occured while communication with server' ' with status code : ${response.statusCode}');
    }
  }
}
