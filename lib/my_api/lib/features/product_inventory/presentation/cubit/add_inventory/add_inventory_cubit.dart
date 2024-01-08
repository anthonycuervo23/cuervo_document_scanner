import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_inventory_state.dart';

class AddProductInventoryCubit extends Cubit<AddProductInventoryState> {
  AddProductInventoryCubit() : super(AddProductInventoryInitial());
  TextEditingController orderDate = TextEditingController();
  DateTime? selectOrderDate;
  bool? isSelect = false;
}
