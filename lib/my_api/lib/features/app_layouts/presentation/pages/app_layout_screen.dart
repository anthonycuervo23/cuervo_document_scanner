import 'package:bakery_shop_admin_flutter/core/build_context.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/cubit/app_layouts_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/pages/app_layout_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLayoutsScreen extends StatefulWidget {
  const AppLayoutsScreen({super.key});

  @override
  State<AppLayoutsScreen> createState() => _AppLayoutsScreenState();
}

class _AppLayoutsScreenState extends AppLayoutWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(buildContext);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: BlocBuilder<AppLayoutsCubit, AppLayoutsState>(
          bloc: appLayoutsCubit,
          builder: (context, state) {
            if (state is AppLayoutsLoadedState) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: appBar(context, state: state),
                  body: SingleChildScrollView(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          uploadLogo(state: state),
                          imageList(),
                          themeMode(),
                          themeColor(state: state),
                          fontFamilyDropDown(),
                          buttonStyle(state: state),
                          CommonWidget.sizedBox(height: 20),
                        ],
                      ),
                    ),
                  ));
            } else if (state is AppLayoutsLoadingState) {
              const Center(child: CircularProgressIndicator());
            } else if (state is AppLayoutsErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
