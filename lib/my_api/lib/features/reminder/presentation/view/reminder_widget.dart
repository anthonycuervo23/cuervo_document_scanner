import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/view/reminder_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ReminderWidget extends State<ReminderScreen> {
  late ReminderCubit reminderCubit;
  late ReminderType reminderType;

  @override
  void initState() {
    super.initState();
    reminderCubit = getItInstance<ReminderCubit>();
    reminderType = widget.reminderType;
    reminderCubit.loadData(reminderType: reminderType);
  }

  Widget commonBox({required ReminderLoadedState state, required int index}) {
    return CommonWidget.container(
      margin: EdgeInsets.only(bottom: 10.h),
      borderRadius: 10.r,
      padding: EdgeInsets.all(10.h),
      shadow: [
        BoxShadow(
          color: appConstants.shadowColor1,
          blurRadius: 10,
          offset: const Offset(0, 6),
          spreadRadius: 0,
        )
      ],
      child: Row(
        children: [
          idAndIcon(index: index),
          SizedBox(width: 20.w),
          details(state: state, index: index),
          const Spacer(),
          Visibility(
            visible: (reminderType == ReminderType.birthday || reminderType == ReminderType.anniversary),
            child: iconsTap(state: state, index: index),
          )
        ],
      ),
    );
  }

  Widget idAndIcon({required int index}) {
    return Column(
      children: [
        Text(
          "#${index + 1}",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        CommonWidget.sizedBox(height: 10.h),
        CommonWidget.imageBuilder(
          imageUrl: (reminderType == ReminderType.birthday)
              ? 'assets/photos/svg/reminder_screen/birthday.svg'
              : 'assets/photos/svg/reminder_screen/event.svg',
          width: 20.w,
          color: appConstants.neutral12Color,
        ),
      ],
    );
  }

  Widget details({required ReminderLoadedState state, required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          (reminderType == ReminderType.birthday)
              ? state.birthdayDataList![index].name
              : (reminderType == ReminderType.anniversary)
                  ? state.anniversoryDataList![index].name
                  : state.eventsDataList![index].name,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        CommonWidget.sizedBox(height: 3),
        Visibility(
          visible: ((reminderType == ReminderType.birthday)
                  ? "Mobile No: ${state.birthdayDataList![index].mobile}"
                  : (reminderType == ReminderType.anniversary)
                      ? "Mobile No: ${state.anniversoryDataList![index].mobile}"
                      : '') !=
              '',
          child: Text(
            (reminderType == ReminderType.birthday)
                ? "Mobile No: ${state.birthdayDataList![index].mobile}"
                : (reminderType == ReminderType.anniversary)
                    ? "Mobile No: ${state.anniversoryDataList![index].mobile}"
                    : "",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: appConstants.lightGrey,
            ),
          ),
        ),
        CommonWidget.sizedBox(height: 7),
        Row(
          children: [
            Text(
              '${(reminderType == ReminderType.birthday) ? state.birthdayDataList![index].dob : (reminderType == ReminderType.anniversary) ? state.anniversoryDataList![index].anniversaryDate : state.eventsDataList![index].eventDate} : ',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              reminderType.name.toCamelcase(),
              style: TextStyle(
                fontSize: 10.sp,
                color: appConstants.editbuttonColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget iconsTap({required ReminderLoadedState state, required int index}) {
    String phoneNumber = "";

    if (reminderType == ReminderType.birthday) {
      phoneNumber = state.birthdayDataList![index].mobile;
    } else if (reminderType == ReminderType.anniversary) {
      phoneNumber = state.anniversoryDataList![index].mobile;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => reminderCubit.call(phoneNo: phoneNumber),
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/reminder_screen/call.svg",
                height: 32.h,
              ),
            ),
            CommonWidget.sizedBox(width: 10),
            InkWell(
              onTap: () => reminderCubit.whatsapp(phoneNo: phoneNumber),
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/reminder_screen/wp.svg",
                height: 32.h,
              ),
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 10),
        CommonWidget.container(
          color: const Color.fromRGBO(41, 56, 71, 0.1),
          borderRadius: 10.r,
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
          child: CommonWidget.commonText(
            text: TranslationConstants.message_informed.translate(context),
            fontSize: 9.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
