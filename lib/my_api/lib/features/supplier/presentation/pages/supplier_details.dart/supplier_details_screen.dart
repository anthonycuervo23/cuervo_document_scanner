import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/suplier_details_cubit/supplierdetails_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_details.dart/supplier_details_Widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierDetailsScreen extends StatefulWidget {
  final SupplierDetailModel supplierDetailModel;
  const SupplierDetailsScreen({super.key, required this.supplierDetailModel});

  @override
  State<SupplierDetailsScreen> createState() => _SupplierDetailsScreenState();
}

class _SupplierDetailsScreenState extends SupplierDetailsWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: appConstants.backGroundColor,
          appBar: CustomAppBar(
            context,
            onTap: () => CommonRouter.pop(),
            trailing: Row(
              children: [
                InkWell(
                  onTap: () => CommonRouter.pushNamed(RouteList.create_new_screen, arguments: {
                    "Navigate": CreateNewNavigate.supplier,
                    "supplierModel": widget.supplierDetailModel,
                  }),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.edit.translate(context),
                    color: appConstants.editbuttonColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 15.h),
                InkWell(
                  onTap: () {
                    supplierdetailsCubit.deleteSupplier(supplierDetailModel: widget.supplierDetailModel);
                  },
                  child: CommonWidget.commonText(
                    text: TranslationConstants.delete.translate(context),
                    color: appConstants.deletebuttonColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 15.h),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: CommonWidget.container(
              color: appConstants.backGroundColor,
              child: BlocBuilder<SupplierdetailsCubit, SupplierdetailsState>(
                bloc: supplierdetailsCubit,
                builder: (context, state) {
                  if (state is SupplierDetailsLoadedState) {
                    return Column(
                      children: [
                        supplierBasic(supplierDetailModel: widget.supplierDetailModel),
                        tabbar(state: state, supplierdetailsCubit: supplierdetailsCubit),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              firstTab(supplierDetailModel: widget.supplierDetailModel),
                              secondTab(supplierDetailModel: widget.supplierDetailModel),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
