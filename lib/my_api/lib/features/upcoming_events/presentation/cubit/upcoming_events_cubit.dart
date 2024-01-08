import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/data/models/upcoming_events_model.dart';
import 'package:bakery_shop_admin_flutter/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'upcoming_events_state.dart';

class UpcomingEventsCubit extends Cubit<UpcomingEventsState> {
  UpcomingEventsCubit()
      : super(UpcomingEventsLoadedState(
          listOfEvents: listOfEvent,
        ));

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventInfoController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<String> allDataList = [''];

  void addEvent({required UpcomingEventsLoadedState state, required UpcomingEventsModel model}) {
    List<UpcomingEventsModel> tempList = listOfEvent;
    tempList.add(model);
    emit(state.copyWith(listOfEvents: tempList, random: Random().nextDouble()));
  }

  void updateEvent({required UpcomingEventsLoadedState state, required UpcomingEventsModel model}) {
    List<UpcomingEventsModel> tempList = listOfEvent;
    tempList[model.index ?? 0] = model;
    emit(state.copyWith(listOfEvents: tempList, random: Random().nextDouble()));
  }

  void deleteEvent({required int index, required UpcomingEventsLoadedState state}) {
    List<UpcomingEventsModel> tempList = [];
    listOfEvent.removeAt(index);
    tempList = listOfEvent;
    emit(state.copyWith(listOfEvents: tempList, random: Random().nextDouble()));
  }

  void dateChanage({required String date, required UpcomingEventsLoadedState state}) {
    eventDateController = TextEditingController(text: date);
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void fillTextFieldData({required UpcomingEventsModel model}) {
    eventNameController = TextEditingController(text: model.eventName);
    eventDateController = TextEditingController(text: model.eventDate);
    eventInfoController = TextEditingController(text: model.eventInformation);
  }

  void filterForDate({required String value, required UpcomingEventsLoadedState state}) {
    allDataList[0] = value;
    commonFilter(state: state);
  }

  void commonFilter({required UpcomingEventsLoadedState state}) {
    List<UpcomingEventsModel> tempList = listOfEvent;
    List<UpcomingEventsModel> filterList = [];
    List<UpcomingEventsModel> filterLists = [];
    if (searchController.text.isNotEmpty) {
      filterList = [];
      filterList = tempList
          .where((element) => element.eventName.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      filterList = tempList;
    }
    filterLists = filterList;

    List<String> customDateList = allDataList[0].split(' - ');
    SearchCategory? searchCategory;
    for (var e in SearchCategory.values) {
      if (customDateList[0] == e.name) {
        searchCategory = e;
      }
    }
    if (customDateList[0] == SearchCategory.Custom_Range.name) {
      filterList = [];
      if (searchCategory != null) {
        filterList = filterDataByDate(
          data: filterLists,
          filter: searchCategory,
          customEndDate: customDateList[2],
          customStartDate: customDateList[1],
        );
      }
    } else {
      filterList = [];
      filterList = filterDataByDate(
        data: filterLists,
        filter: searchCategory ?? SearchCategory.All,
      );
    }
    //
    //List<String> l1 = allValue[0].split(' - ');
    // if (l1[0].isNotEmpty) {
    //   filterList = [];
    //   if (l1[0] == SearchCategory.Today.name) {
    //     DateTime todatDate = DateTime.now();
    //     for (var e in filterLists) {
    //       if (todatDate.day < 10) {
    //         if (e.eventDate == "0${todatDate.day}-${todatDate.month}-${todatDate.year}") {
    //           filterList.add(e);
    //         }
    //       } else {
    //         if (e.eventDate == "${todatDate.day}-${todatDate.month}-${todatDate.year}") {
    //           filterList.add(e);
    //         }
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.Yesterday.name) {
    //     DateTime dateTime = DateTime.now().add(const Duration(days: -1));
    //     for (var e in filterLists) {
    //       if (dateTime.day < 10) {
    //         if (e.eventDate == "0${dateTime.day}-${dateTime.month}-${dateTime.year}") {
    //           filterList.add(e);
    //         }
    //       } else {
    //         if (e.eventDate == "${dateTime.day}-${dateTime.month}-${dateTime.year}") {
    //           filterList.add(e);
    //         }
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.Last_7_Days.name) {
    //     DateTime last7DaysDate = DateTime.now().subtract(const Duration(days: 7));
    //     for (var e in filterLists) {
    //       DateTime tempDate = DateFormat("dd-MM-yyyy").parse(e.eventDate);
    //       if (tempDate.isAfter(last7DaysDate) && tempDate.isBefore(DateTime.now())) {
    //         filterList.add(e);
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.Last_30_Days.name) {
    //     DateTime last7DaysDate = DateTime.now().subtract(const Duration(days: 30));
    //     for (var e in filterLists) {
    //       DateTime tempDate = DateFormat("dd-MM-yyyy").parse(e.eventDate);
    //       if (tempDate.isAfter(last7DaysDate) && tempDate.isBefore(DateTime.now())) {
    //         filterList.add(e);
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.This_Month.name) {
    //     DateTime dateTime = DateTime.now();
    //     for (var e in filterLists) {
    //       if (dateTime.month == int.parse(e.eventDate.substring(3, 5))) {
    //         filterList.add(e);
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.Last_Month.name) {
    //     DateTime dateTime = DateTime.now();
    //     for (var e in filterLists) {
    //       if (dateTime.month - 1 == int.parse(e.eventDate.substring(3, 5))) {
    //         filterList.add(e);
    //       }
    //     }
    //   } else if (l1[0] == SearchCategory.Custom_Range.name) {
    //     DateTime startDate = DateTime.parse(l1[1]);
    //     DateTime endDate = DateTime.parse(l1[2]);
    //     for (var e in filterLists) {
    //       DateTime dateTime = DateTime.parse(
    //         "${e.eventDate.substring(6, 10)}-${e.eventDate.substring(3, 5)}-${e.eventDate.substring(0, 2)}",
    //       );
    //       if (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)) {
    //         filterList.add(e);
    //       }
    //     }
    //   } else {
    //     filterList = filterLists;
    //   }
    // } else {
    //   filterList = filterLists;
    // }
    emit(state.copyWith(filterList: filterList, random: Random().nextDouble()));
  }

  List<UpcomingEventsModel> filterDataByDate({
    required List<UpcomingEventsModel> data,
    required SearchCategory filter,
    String? customStartDate,
    String? customEndDate,
  }) {
    DateTime dateTime = DateTime.now();
    DateTime currentDate = parseDate("${dateTime.day}/${dateTime.month}/${dateTime.year}");
    switch (filter) {
      case SearchCategory.Today:
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          if (e.eventDate == "${dateTime.day}/${dateTime.month}/${dateTime.year}") {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Yesterday:
        DateTime yesterday = currentDate.add(const Duration(days: -1));
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          if (yesterday.day < 10) {
            if (e.eventDate == "0${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          } else {
            if (e.eventDate == "${yesterday.day}/${yesterday.month}/${yesterday.year}") {
              l1.add(e);
            }
          }
        }
        return l1;
      case SearchCategory.Last_7_Days:
        DateTime last7DaysStart = currentDate.subtract(const Duration(days: 6));
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.eventDate);
          if (tempDate.isAfter(last7DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_30_Days:
        DateTime last30DaysStart = currentDate.subtract(const Duration(days: 30));
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          DateTime tempDate = parseDate(e.eventDate);
          if (tempDate.isAfter(last30DaysStart) && tempDate.isBefore(DateTime.now())) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.This_Month:
        DateTime dateTime = DateTime.now();
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          if (dateTime.month == int.parse(e.eventDate.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Last_Month:
        DateTime dateTime = DateTime.now();
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          if (dateTime.month - 1 == int.parse(e.eventDate.substring(3, 5))) {
            l1.add(e);
          }
        }
        return l1;
      case SearchCategory.Custom_Range:
        DateTime startDate = DateTime.parse(customStartDate ?? "");
        DateTime endDate = DateTime.parse(customEndDate ?? "");
        List<UpcomingEventsModel> l1 = [];
        for (var e in data) {
          DateTime dateTime = DateTime.parse(
            "${e.eventDate.substring(6, 10)}-${e.eventDate.substring(3, 5)}-${e.eventDate.substring(0, 2)}",
          );
          if (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)) {
            l1.add(e);
          }
        }
        return l1;
      default:
        return data;
    }
  }
}
