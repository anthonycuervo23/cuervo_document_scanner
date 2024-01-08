import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_view_cubit/customer_view_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/customer_details_widget.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/widgets/basic_details_tab.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/widgets/order_tab.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/widgets/shipping_address_tab.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerDetailScreen extends StatefulWidget {
  final CustomerDetailModel customerDetailModel;
  const CustomerDetailScreen({super.key, required this.customerDetailModel});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends CustomerDetailsWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: appConstants.backGroundColor,
          appBar: appBar(context),
          body: Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: CommonWidget.container(
              color: appConstants.transparent,
              child: BlocBuilder<CustomerViewCubit, CustomerViewState>(
                bloc: customerViewCubit,
                builder: (context, state) {
                  if (state is CustomerViewLoadedState) {
                    return Column(
                      children: [
                        customeDetails(customerDetailModel: customerDetailModel),
                        CommonWidget.container(
                            shadow: [], child: tabbar(customerViewCubit: customerViewCubit, state: state)),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              basicDetailsTab(customerDetailModel: customerDetailModel, context: context),
                              orderTab(customerViewCubit: customerViewCubit, state: state),
                              shippingAddressTab(
                                customerViewCubit: customerViewCubit,
                                state: state,
                                customerDetailModel: customerDetailModel,
                              ),
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
          bottomNavigationBar: bottombar(customerViewCubit: customerViewCubit),
        ),
      ),
    );
  }
}
