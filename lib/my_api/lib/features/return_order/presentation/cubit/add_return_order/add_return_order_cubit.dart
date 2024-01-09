import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_return_order_state.dart';

class AddReturnOrderCubit extends Cubit<AddReturnOrderState> {
  AddReturnOrderCubit() : super(AddReturnOrderInitial());
}
