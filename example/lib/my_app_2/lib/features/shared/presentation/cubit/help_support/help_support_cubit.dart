import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'help_support_state.dart';

class HelpAndSupportCubit extends Cubit<HelpAndSupportState> {
  HelpAndSupportCubit() : super(const HelpAndSupportLoadedState());
}
