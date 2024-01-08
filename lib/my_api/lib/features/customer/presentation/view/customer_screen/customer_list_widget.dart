// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/create_customer_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_state.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_screen/customer_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/customer_abd_supplier_card_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/sort_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CustomerListWidget extends State<CustomerListScreen> {
  late CustomerCubit customerCubit;

  @override
  void initState() {
    customerCubit = getItInstance<CustomerCubit>();
    super.initState();
  }

  @override
  void dispose() {
    customerCubit.close();
    super.dispose();
  }

// app bar
  PreferredSizeWidget? appBar(BuildContext context, CustomerLoadedState state) {
    return CustomAppBar(
      titleCenter: false,
      context,
      title: TranslationConstants.customer.translate(context),
      onTap: () => CommonRouter.pop(),
      trailing: resetButton(state, context),
    );
  }

  Widget resetButton(CustomerLoadedState state, BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        customerCubit.reset(state: state);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: CommonWidget.commonText(
          text: TranslationConstants.reset.translate(context),
          color: appConstants.editbuttonColor,
        ),
      ),
    );
  }

// search and Filter Field
  Widget searchAndFilterField(CustomerLoadedState state, BuildContext context) {
    return commonSearchAndFilterField(
      controller: customerCubit.searchController,
      onChanged: (v) => customerCubit.filterForSearch(value: v, state: state),
      context: context,
      onTapForFilter: () => loadFilterDialog(context, state),
      onTapSearchCalenderButton: () => search(context, state),
    );
  }

// Custome View List
  Widget buildCustomerView(CustomerLoadedState state) {
    return (state.filterList != null && state.filterList!.isEmpty)
        ? CommonWidget.dataNotFound(
            context: context,
            bgColor: appConstants.backGroundColor,
            actionButton: const SizedBox.shrink(),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: state.filterList == null ? state.customerDetailList.length : state.filterList?.length,
            itemBuilder: (context, index) {
              CustomerDetailModel customerDetail = state.filterList?[index] ?? state.customerDetailList[index];
              return customerView(customerDetail, context);
            },
          );
  }

  Widget customerView(CustomerDetailModel customerDetail, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: customerAndSupplierListBox(
        onEditButtonTap: () => CommonRouter.pushNamed(
          RouteList.create_customer_screen,
          arguments: CreateCustomerArgs(
            navigate: CreateNewNavigate.customer,
            customerModel: customerDetail,
            isForEdit: true,
          ),
        ),
        details: loadCustomerCardDetails(customerDetail: customerDetail),
        context: context,
        onDeleteButtonTap: () {
          customerCubit.deleteCustomer(customerDetailModel: customerDetail);
          CommonRouter.pop();
        },
        onCardTap: () {
          CommonRouter.pushNamed(
            RouteList.customer_details_screen,
            arguments: customerDetail,
          );
        },
      ),
    );
  }

  CustomerAndSupplierCardModel loadCustomerCardDetails({required CustomerDetailModel customerDetail}) {
    return CustomerAndSupplierCardModel(
      name: customerDetail.name,
      mobileNumber: customerDetail.mobileNumber,
      orderAmount: customerDetail.totalOrderAmount.toString(),
      balanceAmount: customerDetail.balance.toString(),
      image: customerDetail.profileImage,
      date: customerDetail.date,
      balanceAmountType: customerDetail.balanceType,
      customerType: customerDetail.customerType,
      isPending: customerDetail.isPending,
    );
  }

// Add New Botton
  Widget addNewButton(BuildContext context) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(RouteList.create_customer_screen,
          arguments: const CreateCustomerArgs(navigate: CreateNewNavigate.customer, isForEdit: false)),
      child: CommonWidget.container(
        height: 45,
        width: newDeviceType == NewDeviceType.phone
            ? 180
            : newDeviceType == NewDeviceType.tablet
                ? ScreenUtil().screenWidth / 1.5
                : ScreenUtil().screenWidth / 1.2,
        color: appConstants.theme1Color,
        borderRadius: 10.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/customer/add_new.svg",
              height: 20.h,
            ),
            CommonWidget.sizedBox(width: 10),
            CommonWidget.commonText(
                text: TranslationConstants.add_new.translate(context),
                fontSize: 15,
                color: appConstants.white,
                fontWeight: FontWeight.w600)
          ],
        ),
      ),
    );
  }

// Method
  Future<void> search(BuildContext context, CustomerLoadedState state) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String value = (await searchFilterDialog(context: context, searchFilterCubit: customerCubit.searchFilterCubit)) ??
        TranslationConstants.all.translate(context);
    customerCubit.filterForDate(value: value, state: state);
  }

  void loadFilterDialog(BuildContext context, CustomerLoadedState state) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        FocusScope.of(context).unfocus();
        String value = await sortFilterDialog(
                context: context,
                counterCubit: customerCubit.counterCubit,
                sortFilterCubit: customerCubit.sortFilterCubit) ??
            TranslationConstants.all.translate(context);
        customerCubit.filterDataForFilterButton(value: value, state: state);
      },
    );
  }
}
