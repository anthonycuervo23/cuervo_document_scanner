import 'package:bakery_shop_admin_flutter/app_localizations.dart';
import 'package:bakery_shop_admin_flutter/core/build_context.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String translate(context) {
    return AppLocalizations.of(context ?? buildContext)?.translate(this) ??
        AppLocalizations.of(context ?? buildContext)?.defaultTranslate(this) ??
        '';
  }

  String countryTrim() {
    return length > 20 ? '${substring(0, 20)}...' : this;
  }

  String toCamelcase() {
    return toLowerCase().replaceAllMapped(RegExp(r'\b\w'), (match) => match.group(0)!.toUpperCase());
    // return length > 1 ? substring(0, 1).toUpperCase() + substring(1, length) : this;
  }

  Color toColor() {
    try {
      var hexColor = replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      if (hexColor.length == 8) {
        return Color(int.parse("0x$hexColor"));
      }
      return const Color(0xFFFFFFFF);
    } on Exception {
      return const Color(0xFFFFFFFF);
    }
  }
}

extension CurrencyFormatter on num {
  String formatCurrency() {
    final formatCurrency = NumberFormat.currency(symbol: '₹', locale: 'en_IN', decimalDigits: 0);
    return formatCurrency.format(this);
  }
}
