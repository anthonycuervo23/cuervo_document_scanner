import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'reminder_date_state.dart';

class ReminderDateCubit extends Cubit<ReminderDateState> {
  String formattedDate = ''; //DateFormat('d MMM, yyyy EEEE').format(DateTime.now()).toString();
  ReminderDateCubit() : super(ReminderDateLoadedState(date: DateTime.now()));

  void selectReminderDate({DateTime? date}) {
    DateFormat formatter = DateFormat('d MMM, yyyy EEEE');
    formattedDate = formatter.format(date!);
    emit(ReminderDateLoadedState(date: date));
  }
}
