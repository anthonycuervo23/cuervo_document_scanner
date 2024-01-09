import 'dart:ui';
import 'package:bakery_shop_admin_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/app_home/app_home_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/drawer/drawer_view.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends AppHomeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appConstants.homeBackgroundColor,
          drawerScrimColor: appConstants.black12,
          
          endDrawerEnableOpenDragGesture: false,
          appBar: appBar(state: state),
          drawer: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: const SizedBox.expand(),
              ),
              drawer(context: context),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(237, 246, 255, 0.6),
                  Color.fromRGBO(221, 238, 255, 0.6),
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: IndexedStack(index: state, children: screen),
          ),
          bottomNavigationBar: bottomBar(state: state),
        );
      },
    );
  }
}
