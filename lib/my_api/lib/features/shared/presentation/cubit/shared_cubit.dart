// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedInitial());
}
