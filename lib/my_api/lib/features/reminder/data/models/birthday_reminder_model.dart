// import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';

// class ReminderModel {
//   int id;
//   String name;
//   String phoneNo;
//   String date;
//   String imagePath;
//   ReminderType reminderType;
//   ReminderModel({
//     required this.id,
//     required this.name,
//     required this.phoneNo,
//     required this.date,
//     required this.imagePath,
//     required this.reminderType,
//   });
// }

// List<ReminderModel> remiderDataList = [
//   ReminderModel(
//     id: 1,
//     name: "Sahil Antala",
//     phoneNo: '9876543210',
//     date: '15-10-2020',
//     imagePath: "assets/photos/svg/reminder_screen/birthday.svg",
//     reminderType: ReminderType.birthday,
//   ),
//   ReminderModel(
//     id: 2,
//     name: "Mohan Patel",
//     phoneNo: '9876543210',
//     date: '12-11-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.anniversary,
//   ),
//   ReminderModel(
//     id: 3,
//     name: "Krinal Saniya",
//     phoneNo: '9876543210',
//     date: '15-11-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.anniversary,
//   ),
//   ReminderModel(
//     id: 4,
//     name: "Rahul Sudani",
//     phoneNo: '9876543210',
//     date: '20-11-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.birthday,
//   ),
//   ReminderModel(
//     id: 5,
//     name: "Nisha Savaliya",
//     phoneNo: '9876543210',
//     date: '02-12-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.birthday,
//   ),
//   ReminderModel(
//     id: 6,
//     name: "Payal Kheni",
//     phoneNo: '9876543210',
//     date: '02-12-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.anniversary,
//   ),
//   ReminderModel(
//     id: 7,
//     name: "Opening Ceremony",
//     phoneNo: '9876543210',
//     date: '02-12-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.event,
//   ),
//   ReminderModel(
//     id: 8,
//     name: "Opening Ceremony",
//     phoneNo: '9876543210',
//     date: '01-12-2023',
//     imagePath: "assets/photos/svg/reminder_screen/event.svg",
//     reminderType: ReminderType.event,
//   ),
// ];

// // To parse this JSON data, do
// //
// //     final reminderModel = reminderModelFromJson(jsonString);

// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/birhday_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/shared/data/models/model_response_extends.dart';

class BithdayReminderModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final BirhdayData data;

  BithdayReminderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BithdayReminderModel.fromJson(Map<String, dynamic> json) => BithdayReminderModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: BirhdayData.fromJson(json["data"]),
      );
}

class BirhdayData extends BirthdayReminderEntities {
  final int from;
  final int to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;
  final List<BirthdayReminderDataModel> items;

  const BirhdayData({
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

  factory BirhdayData.fromJson(Map<String, dynamic> json) => BirhdayData(
        from: json["from"] ?? 0,
        to: json["to"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        perPage: json["per_page"] ?? 0,
        nextPageUrl: json["next_page_url"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        total: json["total"] ?? 0,
        items: json["items"] != null
            ? List<BirthdayReminderDataModel>.from(json["items"].map((x) => BirthdayReminderDataModel.fromJson(x)))
            : [],
      );
}

class BirthdayReminderDataModel {
  int id;
  String name;
  String dob;
  String mobile;
  String email;

  BirthdayReminderDataModel({
    required this.id,
    required this.name,
    required this.dob,
    required this.mobile,
    required this.email,
  });

  factory BirthdayReminderDataModel.fromJson(Map<String, dynamic> json) => BirthdayReminderDataModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        dob: json["dob"] ?? "",
        mobile: json["mobile"] ?? "",
        email: json["email"] ?? "",
      );
}
