import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/point_wise_color_btn/point_wise_color_btn_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/add_new_point_wise_color_btn/add_new_point_wise_color_btn_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewPointWiseColorBtnScreen extends StatefulWidget {
  const AddNewPointWiseColorBtnScreen({super.key});

  @override
  State<AddNewPointWiseColorBtnScreen> createState() => _AddNewPointWiseColorBtnScreenState();
}

class _AddNewPointWiseColorBtnScreenState extends AddNewPointWiseColorBtnWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointWiseColorBtnCubit, PointWiseColorBtnState>(
      bloc: pointWiseColorBtnCubit,
      builder: (context, state) {
        if (state is PointWiseColorBtnLoadedState) {
          return Scaffold(
            appBar: appBar(state: state),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextField(
                    textInputType: TextInputType.number,
                    titleText: TranslationConstants.minimum_point.translate(context),
                    hintText: TranslationConstants.enter_minimum_point.translate(context),
                    controller: pointWiseColorBtnCubit.minimumPointController,
                  ),
                  CommonWidget.sizedBox(height: 10),
                  commonTextField(
                    textInputType: TextInputType.number,
                    titleText: TranslationConstants.maximum_point.translate(context),
                    hintText: TranslationConstants.enter_maximum_point.translate(context),
                    controller: pointWiseColorBtnCubit.maximumPointController,
                  ),
                  CommonWidget.sizedBox(height: 10),
                  colorCode(state: state),
                  CommonWidget.sizedBox(height: 10),
                  status(),
                ],
              ),
            ),
            bottomNavigationBar: submitButton(state: state),
          );
        } else if (state is PointWiseColorBtnLoadingState) {
          const Center(child: CircularProgressIndicator());
        } else if (state is PointWiseColorBtnErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
