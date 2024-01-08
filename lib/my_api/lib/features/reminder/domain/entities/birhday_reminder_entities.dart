import 'package:bakery_shop_admin_flutter/features/reminder/data/models/birthday_reminder_model.dart';
import 'package:equatable/equatable.dart';

class BirthdayReminderEntities extends Equatable {
  final int from;
  final int to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;
  final List<BirthdayReminderDataModel> items;

  const BirthdayReminderEntities({
    required this.from,
    required this.to,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
    required this.items,
  });

  @override
  List<Object?> get props => [
        from,
        to,
        currentPage,
        lastPage,
        perPage,
        nextPageUrl,
        prevPageUrl,
        total,
        items,
      ];
}
