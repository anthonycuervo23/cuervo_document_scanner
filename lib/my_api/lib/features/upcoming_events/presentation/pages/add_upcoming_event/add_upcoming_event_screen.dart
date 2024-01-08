import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/data/models/upcoming_events_model.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/cubit/upcoming_events_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUpcomingEventScreen extends StatefulWidget {
  final UpcomingEventsModel model;
  const AddUpcomingEventScreen({super.key, required this.model});

  @override
  State<AddUpcomingEventScreen> createState() => _AddUpcomingEventScreenState();
}

class _AddUpcomingEventScreenState extends State<AddUpcomingEventScreen> {
  late UpcomingEventsCubit upcomingEventsCubit;

  @override
  void initState() {
    upcomingEventsCubit = getItInstance<UpcomingEventsCubit>();
    if (widget.model.eventName.isNotEmpty) {
      upcomingEventsCubit.fillTextFieldData(model: widget.model);
    }
    super.initState();
  }

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: key,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            context,
            textColor: appConstants.neutral1Color,
            title: widget.model.eventName.isEmpty
                ? TranslationConstants.add_event.translate(context)
                : TranslationConstants.update_event.translate(context),
            titleCenter: false,
            onTap: () {
              CommonRouter.pop();
              upcomingEventsCubit.eventNameController.clear();
              upcomingEventsCubit.eventInfoController.clear();
              upcomingEventsCubit.eventDateController.clear();
            },
          ),
          body: Column(
            children: [
              Divider(color: appConstants.dividerColor),
              Expanded(
                child: BlocBuilder<UpcomingEventsCubit, UpcomingEventsState>(
                  bloc: upcomingEventsCubit,
                  builder: (context, state) {
                    if (state is UpcomingEventsLoadedState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.enter_event_name.translate(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            CommonWidget.sizedBox(height: 5),
                            TextFormField(
                              validator: (v) {
                                if (v!.isNotEmpty) {
                                  return null;
                                }
                                return TranslationConstants.enter_event_name_error.translate(context);
                              },
                              controller: upcomingEventsCubit.eventNameController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.red),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                fillColor: appConstants.white,
                                hintText: TranslationConstants.enter_event_name_hint.translate(context),
                                hintStyle: TextStyle(
                                  color: const Color(0xff8EA3B9).withOpacity(0.6),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            CommonWidget.sizedBox(height: 10),
                            CommonWidget.commonText(
                              text: TranslationConstants.enter_event_information.translate(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            CommonWidget.sizedBox(height: 5),
                            TextFormField(
                              controller: upcomingEventsCubit.eventInfoController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                fillColor: appConstants.white,
                                hintText: TranslationConstants.enter_event_information_hint.translate(context),
                                hintStyle: TextStyle(
                                  color: const Color(0xff8EA3B9).withOpacity(0.6),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            CommonWidget.sizedBox(height: 10),
                            CommonWidget.commonText(
                              text: TranslationConstants.enter_event_date.translate(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            CommonWidget.sizedBox(height: 5),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () async {
                                List<DateTime?> date = await CommonWidget.datePicker(
                                      context: context,
                                    ) ??
                                    [];
                                if (date.isNotEmpty) {
                                  if (date[0]!.day < 10) {
                                    upcomingEventsCubit.dateChanage(
                                      date: "0${date[0]!.day}-${date[0]!.month}-${date[0]!.year}",
                                      state: state,
                                    );
                                  } else {
                                    upcomingEventsCubit.dateChanage(
                                      date: "${date[0]!.day}-${date[0]!.month}-${date[0]!.year}",
                                      state: state,
                                    );
                                  }
                                }
                              },
                              child: TextFormField(
                                validator: (v) {
                                  if (v!.isNotEmpty) {
                                    return null;
                                  }
                                  return TranslationConstants.enter_event_date_error.translate(context);
                                },
                                controller: upcomingEventsCubit.eventDateController,
                                style: TextStyle(color: appConstants.dateTextColor, fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                  enabled: false,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appConstants.themeColor),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appConstants.red),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appConstants.themeColor.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  fillColor: appConstants.white,
                                  hintText: TranslationConstants.enter_event_date_hint.translate(context),
                                  hintStyle: TextStyle(
                                    color: const Color(0xff8EA3B9).withOpacity(0.6),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  suffixIcon: Container(
                                    height: 30.h,
                                    width: 30.w,
                                    alignment: Alignment.center,
                                    child: CommonWidget.imageBuilder(
                                      imageUrl: "assets/photos/svg/common/calenders.svg",
                                      color: appConstants.neutral6Color,
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            CommonWidget.commonButton(
                              text: widget.model.eventName.isEmpty
                                  ? TranslationConstants.add_event.translate(context)
                                  : TranslationConstants.update_event.translate(context),
                              context: context,
                              onTap: () {
                                if (key.currentState!.validate()) {
                                  if (widget.model.eventName.isEmpty) {
                                    UpcomingEventsModel model = UpcomingEventsModel(
                                      eventName: upcomingEventsCubit.eventNameController.text,
                                      eventInformation: upcomingEventsCubit.eventInfoController.text,
                                      eventDate: upcomingEventsCubit.eventDateController.text,
                                    );
                                    upcomingEventsCubit.addEvent(model: model, state: state);
                                  } else {
                                    UpcomingEventsModel model = UpcomingEventsModel(
                                      eventName: upcomingEventsCubit.eventNameController.text,
                                      eventInformation: upcomingEventsCubit.eventInfoController.text,
                                      eventDate: upcomingEventsCubit.eventDateController.text,
                                      index: widget.model.index,
                                    );
                                    upcomingEventsCubit.updateEvent(model: model, state: state);
                                  }
                                  CommonRouter.pop();
                                  upcomingEventsCubit.eventNameController.clear();
                                  upcomingEventsCubit.eventInfoController.clear();
                                  upcomingEventsCubit.eventDateController.clear();
                                }
                              },
                              alignment: Alignment.center,
                              height: 50.h,
                              textColor: appConstants.white,
                              width: ScreenUtil().screenWidth,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
