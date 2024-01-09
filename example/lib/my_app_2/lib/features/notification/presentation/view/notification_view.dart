import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/notification/data/models/notification_model.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/view/notification_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends NotificationWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => Navigator.pop(context),
        title: TranslationConstants.notification.translate(context),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        bloc: notificationCubit,
        builder: (context, state) {
          if (state is NotificationLoadedState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              child: ListView.builder(
                itemCount: state.notificationList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  NotificationModel notificationModel = state.notificationList[index];
                  return commonNotificationBox(index: index, state: state, notificationModel: notificationModel);
                },
              ),
            );
          } else if (state is NotificationLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is NotificationErrorState) {
            return CommonWidget.dataNotFound(
              context: context,
              heading: TranslationConstants.something_went_wrong.translate(context),
              subHeading: state.errorMessage,
              buttonLabel: TranslationConstants.try_again.translate(context),
              // onTap: () => productCategoryCubit.getCategory(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
