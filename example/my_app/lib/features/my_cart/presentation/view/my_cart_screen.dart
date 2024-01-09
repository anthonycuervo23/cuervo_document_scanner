import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/view/my_cart_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/without_login_screen/without_login_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});
  @override
  State<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends MyCartWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      body: userToken == null
          ? const WithoutLoginScreen(isApplyAppbar: false)
          : BlocBuilder<CartCubit, CartState>(
              bloc: cartCubit,
              builder: (context, state) {
                if (state is CartLoadedState) {
                  if (myCartEntity != null) {
                    return myCartEntity?.cart.isNotEmpty == true
                        ? ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              CommonWidget.sizedBox(height: 12),
                              cartItems(state: state),
                              addMoreItem(state: state),
                              addCookingInstruction(state: state),
                              couponsandoffer(state: state),
                              deliverytimeslot(state: state),
                              billDetails(state: state),
                              cancellationPolicy(state: state),
                              state.nevigateToDrawer == RoutineOrder.cart
                                  ? proceedButton(context: context, state: state)
                                  : proceedButton(context: context, state: state),
                            ],
                          )
                        : CommonWidget.dataNotFound(
                            context: context,
                            bgColor: appConstants.greyBackgroundColor,
                            actionButton: const SizedBox.shrink(),
                          );
                  }
                } else if (state is CartLoadingState) {
                  return CommonWidget.loadingIos();
                } else if (state is CartErrorState) {
                  return Center(child: CommonWidget.commonText(text: state.errorMessage));
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }
}
