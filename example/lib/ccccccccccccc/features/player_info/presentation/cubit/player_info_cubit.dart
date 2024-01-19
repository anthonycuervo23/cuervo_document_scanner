import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_info_state.dart';

class PlayerInfoCubit extends Cubit<PlayerInfoState> {
  PlayerInfoCubit() : super(PlayerInfoInitial());
}
