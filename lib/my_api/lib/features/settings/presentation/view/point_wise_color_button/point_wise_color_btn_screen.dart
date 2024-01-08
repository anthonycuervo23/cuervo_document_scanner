import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/point_wise_color_btn/point_wise_color_btn_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/point_wise_color_btn_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointWiseColorBtnScreen extends StatefulWidget {
  const PointWiseColorBtnScreen({super.key});

  @override
  State<PointWiseColorBtnScreen> createState() => _PointWiseColorBtnScreenState();
}

class _PointWiseColorBtnScreenState extends PointWiseColorBtnWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointWiseColorBtnCubit, PointWiseColorBtnState>(
      bloc: pointWiseColorBtnCubit,
      builder: (context, state) {
        if (state is PointWiseColorBtnLoadedState) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar(),
            body: Column(
              children: [
                listTitle(),
                CommonWidget.sizedBox(height: 5.0),
                Expanded(
                  child: listOfAreaWithPincode(state: state),
                ),
              ],
            ),
            bottomNavigationBar: addNewButton(state: state),
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
