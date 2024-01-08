import 'dart:io';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  const ChatScreen({super.key, required this.index});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatCubit chatCubit;

  @override
  void initState() {
    chatCubit = getItInstance<ChatCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    chatCubit.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: chatCubit,
      builder: (context, state) {
        if (state is ChatLoadedState) {
          return Scaffold(
            appBar: CustomAppBar(
              context,
              elevation: 0,
              onTap: () => CommonRouter.pop(),
              titleWidget: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(state.listOfMessage[widget.index].profileImage),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        text: state.listOfMessage[widget.index].userName,
                        fontSize: 15.sp,
                        color: const Color(0xff293847),
                      ),
                      CommonWidget.commonText(
                        text: "Online",
                        color: const Color(0xff293847).withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () => makePhoneCall(phoneNumber: state.listOfMessage[widget.index].mobileNo),
                child: CommonWidget.commonSvgIconButton(
                  svgPicturePath: "assets/photos/svg/chat/call.svg",
                ),
              ),
            ),
            backgroundColor: const Color(0xffEDF6FF),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatCubit.scrollController,
                    itemCount: state.listOfMessage[widget.index].listOfMessage!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(15.h),
                        child: state.listOfMessage[widget.index].listOfMessage![index].sendMessage == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      state.listOfMessage[widget.index].listOfMessage![index].message
                                                  .endsWith(".jpg") ||
                                              state.listOfMessage[widget.index].listOfMessage![index].message
                                                  .endsWith(".png")
                                          ? SizedBox(
                                              height: 150.h,
                                              width: 200.w,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10.sp),
                                                  topRight: Radius.circular(10.sp),
                                                  topLeft: Radius.circular(10.sp),
                                                ),
                                                child: Image.file(
                                                  fit: BoxFit.cover,
                                                  File(state.listOfMessage[widget.index].listOfMessage![index].message),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xff084277),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10.sp),
                                                  topLeft: Radius.circular(10.sp),
                                                  topRight: Radius.circular(10.sp),
                                                ),
                                              ),
                                              constraints: BoxConstraints(
                                                maxWidth: 250.w,
                                              ),
                                              padding: EdgeInsets.all(10.h),
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                                state.listOfMessage[widget.index].listOfMessage![index].message,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                      Text(
                                        state.listOfMessage[widget.index].listOfMessage![index].time,
                                        style: TextStyle(
                                          color: const Color(0xff293847).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: CommonWidget.imageBuilder(
                                      height: 50.h,
                                      width: 50.w,
                                      imageUrl: state.listOfMessage[widget.index].listOfMessage![index].profileImage,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      state.listOfMessage[widget.index].listOfMessage![index].message.isEmpty
                                          ? SizedBox(
                                              height: 100.h,
                                              width: 100.w,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5,
                                                    spreadRadius: 1,
                                                    offset: const Offset(0, 0),
                                                    color: const Color(0xff084277).withOpacity(0.1),
                                                  ),
                                                ],
                                                color: const Color(0xffffffff),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10.sp),
                                                  topRight: Radius.circular(10.sp),
                                                  bottomRight: Radius.circular(10.sp),
                                                ),
                                              ),
                                              constraints: BoxConstraints(
                                                maxWidth: 250.w,
                                              ),
                                              padding: EdgeInsets.all(10.h),
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                                state.listOfMessage[widget.index].listOfMessage![index].message,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(34, 34, 34, 1),
                                                ),
                                              ),
                                            ),
                                      Text(
                                        state.listOfMessage[widget.index].listOfMessage![index].time,
                                        style: TextStyle(
                                          color: const Color(0xff293847).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ),
                sendMessageTextFiled(chatState: state),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> scrollDown() async {
    await chatCubit.scrollController.animateTo(
      chatCubit.scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget sendMessageTextFiled({required ChatLoadedState chatState}) {
    return CommonWidget.container(
      padding: EdgeInsets.all(10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CommonWidget.container(
              height: 50.h,
              alignment: Alignment.center,
              child: TextField(
                controller: chatCubit.txtSendMessageController,
                onChanged: (value) {
                  chatCubit.hideShowSendButton(data: value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: "",
                  hintText: TranslationConstants.type_a_message.translate(context),
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff293847),
                  ),
                  prefixIcon: SizedBox(
                    width: 70.w,
                    child: Padding(
                      padding: EdgeInsets.all(8.h),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                chatCubit.pickFileForMobile(
                                  index: widget.index,
                                  context: context,
                                  state: chatState,
                                );
                                scrollDown();
                              },
                              child: CommonWidget.imageBuilder(
                                imageUrl: "assets/photos/svg/chat/attach.svg",
                                height: 23.h,
                                width: 23.w,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            VerticalDivider(color: const Color(0xff293847).withOpacity(0.4), thickness: 2.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.streetAddress,
                onTap: () => scrollDown(),
              ),
            ),
          ),
          BlocBuilder<ToggleCubit, bool>(
            bloc: chatCubit.toggleCubit,
            builder: (context, state) {
              return Visibility(
                visible: state,
                child: GestureDetector(
                  onTap: () {
                    chatCubit.addData(
                      message: chatCubit.txtSendMessageController.text,
                      state: chatState,
                      index: widget.index,
                    );
                    chatCubit.txtSendMessageController.clear();
                    scrollDown();
                  },
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    alignment: Alignment.center,
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/chat/send.svg",
                      height: 25.h,
                      width: 25.w,
                      color: const Color(0xff084277),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
