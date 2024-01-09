import 'package:bakery_shop_flutter/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/home_screen/home_widget.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenWidget {
  @override
  Widget build(BuildContext context) {
    return CommonWidget.gestureHideKeyboard(
      context,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return Container(
                color: appConstants.greyBackgroundColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.sizedBox(height: 10),
                      textFeildView(context: context),
                      slider(state: state),
                      category(state: state),
                      // banners(state: state),
                      // bestproducts(),
                      // trendingproduct(),
                      CommonWidget.sizedBox(height: 10),
                    ],
                  ),
                ),
              );
            } else if (state is HomeLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is HomeErrorState) {
              return Center(child: CommonWidget.commonText(text: state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
