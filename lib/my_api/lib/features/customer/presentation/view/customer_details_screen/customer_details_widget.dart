import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/product_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/create_customer_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/handle_location_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_view_cubit/customer_view_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/customer_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CustomerDetailsWidget extends State<CustomerDetailScreen> {
  late CustomerDetailModel customerDetailModel;
  late CustomerViewCubit customerViewCubit;
  @override
  void initState() {
    super.initState();
    customerDetailModel = widget.customerDetailModel;
    customerViewCubit = getItInstance<CustomerViewCubit>();
    customerViewCubit.addList(orderList: customerDetailModel.orders, addressList: customerDetailModel.address);
  }

  @override
  void dispose() {
    super.dispose();
    customerViewCubit.close();
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      context,
      onTap: () => CommonRouter.pop(),
      trailing: editAndDeleteButton(context),
    );
  }

  Widget editAndDeleteButton(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => CommonRouter.pushNamed(
            RouteList.create_customer_screen,
            arguments: CreateCustomerArgs(
              navigate: CreateNewNavigate.customer,
              customerModel: customerDetailModel,
              isForEdit: true,
            ),
          ),
          child: CommonWidget.commonText(
            text: TranslationConstants.edit.translate(context),
            color: appConstants.editbuttonColor,
            fontSize: 16,
          ),
        ),
        CommonWidget.sizedBox(width: 15),
        InkWell(
          onTap: () => CommonWidget.showAlertDialog(
              context: context,
              onTap: () {
                customerViewCubit.deleteCustomer(customerDetailModel: customerDetailModel);
                CommonRouter.pop();
                CommonRouter.pushReplacementNamed(RouteList.customer_list_screen);
              },
              titleText: TranslationConstants.confirm_delete.translate(context),
              isTitle: true,
              text: TranslationConstants.sure_delete_customer.translate(context),
              maxLines: 2,
              leftColor: appConstants.theme1Color,
              leftTextColor: appConstants.white,
              titleTextStyle: TextStyle(color: appConstants.theme1Color, fontWeight: FontWeight.bold)),
          child: CommonWidget.commonText(
            text: TranslationConstants.delete.translate(context),
            color: appConstants.deletebuttonColor,
            fontSize: 16,
          ),
        ),
        CommonWidget.sizedBox(width: 15),
      ],
    );
  }

  Widget customeDetails({required CustomerDetailModel customerDetailModel}) {
    return CommonWidget.container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: customerDetailModel.name,
                style: Theme.of(context).textTheme.subTitle3MediumHeading.copyWith(color: appConstants.textColor),
              ),
              CommonWidget.sizedBox(height: 2),
              CommonWidget.commonText(
                text: customerDetailModel.emailAddress,
                style: Theme.of(context).textTheme.caption1LightHeading.copyWith(color: appConstants.black26),
              ),
              CommonWidget.commonText(
                text: "+91 ${customerDetailModel.mobileNumber}",
                style: Theme.of(context).textTheme.caption1LightHeading.copyWith(color: appConstants.black26),
              ),
              Visibility(
                visible: true,
                child: CommonWidget.commonText(
                  text: TranslationConstants.new_customer.translate(context),
                  style: Theme.of(context).textTheme.caption1MediumHeading.copyWith(
                        color: appConstants.editbuttonColor,
                      ),
                ),
              ),
            ],
          ),
          balanceOrdate(customerDetailModel)
        ],
      ),
    );
  }

  Widget balanceOrdate(CustomerDetailModel customerDetailModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: customerDetailModel.date,
          style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.black26),
        ),
        CommonWidget.sizedBox(height: 13),
        CommonWidget.container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          isBorder: true,
          borderColor: appConstants.theme5Color,
          borderWidth: 2.w,
          borderRadius: 10.r,
          child: CommonWidget.commonText(
            text: customerDetailModel.balance.formatCurrency(),
            style: Theme.of(context).textTheme.subTitle3MediumHeading.copyWith(color: appConstants.theme1Color),
          ),
        ),
        CommonWidget.sizedBox(height: 3),
        CommonWidget.commonText(
          text: TranslationConstants.balance.translate(context),
          style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.black26),
        ),
      ],
    );
  }

  Widget tabbar({required CustomerViewLoadedState state, required CustomerViewCubit customerViewCubit}) {
    return TabBar(
      indicatorColor: appConstants.editbuttonColor,
      dividerColor: appConstants.black12,
      onTap: (value) {
        customerViewCubit.changeTab(tabValue: value);
      },
      tabs: [
        commonTabView(index: 0, state: state, tabName: TranslationConstants.basic_details.translate(context)),
        commonTabView(index: 1, state: state, tabName: TranslationConstants.order.translate(context)),
        commonTabView(index: 2, state: state, tabName: TranslationConstants.shipping_add.translate(context)),
      ],
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  Tab commonTabView({required CustomerViewLoadedState state, required int index, required String tabName}) {
    return Tab(
      child: CommonWidget.commonText(
        text: tabName,
        style: state.selectedTabBar == index
            ? Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.editbuttonColor)
            : Theme.of(context).textTheme.body2BookHeading.copyWith(color: appConstants.black26),
      ),
    );
  }

  Widget bottombar({required CustomerViewCubit customerViewCubit}) {
    return BlocBuilder<CustomerViewCubit, CustomerViewState>(
      bloc: customerViewCubit,
      builder: (context, state) {
        if (state is CustomerViewLoadedState) {
          return Visibility(
            visible: state.selectedTabBar != 0,
            child: CommonWidget.container(
              height: 65,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  if (state.selectedTabBar == 1) {
                    CommonRouter.pushNamed(
                      RouteList.product_screen,
                      arguments: ProductScreenArgs(
                        openeingOrderScreenFrom: OpeneingOrderScreenFrom.customerDetails,
                        displayAppBar: true,
                        customerDetailModel: customerDetailModel,
                      ),
                    );
                  } else if (state.selectedTabBar == 2) {
                    AddressData? address = (await CommonRouter.pushNamed(
                      RouteList.handle_location_screen,
                      arguments: const HandleLocationArgs(
                        navigateFrom: CheckLoactionNavigation.addAddress,
                      ),
                    ) as AddressData?);
                    if (address != null) {
                      customerViewCubit.addAddress(address: address, state: state);
                    }
                  } else {
                    CustomSnackbar.show(
                      snackbarType: SnackbarType.SUCCESS,
                      message: TranslationConstants.add_address.translate(context),
                    );
                  }
                },
                child: CommonWidget.container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    borderRadius: 10.r,
                    color: appConstants.themeColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: 'assets/photos/svg/common/add_icon.svg',
                          height: 15.h,
                        ),
                        CommonWidget.sizedBox(width: 7),
                        CommonWidget.commonText(
                          text: state.selectedTabBar == 1
                              ? TranslationConstants.new_order.translate(context).toCamelcase()
                              : TranslationConstants.add_address.translate(context),
                          style: Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.white),
                        ),
                      ],
                    )),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
