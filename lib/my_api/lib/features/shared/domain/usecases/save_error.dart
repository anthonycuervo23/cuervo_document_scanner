import 'dart:io';

import 'package:bakery_shop_admin_flutter/core/api_client.dart';
import 'package:bakery_shop_admin_flutter/core/api_constants.dart';
import 'package:bakery_shop_admin_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/params/save_error_params.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:dartz/dartz.dart';

Future<Either<AppError, bool>> saveError({
  required ErrorParams params,
  required ApiClient client,
}) async {
  try {
    int userId = userLoginData?.id ?? 0;
    late int mobileNo;
    try {
      mobileNo = initialLoginMobileNo ?? int.parse(userLoginData?.mobileNo ?? '0');
    } on Exception {
      mobileNo = 0;
    }

    final Map<String, dynamic> errorData = {};
    final Map<String, dynamic> device = {"deviceData": deviceData};
    final Map<String, dynamic> urlWithParams = {"urlWithParams": params.url.toString()};
    final Map<String, dynamic> token = {"token": 'Bearer ${AppFunctions().getUserToken() ?? ''}'};
    final Map<String, dynamic> error = {"errorMessage": params.errMsg.toString()};
    errorData.addAll(token);
    errorData.addAll(urlWithParams);
    errorData.addAll(device);
    errorData.addAll(error);
    errorData.addAll({"dateAndTime": DateTime.now()});
    var reqParams = {
      "user_id": userId,
      'mobile_no': mobileNo,
      "error_log": errorData.toString(),
      "error_type": params.errType == ErrorLogType.api ? "api" : "app",
    };

    final response = await client.post('/error-log/save', params: reqParams, header: ApiConstatnts().headers);

    if (response["status"] == 200 && response["success"] == true) {
      commonPrint("Error Log Successfully$error");
      isConnectionSuccessful = true;
      return const Right(true);
    } else {
      isConnectionSuccessful = true;
      return const Right(false);
    }
  } on UnauthorisedException catch (_) {
    return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "Un-Authorised"));
  } on SocketException catch (e) {
    if (e.toString().contains('ClientException with SocketException')) {
      return const Left(
        AppError(
          errorType: AppErrorType.network,
          errorMessage: "Please check your internet connection, try again!!!\n(Error:102)",
        ),
      );
    } else if (e.toString().contains('ClientException') && e.toString().contains('Software')) {
      return const Left(
        AppError(
          errorType: AppErrorType.network,
          errorMessage: "Network Change Detected, Please try again!!!\n(Error:103)",
        ),
      );
    }
    return const Left(
      AppError(
        errorType: AppErrorType.network,
        errorMessage: "Something went wrong, try again!\nSocket Problem (Error:104)",
      ),
    );
  } catch (exception) {
    isConnectionSuccessful = true;
    return const Right(false);
  }
}
