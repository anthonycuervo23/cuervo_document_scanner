import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'role_management_state.dart';

class RoleManagementCubit extends Cubit<RoleManagementState> {
  RoleManagementCubit() : super(RoleManagementInitial());
}
