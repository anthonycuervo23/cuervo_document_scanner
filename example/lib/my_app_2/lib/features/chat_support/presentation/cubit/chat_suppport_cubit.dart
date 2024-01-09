import 'dart:math';

import 'package:bakery_shop_flutter/features/chat_support/data/models/chat_support_model.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class ChatSuppportCubit extends Cubit<double> {
  final LoadingCubit loadingCubit;
  final ToggleCubit sendCubit;
  ChatSuppportCubit({required this.loadingCubit, required this.sendCubit}) : super(0);
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlay = false;

  String firebaseCollectionKey = 'ChatSuppport';
  String firebaseSecCollectionKey = 'chat';
  String firebaseCollectionUserIdKey = '${userEntity?.id}';

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<ChatSupportModel> chatHistoryList = [];
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  late VideoPlayerController controller;

  Future<String> deleteData() {
    return firebaseFirestore
        .collection("ChatSuppport")
        .doc("${userEntity?.id}")
        .collection("chat")
        .doc("jGNWli6d1DnLp4XpPkn7")
        .delete()
        .then((value) => "true");
  }

  Future<bool> addChatForList({required ChatSupportModel chatModel}) async {
    return await firebaseFirestore
        .collection(firebaseCollectionKey)
        .doc(firebaseCollectionUserIdKey)
        .collection(firebaseSecCollectionKey)
        .add(
          {
            'userName': chatModel.userName,
            'id': chatModel.id,
            'message': chatModel.message,
            'isSendMessage': chatModel.isSendMessage,
            'time': chatModel.time,
            'endValue': chatModel.endValue,
          },
        )
        .then((value) => true)
        .catchError((e) => false);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatForList() {
    return firebaseFirestore
        .collection(firebaseCollectionKey)
        .doc(firebaseCollectionUserIdKey)
        .collection(firebaseSecCollectionKey)
        .snapshots();
  }

  Future<FilePickerResult?> pickFileForMobile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result;
  }

  Future<String> uploadFile({
    required Uint8List filePath,
    required String fileName,
    required String lastKey,
  }) async {
    FirebaseStorage.instance.ref('$lastKey/${userEntity?.id}/').child(fileName).putData(filePath);
    return await downloadURLExample(fileName: fileName, lastKey: lastKey);
  }

  Future<void> deleteFile() async {
    await FirebaseStorage.instance
        .ref('photo/$firebaseCollectionUserIdKey/')
        .child('Screenshot_20231230_170542.jpg')
        .delete();
  }

  Future<String> downloadURLExample({required String fileName, required String lastKey}) async {
    String downloadURL =
        await FirebaseStorage.instance.ref('$lastKey/${userEntity?.id}/').child(fileName).getDownloadURL();
    return downloadURL;
  }

  void filterData() {
    chatHistoryList.sort((a, b) => (int.parse(a.time) < int.parse(b.time)) == true ? 1 : 0);
  }

  Future<void> scrollDown() async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  void hideShowSendButton({required String data}) {
    data.isEmpty ? sendCubit.setValue(value: false) : sendCubit.setValue(value: true);
  }

  void changeIcon() {
    isPlay = !isPlay;
    emit(Random().nextDouble());
  }

  void changeSliderValue() {
    var pos = audioPlayer.position;
    position = pos;
    emit(Random().nextDouble());
  }

  Future<void> findTotalDuration({required int index}) async {
    var durations = await audioPlayer.setUrl(
          chatHistoryList[index].message,
        ) ??
        Duration.zero;
    duration = durations;
    emit(Random().nextDouble());
  }
}
