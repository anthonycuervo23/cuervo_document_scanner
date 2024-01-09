import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profit_loss_sheet_state.dart';

class ProfitLossSheetCubit extends Cubit<ProfitLossSheetState> {
  ProfitLossSheetCubit() : super(ProfitLossSheetInitial());
}
