// ignore_for_file: annotate_overrides, overridden_fields, must_be_immutable

import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/shared/data/models/model_response_extends.dart';

class AnniversoryReminderModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final AnniversoryData data;

  AnniversoryReminderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AnniversoryReminderModel.fromJson(Map<String, dynamic> json) => AnniversoryReminderModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: AnniversoryData.fromJson(json["data"]),
      );
}

class AnniversoryData extends AnniversoryReminderEntities {
  int from;
  int to;
  int currentPage;
  int lastPage;
  int perPage;
  String nextPageUrl;
  String prevPageUrl;
  int total;
  List<AnniversoryReminderDataModel> items;

  AnniversoryData({
    required this.from,
    required this.to,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
    required this.items,
  }) : super(
          from: from,
          to: to,
          currentPage: currentPage,
          lastPage: lastPage,
          perPage: perPage,
          nextPageUrl: nextPageUrl,
          prevPageUrl: prevPageUrl,
          total: total,
          items: items,
        );

  factory AnniversoryData.fromJson(Map<String, dynamic> json) => AnniversoryData(
        from: json["from"] ?? 0,
        to: json["to"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        perPage: json["per_page"] ?? 0,
        nextPageUrl: json["next_page_url"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        total: json["total"] ?? 0,
        items: json["items"] != null
            ? List<AnniversoryReminderDataModel>.from(
                json["items"].map((x) => AnniversoryReminderDataModel.fromJson(x)))
            : [],
      );
}

class AnniversoryReminderDataModel {
  int id;
  String name;
  String anniversaryDate;
  String mobile;
  String email;

  AnniversoryReminderDataModel({
    required this.id,
    required this.name,
    required this.anniversaryDate,
    required this.mobile,
    required this.email,
  });

  factory AnniversoryReminderDataModel.fromJson(Map<String, dynamic> json) => AnniversoryReminderDataModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        anniversaryDate: json["anniversary_date"] ?? "",
        mobile: json["mobile"],
        email: json["email"] ?? "",
      );
}
