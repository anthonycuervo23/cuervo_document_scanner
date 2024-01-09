import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  bool isAfterDate(DateTime other) {
    return year >= other.year && month >= other.month && day >= other.day;
  }

  bool isBeforeDate(DateTime other) {
    return year <= other.year && month <= other.month && day <= other.day;
  }

  bool isNotToday(DateTime other) {
    return year != other.year || month != other.month || day != other.day;
  }

  String getTime() {
    String formattedTime = DateFormat.jm().format(toLocal());
    return formattedTime;
  }
}
