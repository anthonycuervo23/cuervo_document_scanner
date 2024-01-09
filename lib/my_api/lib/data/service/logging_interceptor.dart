import 'dart:async';
import 'dart:convert';
import 'package:bakery_shop_admin_flutter/utils/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('');
    log('\x1B[37m╔╣ Request ║ ${options.method}\x1B[0m');
    log('\x1B[37m║ *** API Request - Start ***\x1B[0m');
    log('\x1B[37m╚══════════════════════════════════════════════════════════╝');

    printKV('URI', options.uri, color: '\x1B[37m');
    printKV('METHOD', options.method, color: '\x1B[37m');
    printKV('HEADERS', '', color: '\x1B[37m');
    options.headers.forEach((key, v) => printKV(' - $key', v));
    printKV('BODY', '', color: '\x1B[37m');
    printAll(options.data ?? "");

    log('\x1B[37m╔╣\x1B[0m');
    log('\x1B[37m║ *** API Request - End ***\x1B[0m');
    log('\x1B[37m╚══════════════════════════════════════════════════════════╝');

    String? accessToken = SharedPref.instance.shared.getString('token');
    if (accessToken == null) {
      log('trying to send request without token exist!');
      return super.onRequest(options, handler);
    }
    options.headers["Authorization"] = "Bearer $accessToken";
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('');
    log('\x1B[31m╔╣  Request ║ STATUS CODE: ${err.response?.statusCode?.toString()}\x1B[0m');
    log('\x1B[31m║ *** Api Error - Start ***:\x1B[0m');
    log('\x1B[31m╚══════════════════════════════════════════════════════════╝');

    log('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      log('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    log('$err');
    if (err.response != null) {
      printKV('REDIRECT', err.response?.realUri ?? '', color: '\x1B[31m');
      printKV('BODY', err.response?.realUri ?? '', color: '\x1B[31m');
      printAll(err.response?.toString());
      if (err.response != null) {
        var errMsg = jsonDecode(err.response.toString());
        log('Error Message: ${errMsg['message']}');
      }
    }

    log('\x1B[31m╔╣\x1B[0m');
    log('\x1B[31m║ *** Api Error - End ***:\x1B[0m');
    log('\x1B[31m╚══════════════════════════════════════════════════════════╝');

    super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('');
    log('\x1B[32m╔╣ Response ║ STATUS CODE ${response.statusCode ?? 0000}\x1B[0m');
    log('\x1B[32m║ *** Api Response - Start ***\x1B[0m');
    log('\x1B[32m╚══════════════════════════════════════════════════════════╝');

    printKV('URI', response.requestOptions.uri, color: '\x1B[32m');
    printKV('STATUS CODE', response.statusCode ?? 0000, color: '\x1B[32m');
    printKV('REDIRECT', response.isRedirect, color: '\x1B[32m');
    printKV('BODY', '', color: '\x1B[32m');
    printAll(response.data ?? "");

    log('\x1B[32m╔╣\x1B[0m');
    log('\x1B[32m║ *** Api Response - End ***\x1B[0m');
    log('\x1B[32m╚══════════════════════════════════════════════════════════╝');

    super.onResponse(response, handler);
  }

  void printKV(String key, Object v, {String? color}) {
    log('$color$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(log);
  }

  void log(String s) {
    debugPrint(s);
  }
}
