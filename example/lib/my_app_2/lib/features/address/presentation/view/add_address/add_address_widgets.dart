import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/add_address/my_self_widget.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/add_address/someone_else_widgets.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/add_address/add_address_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TabBarValue { home, someoneelse }

abstract class AddAddressWidget extends State<AddAddressScreen> {
  // late AddAddressCubit addAddressCubit;
  int selectedTab = 0;
  late AddressScreenArguments addressData;
  GlobalKey<FormState> textFieldKey = GlobalKey<FormState>();

  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController flatNoController = TextEditingController();
  TextEditingController naerbyLandmarkController = TextEditingController();

  @override
  void initState() {
    addressData = widget.addressData;
    // addAddressCubit = BlocProvider.of<AddAddressCubit>(context);
    initialDataSet();
    super.initState();
  }

  void initialDataSet() {
    if (addressData.isNew) {
      addAddressCubit.inilizeAddressField();
      addressController.text = addressData.fullAddress;
      addAddressCubit.fullAddress = addressData.fullAddress;
      addAddressCubit.args = addressData;
      addAddressCubit.setData(latitude: addressData.latitude, longitude: addressData.longitude);
    } else {
      flatNoController.text = addressData.floatNo ?? '';
      addressController.text = addressData.fullAddress;
      naerbyLandmarkController.text = addressData.landmark ?? '';
      addAddressCubit.cityName = addressData.cityName ?? '';
      addAddressCubit.stateName = addressData.stateName ?? '';
      addAddressCubit.countryName = addressData.countryName ?? '';
      addAddressCubit.pinCode = addressData.pinCode ?? '';
      addAddressCubit.fullAddress = addressData.fullAddress;
      addAddressCubit.args = addressData;

      AddAddressType addAddressType = AddAddressType.values.firstWhere(
        (element) => element.name == addressData.addresstype?.replaceAll(' ', '_'),
      );

      if (addAddressType == AddAddressType.someone_Else) {
        selectedTab = 1;
        contactNameController.text = addressData.name ?? '';
        contactNumberController.text = addressData.mobile ?? '';
      }
      addAddressCubit.inilizeAddressField(addAddressType: addAddressType);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cleanData();
    addAddressCubit.loadingCubit.hide();
  }

  void cleanData() {
    addAddressCubit.cityName = '';
    addAddressCubit.cityName = '';
    addAddressCubit.stateName = '';
    addAddressCubit.countryName = '';
    addAddressCubit.fullAddress = '';
    addAddressCubit.pinCode = '';
    contactNameController.clear();
    contactNumberController.clear();
    addressController.clear();
    flatNoController.clear();
    naerbyLandmarkController.clear();
    addAddressCubit.args.fullAddress = '';
    addAddressCubit.args.aeriaName = '';
  }

  Widget tabBar({required AddAddressLoadedState state}) {
    return DefaultTabController(
      length: TabBarValue.values.length,
      initialIndex: selectedTab,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            indicatorColor: appConstants.primary1Color,
            onTap: (index) {
              selectedTab = index;
              addAddressCubit.changeAddressType(
                state: state,
                orderAddressType: TabBarValue.values[index] == TabBarValue.home
                    ? OrderAddressType.home
                    : OrderAddressType.someoneElse,
                addAddressType: (TabBarValue.values[index] == TabBarValue.home && addressData.isNew)
                    ? AddAddressType.home
                    : (TabBarValue.values[index] == TabBarValue.someoneelse && addressData.isNew)
                        ? AddAddressType.other
                        : ((TabBarValue.values[index] == TabBarValue.home) &&
                                (AddAddressType.values.firstWhere(
                                      (element) => element.name == addressData.addresstype?.replaceAll(' ', '_'),
                                    )) ==
                                    AddAddressType.someone_Else)
                            ? AddAddressType.home
                            : AddAddressType.values.firstWhere(
                                (element) => element.name == addressData.addresstype?.replaceAll(' ', '_'),
                              ),
              );
            },
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: selectedTab == 0,
                      child: CommonWidget.imageBuilder(
                        height: 16.r,
                        imageUrl: "assets/photos/svg/tab_bar/tab_bar_tab_icon.svg",
                      ),
                    ),
                    CommonWidget.sizedBox(width: 10),
                    CommonWidget.commonText(
                      text: TranslationConstants.my_self.translate(context),
                      style: selectedTab == 0
                          ? Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.primary1Color)
                          : Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: selectedTab == 1,
                      child: CommonWidget.imageBuilder(
                        height: 16.r,
                        imageUrl: "assets/photos/svg/tab_bar/tab_bar_tab_icon.svg",
                      ),
                    ),
                    CommonWidget.sizedBox(width: 8),
                    CommonWidget.commonText(
                      text: TranslationConstants.someone_else.translate(context),
                      style: selectedTab == 1
                          ? Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.primary1Color)
                          : Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: appConstants.default7Color, height: 1),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  mySelfTab(
                    state: state,
                    context: context,
                    addAddressCubit: addAddressCubit,
                    addressData: addressData,
                    textFieldKey: textFieldKey,
                    addressController: addressController,
                    flatNoController: flatNoController,
                    naerbyLandmarkController: naerbyLandmarkController,
                    contactNameController: contactNameController,
                    contactNumberController: contactNumberController,
                  ),
                  someoneElseTab(
                    state: state,
                    context: context,
                    addAddressCubit: addAddressCubit,
                    addressData: addressData,
                    textFieldKey: textFieldKey,
                    contactNameController: contactNameController,
                    contactNumberController: contactNumberController,
                    addressController: addressController,
                    flatNoController: flatNoController,
                    naerbyLandmarkController: naerbyLandmarkController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
