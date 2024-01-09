import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();

    connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                sendTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                method: requestOptions.method,
                headers: requestOptions.headers,
                extra: requestOptions.extra,
                contentType: requestOptions.contentType,
                validateStatus: requestOptions.validateStatus,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
