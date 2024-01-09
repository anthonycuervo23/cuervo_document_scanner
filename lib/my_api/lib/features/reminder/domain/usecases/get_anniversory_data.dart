import 'package:bakery_shop_admin_flutter/features/reminder/data/data_source/reminder_remote_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/perams/reminder_perams.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAnniversoryData extends UseCase<AnniversoryReminderEntities, ReminderParams> {
  final ReminderRemoteDataSource reminderRemoteDataSource;

  GetAnniversoryData({required this.reminderRemoteDataSource});

  @override
  Future<Either<AppError, AnniversoryReminderEntities>> call(ReminderParams params) async {
    return await reminderRemoteDataSource.getAniversaryData(params: params);
  }
}
