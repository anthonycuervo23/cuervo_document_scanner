import 'package:captain_score/core/build_context.dart';
import 'package:captain_score/shared/utils/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String intelliTrim({int maxLength = 15}) {
    return length > maxLength ? '${substring(0, maxLength)}...' : this;
  }

  String translate(context) {
    return (AppLocalizations.of(context ?? buildContext)?.translate(this) ??
            AppLocalizations.of(context ?? buildContext)?.defaultTranslate(this) ??
            '')
        .replaceAll("\\n", "\n")
        .replaceAll("==", "\n");
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

  String removeHTMLTag() {
    return toString()
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("<br />", "")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&amp;", "&")
        .replaceAll("</p>", "")
        .replaceAll(".", "");
  }

  String boldTag() {
    return "<b>${toString()}</b>".replaceAll(".", "");
  }
}
