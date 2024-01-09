// ignore_for_file: constant_identifier_names, unused_local_variable, unused_catch_stack

import 'dart:developer';
import 'dart:io';
import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/core/api_constants.dart';
import 'package:bakery_shop_flutter/core/unathorised_exception.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

enum APICallType { GET, POST, DIRECTGET, DIRECTPOST, POSTFILES, DELETE }

Future<Either<AppError, T>> commonApiApiCall<T extends ModelResponseExtend>({
  required T Function(Map<String, dynamic> json) fromJson,
  required ApiClient client,
  required String apiPath,
  Map<String, dynamic>? params,
  Map<String, String>? header,
  required APICallType apiCallType,
  List<MapEntry<String, dio.MultipartFile>>? multipleImages,
  required String screenName,
}) async {
  String paramsUrl;

  try {
    paramsUrl = client.getPathWithParams(apiPath, params: params ?? {});

    final data = apiCallType == APICallType.GET
        ? (await client.get(apiPath, params: params, header: header))
        : apiCallType == APICallType.POST
            ? (await client.post(apiPath, params: params, header: header))
            : apiCallType == APICallType.DIRECTGET
                ? (await client.directGet(url: apiPath, params: params ?? {}, header: header))
                : apiCallType == APICallType.DIRECTPOST
                    ? (await client.directPost(
                        url: apiPath,
                        params: params ?? {},
                        header: header ?? ApiConstatnts().headers,
                      ))
                    : apiCallType == APICallType.DELETE
                        ? (await client.deleteWithBody(
                            apiPath,
                            params: params ?? {},
                            header: header ?? ApiConstatnts().headers,
                          ))
                        : (await client.postFiles(
                            apiPath,
                            params: params ?? {},
                            header: header ?? ApiConstatnts().headers,
                            multipleImages: multipleImages,
                          ));

    final parseData = fromJson(data);

    if (parseData.status && parseData.data != null) {
      isConnectionSuccessful = true;
      if (parseData.data == null) {
        return Left(
          AppError(
            errorType: AppErrorType.data,
            errorMessage: '${parseData.message} (Error:100 & ${parseData.status.toString()})',
          ),
        );
      }
      return Right(parseData);
      // } else if (parseData.statusCode == 404) {
      //   return Left(
      //     AppError(
      //       errorType: AppErrorType.data,
      //       errorMessage: '${parseData.message} (Error:100 & ${parseData.statusCode.toString()})',
      //     ),
      //   );
      // } else if (parseData.statusCode == 406 || parseData.statusCode == 405) {
      //   saveError(
      //     client: client,
      //     params: ErrorParams(
      //       errType: ErrorLogType.api,
      //       url: paramsUrl,
      //       errMsg: '${parseData.message} (Error:100 & ${parseData.statusCode.toString()})',
      //     ),
      //   );
      //   return Left(
      //     AppError(
      //       errorType: AppErrorType.api,
      //       errorMessage: '${parseData.message} (Error:100 & ${parseData.statusCode.toString()})',
      //     ),
      //   );
    } else {
      // saveError(
      //   params: ErrorParams(
      //     errType: ErrorLogType.api,
      //     issueType: IssueLogType.api,
      //     url: paramsUrl,
      //     errMsg: parseData.message.toString(),
      //     screenName: screenName,
      //   ),
      // );
      return Left(
        AppError(
          errorType: AppErrorType.api,
          errorMessage: parseData.message,
        ),
      );
    }
  } on UnauthorisedException catch (_) {
    return const Left(AppError(errorType: AppErrorType.unauthorised, errorMessage: "Un-Authorised"));
  } on SocketException catch (e, stackTrace) {
    // saveError(
    //   params: ErrorParams(
    //     errType: ErrorLogType.socket,
    //     issueType: IssueLogType.network,
    //     url: paramsUrl,
    //     errMsg: "$e\n\n$stackTrace",
    //     screenName: screenName,
    //   ),
    // );
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
    // } catch (exception, stackTrace) {
    //   log('======>> $exception');
    //   log('<<==== $stackTrace');
    //   Catcher2.reportCheckedError(exception, stackTrace);
    //   // saveError(
    //   //   params: ErrorParams(
    //   //     errType: ErrorLogType.app,
    //   //     issueType: IssueLogType.generalException,
    //   //     url: paramsUrl,
    //   //     errMsg: "$exception\n$stackTrace",
    //   //     screenName: screenName,
    //   //   ),
    //   // );
    //   return const Left(
    //     AppError(errorType: AppErrorType.app, errorMessage: "Something went wrong, try again!\n(Error:105)"),
    //   );
    // }
  } catch (e) {
    log(e.toString());
    return const Left(
      AppError(errorType: AppErrorType.app, errorMessage: "Something went wrong, try again!\n(Error:105)"),
    );
  }
}
