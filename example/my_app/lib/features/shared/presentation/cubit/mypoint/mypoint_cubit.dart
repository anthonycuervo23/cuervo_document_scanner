import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mypoint_state.dart';

class MypointCubit extends Cubit<MypointState> {
  MypointCubit() : super(MypointInitial());
}
