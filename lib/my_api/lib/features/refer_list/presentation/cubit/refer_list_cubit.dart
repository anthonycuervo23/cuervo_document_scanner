import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'refer_list_state.dart';

class ReferListCubit extends Cubit<ReferListState> {
  ReferListCubit() : super(ReferListInitial());
}
