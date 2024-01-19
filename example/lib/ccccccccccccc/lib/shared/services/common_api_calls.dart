import 'dart:io';

import 'package:captain_score/common/core/api_client.dart';
import 'package:captain_score/core/api_constants.dart';
import 'package:captain_score/core/unathorised_exception.dart';
import 'package:captain_score/shared/models/model_reponse_extend.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:catcher_2/core/catcher_2.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

mixin CommonApiCalls {
  Future<Either<AppError, T>> commonApiApiCall<T extends ModelResponseExtend>({
    required T Function(Map<String, dynamic> json) fromJson,
    String? paramsUrlDirect,
    required ApiClient client,
    required String apiPath,
    Map<String, dynamic>? params,
    Map<String, String>? header,
    required APICallType apiCallType,
    List<MapEntry<String, dio.MultipartFile>>? multipleImages,
    required String screenName,
  }) async {
    // String paramsUrl = paramsUrlDirect ?? '';

    try {
      // paramsUrl = client.getPathWithParams(apiPath, params: params ?? {});

      final data = apiCallType == APICallType.GET
          ? (await client.get(apiPath, params: params ?? {}, header: header ?? ApiConstatnts().headers))
          : apiCallType == APICallType.POST
              ? (await client.post(apiPath, params: params ?? {}, header: header ?? ApiConstatnts().headers))
              : apiCallType == APICallType.DIRECTGET
                  ? (await client.directGet(
                      url: apiPath,
                      params: params ?? {},
                      header: header ?? ApiConstatnts().headers,
                    ))
                  : apiCallType == APICallType.DIRECTPOST
                      ? (await client.directPost(
                          url: apiPath,
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

      commonPrint("Status Code : ${parseData.status}");
      commonPrint("Status Code Message : ${parseData.message}");

      if (parseData.status == 200 && parseData.success == true) {
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
      } else if (parseData.status == 404) {
        return Left(
          AppError(
            errorType: AppErrorType.data,
            errorMessage: '${parseData.message} (Error:100 & ${parseData.status.toString()})',
          ),
        );
      } else if (parseData.status == 406 || parseData.status == 405) {
        return Left(
          AppError(
            errorType: AppErrorType.api,
            errorMessage: '${parseData.message} (Error:100 & ${parseData.status.toString()})',
          ),
        );
      } else {
        return Left(
          AppError(
            errorType: AppErrorType.api,
            errorMessage: "Something went wrong, try again!\n(Error:100 & ${parseData.status.toString()})",
          ),
        );
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
    } catch (exception, stackTrace) {
      Catcher2.reportCheckedError(exception, stackTrace);

      return const Left(
        AppError(errorType: AppErrorType.app, errorMessage: "Something went wrong, try again!\n(Error:105)"),
      );
    }
  }
}
