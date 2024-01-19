import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());
}
