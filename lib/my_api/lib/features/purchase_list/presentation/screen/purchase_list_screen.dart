import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/data/models/purchase_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/screen/purchase_list_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseListScreen extends StatefulWidget {
  const PurchaseListScreen({super.key});

  @override
  State<PurchaseListScreen> createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends PurchaseListWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(context,
            onTap: () => CommonRouter.pop(),
            titleCenter: false,
            title: TranslationConstants.purchase_list.translate(context)),
        backgroundColor: appConstants.backGroundColor,
        body: BlocBuilder<PurchaseListCubit, PurchaseListState>(
          bloc: purchseListCubit,
          builder: (context, state) {
            if (state is PurchaseListLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: searchField(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.purchaseListModel.length,
                      itemBuilder: (context, index) {
                        PurchaseModel data = purchaseList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: commonOrderBox(
                            index: index,
                            purchaseModel: data,
                            state: state,
                            onTap: () {
                              purchseListCubit.deletePurchase(
                                purchaseModel: data,
                              );
                              CommonRouter.pop();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: addPurchaseButton(),
      ),
    );
  }
}
