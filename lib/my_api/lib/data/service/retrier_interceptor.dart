import 'dart:io';
import 'package:bakery_shop_admin_flutter/data/service/dio_connectivity_retrier.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout && err.error != null && err.error is SocketException;
  }
}
