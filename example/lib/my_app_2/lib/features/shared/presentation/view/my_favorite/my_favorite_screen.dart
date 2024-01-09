import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/my_favorite/my_favorite_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_favorite/my_favorite_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends MyFavoriteWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.my_favorite.translate(context),
      ),
      body: BlocBuilder<MyFavoriteCubit, MyFavoriteState>(
        bloc: myFavoriteCubit,
        builder: (context, state) {
          if (state is MyFavoriteLoadedState) {
            return Column(
              children: [
                searchTextField(productData: state.productList, state: state),
                Expanded(
                  child: state.productList.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: state.productList.length,
                          itemBuilder: (context, index) {
                            var productData = state.productList[index];
                            return commonBoxList(productData: productData, state: state);
                          },
                        )
                      : CommonWidget.dataNotFound(
                          context: context,
                          bgColor: appConstants.greyBackgroundColor,
                          actionButton: const SizedBox.shrink(),
                        ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
