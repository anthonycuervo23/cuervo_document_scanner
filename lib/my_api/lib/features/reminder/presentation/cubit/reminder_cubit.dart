// ignore_for_file: unrelated_type_equality_checks
import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/anniversory_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/birthday_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/models/events_reminder_model.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/anniversory_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/birhday_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/entities/events_reminder_entities.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/perams/reminder_perams.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_anniversory_data.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_birthday_data.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_events_data.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

part 'reminder_state.dart';

enum ReminderType { birthday, anniversary, event }

class ReminderCubit extends Cubit<ReminderState> {
  final LoadingCubit loadingCubit;
  final GetBirthdayData getBirthdayData;
  final GetAnniversoryData getAnniversoryData;
  final GetEventsData getEventsData;
  final CounterCubit counterCubit;
  final SearchFilterCubit searchFilterCubit;

  ReminderCubit({
    required this.loadingCubit,
    required this.counterCubit,
    required this.searchFilterCubit,
    required this.getBirthdayData,
    required this.getAnniversoryData,
    required this.getEventsData,
  }) : super(ReminderInitialState());

  List<String> allDataList = ['All', ''];
  TextEditingController searchController = TextEditingController();

  Future<void> loadData({
    required ReminderType reminderType,
    bool loaderShow = true,
    bool nextPageLoad = false,
  }) async {
    // int page = 1;
    // if (state is ReminderLoadedState) {
    //   var loadedState = state as ReminderLoadedState;
    //   page = loadedState.birthdayReminderData?.currentPage ?? 1 + 1;
    // } else {
    //   page = 1;
    // }
    loadingCubit.show();

    int pageNumber = 1;

    if (reminderType == ReminderType.birthday) {
      if (state is ReminderLoadedState && nextPageLoad) {
        pageNumber = ((state as ReminderLoadedState).birthdayReminderData!.currentPage) + 1;
      } else {
        loadingCubit.show();
      }

      Either<AppError, BirthdayReminderEntities> response = await getBirthdayData(ReminderParams(page: pageNumber));
      response.fold(
        (error) async {
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          emit(ReminderErrorState(appErrorType: error.errorType, erroMessage: error.errorMessage));
          loadingCubit.hide();
        },
        (data) {
          if (data.items.isNotEmpty) {
            if (state is ReminderLoadedState) {
              var loadedState = state as ReminderLoadedState;
              emit(loadedState.copywith(
                birthdayDataList: data.items,
                birthdayReminderData: data,
                random: Random().nextDouble(),
              ));
            } else {
              emit(ReminderLoadedState(birthdayReminderData: data, birthdayDataList: data.items));
            }
          }
          loadingCubit.hide();
        },
      );
    } else if (reminderType == ReminderType.anniversary) {
      if (state is ReminderLoadedState && nextPageLoad) {
        pageNumber = ((state as ReminderLoadedState).anniversoryReminderData!.currentPage) + 1;
      } else {
        loadingCubit.show();
      }
      Either<AppError, AnniversoryReminderEntities> response =
          await getAnniversoryData(ReminderParams(page: pageNumber));

      response.fold(
        (error) async {
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          emit(ReminderErrorState(appErrorType: error.errorType, erroMessage: error.errorMessage));
          loadingCubit.hide();
        },
        (data) {
          if (data.items.isNotEmpty) {
            if (state is ReminderLoadedState) {
              var loadedState = state as ReminderLoadedState;
              emit(loadedState.copywith(
                anniversoryDataList: data.items,
                anniversoryReminderData: data,
                random: Random().nextDouble(),
              ));
            } else {
              emit(ReminderLoadedState(anniversoryReminderData: data, anniversoryDataList: data.items));
            }
          }
          loadingCubit.hide();
        },
      );
    } else if (reminderType == ReminderType.event) {
      if (state is ReminderLoadedState && nextPageLoad) {
        pageNumber = ((state as ReminderLoadedState).eventsReminderData!.currentPage) + 1;
      } else {
        loadingCubit.show();
      }
      Either<AppError, EventsReminderEntities> response = await getEventsData(ReminderParams(page: pageNumber));

      response.fold(
        (error) async {
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }

          emit(ReminderErrorState(appErrorType: error.errorType, erroMessage: error.errorMessage));
          loadingCubit.hide();
        },
        (data) {
          if (data.items.isNotEmpty) {
            if (state is ReminderLoadedState) {
              var loadedState = state as ReminderLoadedState;
              emit(loadedState.copywith(
                eventsDataList: data.items,
                eventsReminderData: data,
                random: Random().nextDouble(),
              ));
            } else {
              emit(ReminderLoadedState(eventsReminderData: data, eventsDataList: data.items));
            }
          }
          loadingCubit.hide();
        },
      );
    }
  }

  Future<void> call({required String phoneNo}) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNo);
    await launchUrl(launchUri);
  }

  // void clearFilter() {
  //   emit(ReminderLoadedState(random: Random().nextDouble(), reminderData: remiderDataList));
  //   CommonRouter.pop();
  // }

  whatsapp({required String phoneNo}) async {
    var url = "https://wa.me/91$phoneNo";
    launchUrl(Uri.parse(url));
  }

  // void filterData({required ReminderLoadedState state, required String value}) {
  //   allDataList[1] = value;
  //   commonFilter(state: state);
  // }

  // void filter({required ReminderLoadedState state, required int index}) {
  //   allDataList[0] = ReminderType.values[index].name;
  //   commonFilter(state: state);
  // }

  // void commonFilter({required ReminderLoadedState state}) {
  //   List<ReminderModel> tempList = remiderDataList;
  //   List<ReminderModel> filterList = [];
  //   List<ReminderModel> filterLists = [];
  //   if (searchController.text.isNotEmpty) {
  //     filterList = [];
  //     filterList = tempList
  //         .where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase()))
  //         .toList();
  //   } else {
  //     filterList = tempList;
  //   }
  //   filterLists = filterList;

  //   if (allDataList[0].isNotEmpty) {
  //     filterList = [];
  //     if (allDataList[0] == ReminderType.all.name) {
  //       filterList = filterLists;
  //     } else {
  //       for (var e in filterLists) {
  //         if (e.reminderType.name == allDataList[0]) {
  //           filterList.add(e);
  //         }
  //       }
  //     }
  //   } else {
  //     filterList = filterLists;
  //   }

  //   List<ReminderModel> filterList1 = filterList;
  //   List<String> customDateList = allDataList[1].split(' - ');
  //   SearchCategory? searchCategory;
  //   for (var e in SearchCategory.values) {
  //     if (customDateList[0] == e.name) {
  //       searchCategory = e;
  //     }
  //   }
  //   if (customDateList[0] == SearchCategory.Custom_Range.name) {
  //     filterList = [];
  //     if (searchCategory != null) {
  //       filterList = filterDataByDate(
  //         data: filterList1,
  //         filter: searchCategory,
  //         customEndDate: customDateList[2],
  //         customStartDate: customDateList[1],
  //       );
  //     }
  //   } else {
  //     if (searchCategory != null) {
  //       filterList = filterDataByDate(
  //         data: filterList1,
  //         filter: searchCategory,
  //       );
  //     }
  //   }

  //   emit(state.copywith(filterList: filterList, random: Random().nextDouble()));
  // }

  // List<ReminderModel> filterDataByDate({
  //   required List<ReminderModel> data,
  //   required SearchCategory filter,
  //   String? customStartDate,
  //   String? customEndDate,
  // }) {
  //   DateTime dateTime = DateTime.now();
  //   DateTime currentDate = parseDate("${dateTime.day}/${dateTime.month}/${dateTime.year}");
  //   switch (filter) {
  //     case SearchCategory.Today:
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         if (e.date == "${dateTime.day}/${dateTime.month}/${dateTime.year}") {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.Yesterday:
  //       DateTime yesterday = currentDate.add(const Duration(days: -1));
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         if (yesterday.day < 10) {
  //           if (e.date == "0${yesterday.day}/${yesterday.month}/${yesterday.year}") {
  //             l1.add(e);
  //           }
  //         } else {
  //           if (e.date == "${yesterday.day}/${yesterday.month}/${yesterday.year}") {
  //             l1.add(e);
  //           }
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.Last_7_Days:
  //       DateTime last7DaysStart = currentDate.subtract(const Duration(days: 6));
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         DateTime tempDate = parseDate(e.date);
  //         if (tempDate.isAfter(last7DaysStart) && tempDate.isBefore(DateTime.now())) {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.Last_30_Days:
  //       DateTime last30DaysStart = currentDate.subtract(const Duration(days: 30));
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         DateTime tempDate = parseDate(e.date);
  //         if (tempDate.isAfter(last30DaysStart) && tempDate.isBefore(DateTime.now())) {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.This_Month:
  //       DateTime dateTime = DateTime.now();
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         if (dateTime.month == int.parse(e.date.substring(3, 5))) {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.Last_Month:
  //       DateTime dateTime = DateTime.now();
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         if (dateTime.month - 1 == int.parse(e.date.substring(3, 5))) {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     case SearchCategory.Custom_Range:
  //       DateTime startDate = DateTime.parse(customStartDate ?? "");
  //       DateTime endDate = DateTime.parse(customEndDate ?? "");
  //       List<ReminderModel> l1 = [];
  //       for (var e in data) {
  //         DateTime dateTime = DateTime.parse(
  //           "${e.date.substring(6, 10)}-${e.date.substring(3, 5)}-${e.date.substring(0, 2)}",
  //         );
  //         if (startDate.isBefore(dateTime) && endDate.isAfter(dateTime)) {
  //           l1.add(e);
  //         }
  //       }
  //       return l1;
  //     default:
  //       return data;
  //   }
  // }
}
