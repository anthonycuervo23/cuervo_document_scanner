import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/birhday_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/events_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/perams/reminder_perams.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/repositories/reminder_repositories.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';

class ReminderRepositoriesImpl extends ReminderRepositories {
  final ReminderRepositories reminderRepositories;

  ReminderRepositoriesImpl({required this.reminderRepositories});

  @override
  Future<Either<AppError, BirthdayReminderEntities>> getBirthdayData({required ReminderParams params}) async {
    try {
      final result = await reminderRepositories.getBirthdayData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, AnniversoryReminderEntities>> getAnnivesoryData({required ReminderParams params}) async {
    try {
      final result = await reminderRepositories.getAnnivesoryData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }

  @override
  Future<Either<AppError, EventsReminderEntities>> getEventData({required ReminderParams params}) async {
    try {
      final result = await reminderRepositories.getEventData(params: params);
      return result;
    } on Exception {
      throw Exception('Something goes wrong.');
    }
  }
}
