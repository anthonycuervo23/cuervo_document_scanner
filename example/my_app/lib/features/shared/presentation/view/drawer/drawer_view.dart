import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/drawer/drawer_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget drawer({required BuildContext context}) {
  return Drawer(
    backgroundColor: appConstants.default12Color,
    shape: const BeveledRectangleBorder(),
    elevation: 0,
    width: ScreenUtil().screenWidth * 0.82,
    child: Column(
      children: [
        CommonWidget.sizedBox(height: ScreenUtil().statusBarHeight),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: userToken != null
              ? BlocBuilder<GetUserDataCubit, GetUserDataState>(
                  bloc: BlocProvider.of<GetUserDataCubit>(context),
                  builder: (context, state) {
                    if (state is GerUserDataLoadedState) {
                      return withLogin(context: context, state: state);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              : withoutLogin(context: context),
        ),
        Divider(endIndent: 15, indent: 15, height: 5, color: appConstants.greyBackgroundColor),
        drawerItems(context: context),
      ],
    ),
  );
}
