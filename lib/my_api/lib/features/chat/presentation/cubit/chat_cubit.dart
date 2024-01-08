import 'dart:io';
import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/chat/data/models/chat_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ToggleCubit toggleCubit;
  ChatCubit({required this.toggleCubit})
      : super(
          ChatLoadedState(
            listOfMessage: listOfUserMessages,
          ),
        );

  ScrollController scrollController = ScrollController();
  TextEditingController txtSendMessageController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void hideShowSendButton({required String data}) {
    data.isEmpty ? toggleCubit.setValue(value: false) : toggleCubit.setValue(value: true);
  }

  void addData({required String message, required ChatLoadedState state, required int index}) {
    MessageModel messageModel = MessageModel(
      message: message,
      profileImage: "",
      time: "10:10 am",
      sendMessage: true,
    );

    state.listOfMessage[index].listOfMessage?.add(messageModel);

    emit(state.copyWith(random: Random().nextDouble(), listOfMessage: state.listOfMessage));
  }

  Future<void> pickFileForMobile({
    required BuildContext context,
    required ChatLoadedState state,
    required int index,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    List<UserNameDetail> listOfMessage = state.listOfMessage;

    if (result != null) {
      var file = File(result.files[0].path ?? "");
      final bytes = file.readAsBytesSync().lengthInBytes;
      double kb = bytes / 1024;
      double mb = kb / 1024;

      if (mb < 5.00) {
        listOfMessage[index].listOfMessage?.add(
              MessageModel(
                message: file.path,
                profileImage: "",
                time: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                sendMessage: true,
              ),
            );
      }
      emit(state.copyWith(listOfMessage: listOfMessage, random: Random().nextDouble()));
    }
  }

  void filterForSearch({required ChatLoadedState state, required String value}) {
    List<UserNameDetail> l1 =
        listOfUserMessages.where((element) => element.userName.toLowerCase().contains(value.toLowerCase())).toList();
    emit(state.copyWith(listOfMessage: l1, random: Random().nextDouble()));
  }
}
