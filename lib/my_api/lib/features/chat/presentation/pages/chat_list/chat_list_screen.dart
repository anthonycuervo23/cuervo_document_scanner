import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ChatCubit chatCubit;
  late PickImageCubit pickImageCubitCubit;

  @override
  void initState() {
    chatCubit = getItInstance<ChatCubit>();
    pickImageCubitCubit = getItInstance<PickImageCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<ChatCubit, ChatState>(
          bloc: chatCubit,
          builder: (context, state) {
            if (state is ChatLoadedState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: TextField(
                      onChanged: (v) => chatCubit.filterForSearch(state: state, value: v),
                      controller: chatCubit.searchController,
                      cursorColor: const Color(0xff4392F1),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: newDeviceType == NewDeviceType.phone
                              ? const EdgeInsets.all(15)
                              : newDeviceType == NewDeviceType.tablet
                                  ? const EdgeInsets.all(10)
                                  : const EdgeInsets.all(10),
                          child: CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/customer/search.svg",
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        hintText: TranslationConstants.search_here.translate(context),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Color(0xffD3E8FF),
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Color(0xffD3E8FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Color(0xffD3E8FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Color(0xff4392F1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listOfMessage.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () => CommonRouter.pushNamed(
                            RouteList.chat_screen,
                            arguments: index,
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70.h,
                                  width: 70.w,
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 50.r,
                                    backgroundImage: AssetImage(state.listOfMessage[index].profileImage),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 70.h,
                                    decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color(0xffDFDFDF))),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CommonWidget.commonText(
                                              text: state.listOfMessage[index].userName.toCamelcase(),
                                              fontSize: 14.sp,
                                              color: const Color(0xff293847),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().screenWidth * 0.55,
                                              child: CommonWidget.commonText(
                                                text: state.listOfMessage[index].lastMessage,
                                                fontSize: 13.sp,
                                                color: state.listOfMessage[index].isLastMessage
                                                    ? const Color(0xff293847)
                                                    : const Color(0xff293847).withOpacity(0.4),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CommonWidget.commonText(
                                              text: state.listOfMessage[index].time,
                                              fontSize: 12.sp,
                                              color: const Color(0xff293847).withOpacity(0.6),
                                            ),
                                            Visibility(
                                              visible: state.listOfMessage[index].isLastMessage,
                                              child: Container(
                                                height: 25.h,
                                                width: 25.w,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff4392F1),
                                                ),
                                                alignment: Alignment.center,
                                                child: CommonWidget.commonText(
                                                  text: "1",
                                                  color: const Color(0xffFFFFFF),
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
