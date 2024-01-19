import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_cubit_state.dart';

class HomePageCubit extends Cubit<HomePageCubitState> {
  HomePageCubit() : super(HomePageCubitInitial());
}
