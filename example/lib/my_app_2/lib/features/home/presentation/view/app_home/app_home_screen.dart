import 'dart:io';
import 'dart:ui';

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/app_home/app_home_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/drawer/drawer_view.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends AppHomeWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final NavigatorState navigator = Navigator.of(context);

        var result = await CommonWidget.showAlertDialog(
          context: context,
          isTitle: true,
          titleText: TranslationConstants.exit_title.translate(context),
          text: TranslationConstants.exit_msg.translate(context),
        );
        if (result) {
          if (Platform.isAndroid) {
            // bakeryBox.clear();
            // appLanBox.clear();
            // userLanBox.clear();
            // currentLanBox.clear();
            // userDataBox.clear();
            generalSettingBox.clear();
            appActivityAnaltics.clear();

            navigator.popUntil((route) => route.isFirst);
            SystemNavigator.pop();
          } else {
            navigator.popUntil((route) => route.isFirst);
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appConstants.whiteBackgroundColor,
        // key: scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        appBar: appBar(),
        drawer: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: const SizedBox.expand(),
            ),
            drawer(context: context)
            // BlocBuilder<UserDataLoadCubit, UserDataLoadState>(
            //   bloc: userDataLoadCubit,
            //   builder: (context, state) {
            //     if (state is UserDataLoadLoadedState) {
            //       return drawer(context: context, state: state);
            //     } else if (state is UserDataLoadLoadingState) {
            //       return Center(child: CommonWidget.loadingIos());
            //     } else if (state is UserDataLoadErrorState) {
            //  return CommonWidget.dataNotFound(
            //           context: context,
            //           heading: TranslationConstants.something_went_wrong.translate(context),
            //           subHeading: state.errorMessage,
            //           buttonLabel: TranslationConstants.try_again.translate(context),
            //           // onTap: () => productCategoryCubit.getCategory(),
            //         );
            //     } else {
            //       return drawer(context: context);
            //     }
            //   },
            // ),
          ],
        ),
        // drawer: drawer(context: context),
        body: BlocBuilder<BottomNavigationCubit, int>(
          bloc: bottomNavigationCubit,
          builder: (context, state) {
            return IndexedStack(index: state, children: screen);
          },
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}
