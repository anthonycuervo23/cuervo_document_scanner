// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/events_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/shared/data/models/model_response_extends.dart';

class EventsReminderModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final Data data;

  EventsReminderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EventsReminderModel.fromJson(Map<String, dynamic> json) => EventsReminderModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"]),
      );
}

class Data extends EventsReminderEntities {
  int from;
  int to;
  int currentPage;
  int lastPage;
  int perPage;
  String nextPageUrl;
  String prevPageUrl;
  int total;
  List<EventsReminderDataModel> items;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        from: json["from"] ?? 0,
        to: json["to"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        perPage: json["per_page"] ?? 0,
        nextPageUrl: json["next_page_url"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        total: json["total"] ?? 0,
        items: json["items"] != null
            ? List<EventsReminderDataModel>.from(json["items"].map((x) => EventsReminderDataModel.fromJson(x)))
            : [],
      );
}

class EventsReminderDataModel {
  String id;
  String name;
  String eventDate;
  String description;

  EventsReminderDataModel({
    required this.id,
    required this.name,
    required this.eventDate,
    required this.description,
  });

  factory EventsReminderDataModel.fromJson(Map<String, dynamic> json) => EventsReminderDataModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        eventDate: json["event_date"] ?? "",
        description: json["description"] ?? "",
      );
}
