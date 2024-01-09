import 'package:intl/intl.dart';

DateTime parseDate(String dateString) {
  return DateFormat('dd/M/yyyy').parse(dateString);
}
