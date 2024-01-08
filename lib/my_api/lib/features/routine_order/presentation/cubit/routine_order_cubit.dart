import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'routine_order_state.dart';

class RoutineOrderCubit extends Cubit<RoutineOrderState> {
  final LoadingCubit loadingCubit;
  RoutineOrderCubit({required this.loadingCubit}) : super(const RoutineOrderLoadedState());

  void deleteItem({required index}) {}
}
