// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/chat_support/data/models/chat_support_model.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/cubit/chat_suppport_cubit.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/view/chat_support_screen.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/view/trim_screen_view.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

abstract class ChatSupportWidget extends State<ChatSupportScreen> {
  late ChatSuppportCubit chatSuppportCubit;

  @override
  void initState() {
    chatSuppportCubit = getItInstance<ChatSuppportCubit>();
    chatSuppportCubit.sendCubit.state;
    super.initState();
  }

  @override
  void dispose() {
    chatSuppportCubit.loadingCubit.hide();
    chatSuppportCubit.close();
    super.dispose();
  }

  Widget sendMessageTextFiled() {
    return CommonWidget.container(
      height: 100.h,
      padding: EdgeInsets.all(10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.note_maximum_5_mb_file_upload.translate(context),
            fontSize: 12.sp,
            color: const Color.fromRGBO(34, 34, 34, 0.5),
            fontWeight: FontWeight.w700,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CommonWidget.container(
                  height: 50.h,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: chatSuppportCubit.messageController,
                    onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
                    onChanged: (value) {
                      chatSuppportCubit.hideShowSendButton(data: value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appConstants.default6Color),
                        borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appConstants.primary1Color),
                        borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                      ),
                      disabledBorder: InputBorder.none,
                      counterText: "",
                      hintText: TranslationConstants.type_a_message.translate(context),
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: appConstants.default4Color,
                      ),
                      prefixIcon: CommonWidget.sizedBox(
                        width: 70,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result = await chatSuppportCubit.pickFileForMobile();
                                    if (result != null) {
                                      if ((result.files[0].size / 1024) < 5120) {
                                        File file = File(result.files.first.path ?? "");
                                        String imagePath = await chatSuppportCubit.uploadFile(
                                          filePath: file.readAsBytesSync(),
                                          fileName: result.files[0].name,
                                          lastKey: result.files[0].name.endsWith('.mp4')
                                              ? 'video'
                                              : result.files[0].name.endsWith('.jpg') ||
                                                      result.files[0].name.endsWith('.png')
                                                  ? 'photo'
                                                  : result.files[0].name.endsWith('.mp3')
                                                      ? 'audio'
                                                      : '',
                                        );
                                        chatSuppportCubit.addChatForList(
                                          chatModel: ChatSupportModel(
                                            id: chatSuppportCubit.firebaseCollectionUserIdKey,
                                            userName: userEntity?.name ?? "",
                                            message: imagePath,
                                            time: "${DateTime.now().microsecondsSinceEpoch}",
                                            endValue: result.files[0].name.endsWith('.mp4')
                                                ? 'video'
                                                : result.files[0].name.endsWith('.jpg') ||
                                                        result.files[0].name.endsWith('.png')
                                                    ? 'photo'
                                                    : result.files[0].name.endsWith('.mp3')
                                                        ? 'audio'
                                                        : '',
                                            isSendMessage: true,
                                          ),
                                        );
                                      }
                                    } else {
                                      CustomSnackbar.show(
                                        snackbarType: SnackbarType.ERROR,
                                        message: "Please Select File",
                                      );
                                    }
                                  },
                                  child: CommonWidget.imageBuilder(
                                    imageUrl: "assets/photos/svg/chat/attach.svg",
                                    height: 23.h,
                                    width: 23.w,
                                  ),
                                ),
                                CommonWidget.sizedBox(width: 10),
                                VerticalDivider(color: const Color.fromRGBO(217, 217, 217, 1), thickness: 2.sp),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    onTap: () async => await chatSuppportCubit.scrollDown(),
                  ),
                ),
              ),
              BlocBuilder<ToggleCubit, bool>(
                bloc: chatSuppportCubit.sendCubit,
                builder: (context, state) {
                  return Visibility(
                    visible: state,
                    child: GestureDetector(
                      onTap: () async {
                        await chatSuppportCubit.scrollDown();
                        ChatSupportModel chatModel = ChatSupportModel(
                          endValue: '',
                          time: "${DateTime.now().microsecondsSinceEpoch}",
                          isSendMessage: true,
                          message: chatSuppportCubit.messageController.text,
                          userName: userEntity?.name ?? "",
                          id: userEntity?.id.toString() ?? "",
                        );
                        if (chatSuppportCubit.messageController.text.trim().isEmpty) {
                          CommonWidget.keyboardClose(context: context);
                        } else {
                          chatSuppportCubit.addChatForList(chatModel: chatModel);
                          chatSuppportCubit.messageController.clear();
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        alignment: Alignment.center,
                        child: CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/chat/send.svg",
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chatHistoryList() {
    // chatSuppportCubit.deleteData();
    return StreamBuilder(
      stream: chatSuppportCubit.readChatForList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          chatSuppportCubit.chatHistoryList.clear();
          List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
          for (var messageElement in data) {
            chatSuppportCubit.chatHistoryList.add(
              ChatSupportModel(
                endValue: messageElement['endValue'],
                id: messageElement.id,
                isSendMessage: messageElement['isSendMessage'],
                message: messageElement['message'],
                time: messageElement['time'],
                userName: messageElement['userName'],
              ),
            );
          }
          chatSuppportCubit.filterData();
          return Center(
            child: ListView.builder(
              reverse: true,
              controller: chatSuppportCubit.scrollController,
              itemCount: chatSuppportCubit.chatHistoryList.length,
              itemBuilder: (context, index) {
                return chatSuppportCubit.chatHistoryList[index].isSendMessage
                    ? userChatView(index: index, context: context)
                    : Container();
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: CommonWidget.commonText(text: "${snapshot.error}"));
        } else {
          return CommonWidget.loadingIos();
        }
      },
    );
  }

  Widget userChatView({required int index, required BuildContext context}) {
    return CommonWidget.container(
      color: Colors.transparent,
      padding: EdgeInsets.all(15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              nameAndDateView(index: index, context: context),
              messageView(index: index),
            ],
          ),
          CommonWidget.sizedBox(width: 5),
          profilePictureView(),
        ],
      ),
    );
  }

  Widget profilePictureView() {
    return Container(
      height: 50.w,
      alignment: Alignment.center,
      child: userEntity?.profilePhoto != ''
          ? CommonWidget.imageBuilder(
              borderRadius: 50,
              fit: BoxFit.cover,
              imageUrl: userEntity?.profilePhoto ?? "",
            )
          : accountInfoEntity?.defaultImage.isNotEmpty == true
              ? CommonWidget.imageBuilder(
                  borderRadius: 50,
                  height: 50.w,
                  fit: BoxFit.cover,
                  imageUrl: accountInfoEntity!.defaultImage,
                )
              : CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/edit_profile/avtar_picture.svg",
                  fit: BoxFit.cover,
                ),
    );
  }

  Widget messageView({required int index}) {
    return chatSuppportCubit.chatHistoryList[index].message.isEmpty
        ? const SizedBox.shrink()
        : chatSuppportCubit.chatHistoryList[index].endValue.isNotEmpty
            ? chatSuppportCubit.chatHistoryList[index].endValue == 'audio'
                ? audioViewScreen(index: index)
                : chatSuppportCubit.chatHistoryList[index].endValue == 'video'
                    ? videoViewScreen(index: index)
                    : imageViewScreen(index: index)
            : textViewScreen(index: index);
  }

  Widget nameAndDateView({required int index, required BuildContext context}) {
    return CommonWidget.commonText(
      text: "${chatSuppportCubit.chatHistoryList[index].userName} | ${DateFormat.jm().format(
        DateTime.fromMicrosecondsSinceEpoch(
          int.tryParse(chatSuppportCubit.chatHistoryList[index].time.toString()) ?? 0,
        ),
      )}",
      style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
            color: appConstants.default4Color,
          ),
    );
  }

  Widget textViewScreen({required int index}) {
    return Container(
      decoration: BoxDecoration(
        color: appConstants.primary1Color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
          bottomRight: Radius.circular(10.sp),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: 200.w,
      ),
      padding: EdgeInsets.all(10.h),
      child: CommonWidget.commonText(
        text: chatSuppportCubit.chatHistoryList[index].message,
        style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
              color: appConstants.whiteBackgroundColor,
            ),
      ),
    );
  }

  Widget imageViewScreen({required int index}) {
    return Container(
      decoration: BoxDecoration(
        color: appConstants.primary1Color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
          bottomRight: Radius.circular(10.sp),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: 180.w,
      ),
      padding: EdgeInsets.all(10.h),
      child: CommonWidget.imageBuilder(
        imageUrl: chatSuppportCubit.chatHistoryList[index].message,
      ),
    );
  }

  Widget audioViewScreen({required int index}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
          bottomRight: Radius.circular(10.sp),
        ),
      ),
      constraints: BoxConstraints(
        maxWidth: 200.w,
      ),
      padding: EdgeInsets.all(10.h),
      child: BlocBuilder<ChatSuppportCubit, double>(
        bloc: chatSuppportCubit,
        builder: (context, snapshot) {
          return Row(
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: appConstants.primary1Color,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    chatSuppportCubit.isPlay ? Icons.pause : Icons.play_arrow,
                    color: appConstants.whiteBackgroundColor,
                  ),
                  onPressed: () async {
                    chatSuppportCubit.changeIcon();
                    chatSuppportCubit.findTotalDuration(index: index);
                    if (chatSuppportCubit.isPlay) {
                      chatSuppportCubit.audioPlayer.play();
                      Timer.periodic(
                        const Duration(seconds: 1),
                        (timer) {
                          chatSuppportCubit.changeSliderValue();
                        },
                      );
                    } else {
                      chatSuppportCubit.audioPlayer.pause();
                    }
                  },
                ),
              ),
              CommonWidget.sizedBox(width: 5),
              SizedBox(
                height: 50.h,
                width: 130.w,
                child: WaveSlider(
                  duration: chatSuppportCubit.duration.inSeconds.toDouble(),
                  callbackStart: (v) {
                    chatSuppportCubit.audioPlayer.seek(
                      Duration(seconds: v.toInt()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget videoViewScreen({required int index}) {
    chatSuppportCubit.controller = VideoPlayerController.networkUrl(
      Uri.parse(chatSuppportCubit.chatHistoryList[index].message),
    );
    chatSuppportCubit.controller.initialize();
    return InkWell(
      onTap: () {
        CommonRouter.pushNamed(
          RouteList.video_play_screen,
          arguments: chatSuppportCubit.chatHistoryList[index].message,
        );
      },
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.sp),
            topLeft: Radius.circular(10.sp),
            bottomRight: Radius.circular(10.sp),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: 150.w,
        ),
        padding: EdgeInsets.all(10.h),
        child: VideoPlayer(chatSuppportCubit.controller),
      ),
    );
  }
}
