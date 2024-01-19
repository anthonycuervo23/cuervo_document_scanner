import 'package:intl/intl.dart';

extension CurrencyFormatter on num {
  String formatCurrency() {
    final formatCurrency = NumberFormat.currency(symbol: '₹', locale: 'en_IN', decimalDigits: 0);
    return formatCurrency.format(this);
  }
}
