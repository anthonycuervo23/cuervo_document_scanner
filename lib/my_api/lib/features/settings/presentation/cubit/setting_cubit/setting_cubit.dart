import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final LoadingCubit loadingCubit;

  SettingCubit({required this.loadingCubit}) : super(SettingLoadedState());
}
