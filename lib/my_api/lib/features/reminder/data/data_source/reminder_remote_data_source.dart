import 'package:bakery_shop_admin_flutter/core/api_client.dart';
import 'package:bakery_shop_admin_flutter/core/api_constants.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/anniversory_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/birthday_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/events_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/birhday_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/events_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/perams/reminder_perams.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/common_api_call.dart';
import 'package:dartz/dartz.dart';

abstract class ReminderRemoteDataSource {
  Future<Either<AppError, BirthdayReminderEntities>> getBirthDayData({required ReminderParams params});
  Future<Either<AppError, AnniversoryReminderEntities>> getAniversaryData({required ReminderParams params});
  Future<Either<AppError, EventsReminderEntities>> getEventsData({required ReminderParams params});
}

class ReminderRemoteDataSourceimpl extends ReminderRemoteDataSource {
  final ApiClient client;

  ReminderRemoteDataSourceimpl({required this.client});
  @override
  Future<Either<AppError, BirthdayReminderEntities>> getBirthDayData({required ReminderParams params}) async {
    Map<String, dynamic> queryParams = {
      "page": params.page,
      "name": params.name ?? '',
      "birth_date": params.birthDate ?? '',
      "mobile": params.mobile ?? '',
      "email": params.email ?? '',
    };
    final result = await commonApiApiCall<BithdayReminderModel>(
      apiPath: 'reminder/birthday',
      params: queryParams,
      apiCallType: APICallType.GET,
      screenName: 'reminder_screen',
      header: ApiConstatnts().headers,
      client: client,
      fromJson: (json) {
        final data = BithdayReminderModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data));
  }

  @override
  Future<Either<AppError, AnniversoryReminderEntities>> getAniversaryData({required ReminderParams params}) async {
    Map<String, dynamic> queryParams = {
      "page": params.page,
      "name": params.name ?? '',
      "anniversary_date": params.anniversaryDate ?? '',
      "mobile": params.mobile ?? '',
      "email": params.email ?? '',
    };

    final result = await commonApiApiCall<AnniversoryReminderModel>(
      apiPath: 'reminder/anniversary',
      params: queryParams,
      apiCallType: APICallType.GET,
      screenName: 'reminder_screen',
      header: ApiConstatnts().headers,
      client: client,
      fromJson: (json) {
        final data = AnniversoryReminderModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data));
  }

  @override
  Future<Either<AppError, EventsReminderEntities>> getEventsData({required ReminderParams params}) async {
    Map<String, dynamic> queryParams = {
      "page": params.page,
      "name": params.name ?? '',
      "event_date": params.eventDate ?? '',
    };

    final result = await commonApiApiCall<EventsReminderModel>(
      apiPath: 'reminder/event',
      params: queryParams,
      apiCallType: APICallType.GET,
      screenName: 'reminder_screen',
      header: ApiConstatnts().headers,
      client: client,
      fromJson: (json) {
        final data = EventsReminderModel.fromJson(json);
        return data;
      },
    );

    return result.fold((appError) => Left(appError), (list) => Right(list.data));
  }
}
