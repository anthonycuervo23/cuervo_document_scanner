import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/birhday_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/events_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/perams/reminder_perams.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class ReminderRepositories {
  Future<Either<AppError, BirthdayReminderEntities>> getBirthdayData({required ReminderParams params});
  Future<Either<AppError, AnniversoryReminderEntities>> getAnnivesoryData({required ReminderParams params});
  Future<Either<AppError, EventsReminderEntities>> getEventData({required ReminderParams params});
}
