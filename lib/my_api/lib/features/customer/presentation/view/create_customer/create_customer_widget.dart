import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/location_picker_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/order_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/product_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/orderScreen/order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/create_customer/create_customer_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class CreateCustomerWidget extends State<CreateCustomerScreen> {
  late CreateCustomerCubit createNewCustomerCubit;
  late ProductsCubit productsCubit;
  String? selectedValue;
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    createNewCustomerCubit = getItInstance<CreateCustomerCubit>();
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    createNewCustomerCubit.loadData();
    productsCubit.fetchingInitialData(cate: 'cate');
    super.initState();
    if (widget.navigation.navigate == CreateNewNavigate.customer) {
      createNewCustomerCubit.selectType(selectIndex: 0);
      if (widget.navigation.customerModel != null) {
        createNewCustomerCubit.referestControllerData(customerDetailModel: widget.navigation.customerModel!);
      }
    } else {
      createNewCustomerCubit.selectType(selectIndex: 1);
      if (widget.navigation.supplierModel != null) {
        createNewCustomerCubit.supplerEditTextFild(supplierDetailModel: widget.navigation.supplierModel!);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    createNewCustomerCubit.close();
  }

// user type
  Widget createNewType({required CreateCustomerLoadedState state}) {
    return Padding(
      padding: REdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            text: "${TranslationConstants.type.translate(context)}:",
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          const Spacer(),
          Row(
            children: List.generate(
              2,
              (index) => GestureDetector(
                onTap: () {
                  createNewCustomerCubit.selectType(selectIndex: index);
                },
                child: customerAndSupplierButton(state, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customerAndSupplierButton(CreateCustomerLoadedState state, int index) {
    return CommonWidget.container(
      height: 40,
      width: 85,
      isBorder: state.selectIndexType == index ? true : false,
      alignment: Alignment.center,
      color: state.selectIndexType == index ? appConstants.deslectedBackGroundColor : appConstants.backgroundColor,
      margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10),
      borderColor: appConstants.editbuttonColor,
      borderRadius: 20.r,
      child: CommonWidget.commonText(
          text: index == 0
              ? TranslationConstants.customer.translate(context)
              : TranslationConstants.supplier.translate(context),
          color: state.selectIndexType == index ? appConstants.editbuttonColor : appConstants.neutral1Color,
          fontSize: 15),
    );
  }

// basic info view
  Widget basicInfoTextFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: widget.navigation.isForEdit ? 0 : 10),
        textfildAndLabel(
          textEditingController: createNewCustomerCubit.customerEmailId,
          title: TranslationConstants.email_id.translate(context),
          hint: TranslationConstants.ex_email.translate(context),
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return TranslationConstants.validtion.translate(context);
            }
            return null;
          },
        ),
        birthAndAniversaryDate(),
        CommonWidget.sizedBox(height: 5),
        textfildAndLabel(
          textEditingController: createNewCustomerCubit.customerGstNumber,
          title: TranslationConstants.gst_number.translate(context),
          hint: TranslationConstants.ex_gst_no.translate(context),
          textInputType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return TranslationConstants.validtion.translate(context);
            }
            return null;
          },
        ),
        textfildAndLabel(
          textEditingController: createNewCustomerCubit.customerPanNumber,
          title: TranslationConstants.pan_number.translate(context),
          hint: TranslationConstants.ex_pan_no.translate(context),
          textInputType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return TranslationConstants.validtion.translate(context);
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget birthAndAniversaryDate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        pickedDate(
          controller: createNewCustomerCubit.customerDob,
          ontap: () async {
            List<DateTime?>? date = await CommonWidget.datePicker(
              context: context,
              lastDate: DateTime.now(),
            );
            if (date != null) {
              createNewCustomerCubit.selectDate(date: date[0]);
              createNewCustomerCubit.customerDob = createNewCustomerCubit.formattedDate;
            }
          },
          title: TranslationConstants.date_of_birthday.translate(context),
          hintText: "Ex: 01/01/1996",
        ),
        CommonWidget.sizedBox(width: 13),
        pickedDate(
          controller: createNewCustomerCubit.customerAnniversaryDate,
          hintText: "Ex: 01/01/2020",
          ontap: () async {
            List<DateTime?>? date = await CommonWidget.datePicker(
              context: context,
              lastDate: DateTime.now(),
            );
            if (date != null) {
              createNewCustomerCubit.selectDate(date: date[0]);
              createNewCustomerCubit.customerAnniversaryDate = createNewCustomerCubit.formattedDate;
            }
          },
          title: TranslationConstants.anniversary_date.translate(context),
        ),
      ],
    );
  }

// family details view
  Widget basicInfoFamilyDetails({required CreateCustomerLoadedState state}) {
    return Padding(
      padding: newDeviceType == NewDeviceType.phone
          ? EdgeInsets.all(10.r)
          : newDeviceType == NewDeviceType.tablet
              ? EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w)
              : EdgeInsets.symmetric(vertical: 10.h, horizontal: 500.w),
      child: BlocBuilder<ToggleCubit, bool>(
        bloc: createNewCustomerCubit.toggleCubit,
        builder: (context, toggleState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.family_details.translate(context),
                    style: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                          color: appConstants.editbuttonColor,
                        ),
                  ),
                  CommonWidget.toggleButton(
                    value: toggleState,
                    backgroundColor: appConstants.transparent,
                    activeTrackColor: appConstants.editbuttonColor,
                    onChanged: (bool value) => createNewCustomerCubit.toggleCubit.setValue(value: value),
                  ),
                ],
              ),
              Visibility(
                visible: toggleState != false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.familyDetailData.length,
                      itemBuilder: (context, index) {
                        return addFamilyDetailBox(state: state, index: index);
                      },
                    ),
                    CommonWidget.sizedBox(height: 30),
                    addMemberButton(),
                    CommonWidget.sizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget addMemberButton() {
    return CommonWidget.commonButton(
      borderRadius: 8.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidget.commonIcon(icon: Icons.add, iconSize: 25.r, iconColor: appConstants.editbuttonColor),
          CommonWidget.commonText(
            text: TranslationConstants.add_member.translate(context),
            color: appConstants.editbuttonColor,
            fontSize: 16,
          )
        ],
      ),
      color: appConstants.editbuttonColor.withOpacity(0.2),
      context: context,
      borderColor: appConstants.editbuttonColor,
      isBorder: true,
      height: 40.h,
      alignment: Alignment.center,
      onTap: () {
        createNewCustomerCubit.addFamilyDetails();
      },
    );
  }

  Widget addFamilyDetailBox({
    required CreateCustomerLoadedState state,
    required int index,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
                text: "0${index + 1}.", color: appConstants.editbuttonColor, fontWeight: FontWeight.bold),
            CommonWidget.imageButton(
              onTap: () {
                CommonWidget.showAlertDialog(
                  context: context,
                  text: TranslationConstants.want_delete_family_name.translate(context),
                  onTap: () {
                    createNewCustomerCubit.deleteFamilyMember(index: index);
                    CommonRouter.pop();
                  },
                );
              },
              svgPicturePath: "assets/photos/svg/common/trash.svg",
              iconSize: 20.h,
              color: appConstants.theme1Color,
            )
          ],
        ),
        CommonWidget.sizedBox(height: 10),
        textfileText(text: TranslationConstants.name.translate(context)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: textformfield(
            controller: state.familyDetailData[index].familyMemberName,
            hintText: TranslationConstants.ex_family_details_name.translate(context),
            keyboardType: TextInputType.name,
          ),
        ),
        CommonWidget.sizedBox(height: 15),
        CustomDropdownButton(
          height: 200.h,
          scrolllingHeight: 130.h,
          useTextField: true,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          padding: EdgeInsets.all(10.r),
          titleTextAlignment: Alignment.centerLeft,
          selectedOptions: TranslationConstants.select_relationship.translate(context),
          dataList: [
            TranslationConstants.father.translate(context),
            TranslationConstants.mother.translate(context),
            TranslationConstants.wife.translate(context),
            TranslationConstants.daughter.translate(context),
          ],
          onOptionSelected: (v) {},
        ),
        CommonWidget.sizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pickedDate(
              controller: state.familyDetailData[index].dateOfBirth,
              ontap: () async {
                List<DateTime?>? date = await CommonWidget.datePicker(context: context, lastDate: DateTime.now());
                if (date != null) {
                  String formatter = DateFormat('dd/MM/yyyy').format(date[0]!);
                  state.familyDetailData[index].dateOfBirth = formatter;
                  createNewCustomerCubit.selectRelationship(state: state, index: index);
                }
              },
              title: TranslationConstants.date_of_birthday.translate(context),
              hintText: "Ex: 01/01/1996",
            ),
            CommonWidget.sizedBox(width: 13),
            pickedDate(
              controller: state.familyDetailData[index].dateOfAnniversary,
              hintText: "Ex: 01/01/2020",
              ontap: () async {
                List<DateTime?>? date = await CommonWidget.datePicker(context: context, lastDate: DateTime.now());
                if (date != null) {
                  String formatter = DateFormat('dd/MM/yyyy').format(date[0]!);
                  state.familyDetailData[index].dateOfAnniversary = formatter;
                  createNewCustomerCubit.selectRelationship(state: state, index: index);
                  createNewCustomerCubit.selectRelationship(state: state, index: index);
                }
              },
              title: TranslationConstants.anniversary_date.translate(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget screenView({required CreateCustomerLoadedState state}) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Visibility(
              visible: widget.navigation.customerModel == null && state.selectTabValue == 0,
              child: createNewType(state: state),
            ),
          ),
          Visibility(
            visible: state.selectTabValue == 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: textfildAndLabel(
                textEditingController: createNewCustomerCubit.customerName,
                title: TranslationConstants.name.translate(context),
                hint: TranslationConstants.ex_name.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) return TranslationConstants.validtion.translate(context);
                  return null;
                },
              ),
            ),
          ),
          Visibility(
            visible: state.selectTabValue == 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: textfildAndLabel(
                textEditingController: createNewCustomerCubit.customerMobileNumber,
                title: TranslationConstants.mobile_number.translate(context),
                hint: TranslationConstants.ex_mobie_number.translate(context),
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return TranslationConstants.validtion.translate(context);
                  return null;
                },
              ),
            ),
          ),
          CommonWidget.container(
            shadow: [
              BoxShadow(color: appConstants.theme7Color, blurRadius: 8, spreadRadius: 0, offset: const Offset(0, 8))
            ],
            color: appConstants.white,
            child: TabBar(
              onTap: (value) => createNewCustomerCubit.showButtonTabbar(selectTabValue: value, state: state),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: appConstants.editbuttonColor,
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return Colors.transparent;
                },
              ),
              tabs: [
                commonTabbar(titalText: TranslationConstants.basic_info.translate(context), index: 0, state: state),
                commonTabbar(titalText: TranslationConstants.orders.translate(context), index: 1, state: state),
                commonTabbar(titalText: TranslationConstants.shipping_add.translate(context), index: 2, state: state),
              ],
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            bloc: productsCubit,
            builder: (context, productState) {
              if (productState is ProductsLoadedState) {
                return Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      basicInfoDetails(state: state),
                      productState.checkScreenIndex == CheckScreen.product
                          ? const ProductScreen(
                              args: ProductScreenArgs(
                                openeingOrderScreenFrom: OpeneingOrderScreenFrom.createCustomer,
                                displayAppBar: false,
                              ),
                            )
                          : OrderScreen(
                              product: OrderScreenArgs(
                                productCubit: productsCubit,
                                selectedProduct: productState.selectedProduct,
                                openeingOrderScreenFrom: OpeneingOrderScreenFrom.createCustomer,
                                displayAppBar: false,
                              ),
                            ),
                      shippingAddview(state: state),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget supplierScreenView({required CreateCustomerLoadedState state}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(visible: widget.navigation.supplierModel == null, child: createNewType(state: state)),
              CommonWidget.sizedBox(height: 10),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierNameController,
                title: TranslationConstants.party_name.translate(context),
                hint: TranslationConstants.ex_name.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.suppliermobileNumberController,
                title: TranslationConstants.mobile_number.translate(context),
                hint: TranslationConstants.ex_mobie_number.translate(context),
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplieremilController,
                title: TranslationConstants.email_id.translate(context),
                hint: TranslationConstants.ex_email.translate(context),
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierGstNumberController,
                title: TranslationConstants.gst_number.translate(context),
                hint: TranslationConstants.ex_gst_no.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierpanNumberController,
                title: TranslationConstants.gst_number.translate(context),
                hint: TranslationConstants.ex_pan_no.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierflatNoController,
                title: TranslationConstants.flat_no_building_name.translate(context),
                hint: TranslationConstants.enter_flate_building_name.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierareaController,
                title: TranslationConstants.area_locality.translate(context),
                hint: "",
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
              textfildAndLabel(
                textEditingController: createNewCustomerCubit.supplierlandmarkController,
                title: TranslationConstants.nearby_landmark.translate(context),
                hint: TranslationConstants.enter_nearby.translate(context),
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationConstants.validtion.translate(context);
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// shipping Add view
  Widget shippingAddview({required CreateCustomerLoadedState state}) {
    return CommonWidget.container(
      color: appConstants.backGroundColor,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 10.h),
        child: CommonWidget.container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          color: appConstants.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textfileText(text: TranslationConstants.address_type.translate(context)),
                BlocBuilder<CounterCubit, int>(
                  bloc: createNewCustomerCubit.counterCubit,
                  builder: (context, state) {
                    return Row(
                      children: List.generate(
                        3,
                        (index) => GestureDetector(
                          onTap: () {
                            createNewCustomerCubit.counterCubit.chanagePageIndex(index: index);
                          },
                          child: addressTypeContainer(state, index, context),
                        ),
                      ),
                    );
                  },
                ),
                CommonWidget.sizedBox(height: 10),
                textfildAndLabel(
                    title: TranslationConstants.flat_no_building_name.translate(context),
                    textEditingController: createNewCustomerCubit.buildingNameController,
                    hint: TranslationConstants.enter_flate_building_name.translate(context),
                    textInputType: TextInputType.name),
                CommonWidget.sizedBox(height: 10),
                textfileText(text: TranslationConstants.area_locality.translate(context)),
                areaAndLocalationfield(state),
                CommonWidget.sizedBox(height: 20),
                Row(
                  children: [
                    textfileText(text: TranslationConstants.nearby_landmark.translate(context)),
                    CommonWidget.commonText(
                      text: " (${TranslationConstants.optional.translate(context)})",
                      color: appConstants.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: textformfield(
                    controller: createNewCustomerCubit.nearbyLanmarkController,
                    hintText: TranslationConstants.enter_nearby.translate(context),
                    keyboardType: TextInputType.name,
                    maxline: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget areaAndLocalationfield(CreateCustomerLoadedState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: () async {
          String? address = (await CommonRouter.pushNamed(RouteList.location_picker_screen,
                  arguments: const LocationPickerScreenArguments(navigationFrom: CheckLoactionNavigation.addAddress)))
              as String?;
          createNewCustomerCubit.shippingAddress = TextEditingController(text: address ?? '');
          createNewCustomerCubit.update(state: state);
        },
        child: textformfield(
            enable: false,
            controller: createNewCustomerCubit.shippingAddress,
            hintText: TranslationConstants.enter_area_locality.translate(context),
            keyboardType: TextInputType.name,
            maxline: 3),
      ),
    );
  }

  Widget addressTypeContainer(int state, int index, BuildContext context) {
    return CommonWidget.container(
      height: 45,
      width: 75,
      isBorder: true,
      alignment: Alignment.center,
      color: state == index ? appConstants.deslectedBackGroundColor : null,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
      borderColor: state == index ? appConstants.editbuttonColor : appConstants.neutral6Color,
      borderRadius: 8.r,
      child: CommonWidget.commonText(
        text: Addresstype.values[index].name.toCamelcase(),
        style: Theme.of(context)
            .textTheme
            .caption1BoldHeading
            .copyWith(color: state == index ? appConstants.editbuttonColor : appConstants.neutral1Color, fontSize: 15),
      ),
    );
  }

//Edit Screen View
  Widget editScreenView({required CreateCustomerLoadedState state}) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.type.translate(context)}:",
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              const Spacer(),
              CommonWidget.container(
                width: 100,
                height: 40,
                isBorder: true,
                alignment: Alignment.center,
                color: appConstants.deslectedBackGroundColor,
                margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10),
                borderColor: appConstants.editbuttonColor,
                borderRadius: 20.r,
                child: CommonWidget.commonText(
                  text: widget.navigation.navigate.name.toCamelcase(),
                  color: appConstants.editbuttonColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: textfildAndLabel(
            textEditingController: createNewCustomerCubit.customerName,
            title: TranslationConstants.name.translate(context),
            hint: TranslationConstants.ex_name.translate(context),
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.validtion.translate(context);
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: textfildAndLabel(
            textEditingController: createNewCustomerCubit.customerMobileNumber,
            title: TranslationConstants.mobile_number.translate(context),
            hint: TranslationConstants.ex_mobie_number.translate(context),
            textInputType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.validtion.translate(context);
              }
              return null;
            },
          ),
        ),
        basicInfoDetails(state: state),
      ],
    );
  }

// common
  Widget textfileText({required String text}) {
    return CommonWidget.commonText(text: text, fontSize: 13, fontWeight: FontWeight.bold, color: appConstants.black);
  }

  Widget commonTabbar({required String titalText, required int index, required CreateCustomerLoadedState state}) {
    return Tab(
      child: CommonWidget.commonText(
        text: titalText,
        style: Theme.of(context).textTheme.caption1BoldHeading.copyWith(
              color: state.selectTabValue == index ? appConstants.editbuttonColor : appConstants.black38,
            ),
      ),
    );
  }

  PreferredSizeWidget? orderAndShippingAppBar(BuildContext context, CreateCustomerLoadedState state) {
    return CustomAppBar(
      context,
      titleCenter: false,
      onTap: () => warningDialog(context),
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: createNewCustomerCubit.customerName.text.isEmpty
                ? TranslationConstants.your_name.translate(context)
                : createNewCustomerCubit.customerName.text,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: appConstants.neutral1Color,
          ),
          CommonWidget.commonText(
            text: createNewCustomerCubit.customerMobileNumber.text.isEmpty
                ? TranslationConstants.your_mobile_number.translate(context)
                : "${TranslationConstants.mo.translate(context)}. ${createNewCustomerCubit.customerMobileNumber.text}",
            fontSize: 10,
            color: appConstants.neutral6Color,
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CommonWidget.commonButton(
          borderRadius: 90.r,
          text: (widget.navigation.supplierModel == null)
              ? (widget.navigation.customerModel == null)
                  ? TranslationConstants.save.translate(context)
                  : TranslationConstants.update.translate(context)
              : TranslationConstants.update.translate(context),
          color: appConstants.theme1Color,
          context: context,
          textColor: appConstants.white,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          alignment: Alignment.center,
          onTap: () {
            if (formKey.currentState!.validate()) {
              if (state.selectIndexType == 0) {
                CommonRouter.pop();
              } else {
                String status;
                if (widget.navigation.supplierModel != null) {
                  status = createNewCustomerCubit.saveNewSupplier(
                    supplierDetailModels: widget.navigation.supplierModel,
                  );
                } else {
                  status = createNewCustomerCubit.saveNewSupplier();
                }

                if (status == "Save") {
                  CommonRouter.pop();
                  CommonRouter.pushReplacementNamed(RouteList.supplier_screen);
                  CustomSnackbar.show(
                    snackbarType: SnackbarType.SUCCESS,
                    message: status,
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }

  void warningDialog(BuildContext context) {
    return CommonWidget.showAlertDialog(
      context: context,
      isTitle: true,
      titleText: TranslationConstants.discard_changes.translate(context),
      titleTextStyle: Theme.of(context).textTheme.caption1BoldHeading.copyWith(
            color: appConstants.neutral1Color,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
      text: TranslationConstants.changes_will_not.translate(context),
      maxLines: 2,
      textColor: appConstants.black,
      leftColor: appConstants.themeColor.withOpacity(0.2),
      leftButtonText: TranslationConstants.cancel.translate(context),
      rightButtonText: TranslationConstants.discard.translate(context),
      onTap: () {
        productsCubit.clearAllSelectedDate();
        if (widget.navigation.navigate == CreateNewNavigate.customer) {
          CommonRouter.popUntil(RouteList.customer_list_screen);
        } else {
          CommonRouter.popUntil(RouteList.supplier_screen);
        }
      },
      onNoTap: () => CommonRouter.pop(),
    );
  }

  PreferredSizeWidget? basicInfoAppBar(BuildContext context, CreateCustomerLoadedState state) {
    return CustomAppBar(
      context,
      onTap: () {
        warningDialog(context);
      },
      titleCenter: false,
      elevation: 0,
      shadowcolor: appConstants.grey,
      iconColor: appConstants.neutral1Color,
      title: (widget.navigation.supplierModel == null)
          ? (widget.navigation.customerModel == null)
              ? TranslationConstants.create_new.translate(context)
              : TranslationConstants.edit_profile.translate(context)
          : TranslationConstants.edit_profile.translate(context),
      style: Theme.of(context).textTheme.subTitle3MediumHeading.copyWith(color: appConstants.neutral1Color),
      trailing: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CommonWidget.commonButton(
          borderRadius: 90.r,
          text: TranslationConstants.save.translate(context),
          color: appConstants.theme1Color,
          context: context,
          textColor: appConstants.white,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          alignment: Alignment.center,
          onTap: () {
            if (formKey.currentState!.validate()) {
              if (state.selectIndexType == 0) {
                createNewCustomerCubit.saveCustomer();
                CommonRouter.pop();
                CommonRouter.pushReplacementNamed(RouteList.customer_list_screen);
              } else {
                String status;
                if (widget.navigation.supplierModel != null) {
                  status = createNewCustomerCubit.saveNewSupplier(
                    supplierDetailModels: widget.navigation.supplierModel,
                  );
                } else {
                  status = createNewCustomerCubit.saveNewSupplier();
                }

                if (status == "Save") {
                  CommonRouter.pop();
                  CommonRouter.pushReplacementNamed(RouteList.supplier_screen);
                  CustomSnackbar.show(
                    snackbarType: SnackbarType.SUCCESS,
                    message: status,
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }

  Widget textfildAndLabel({
    required String title,
    required TextEditingController textEditingController,
    required String hint,
    required TextInputType textInputType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 5),
        textfileText(text: title),
        CommonWidget.sizedBox(height: 5),
        textFormFieldsupplier(
          controller: textEditingController,
          hintText: hint,
          keyboardType: textInputType,
          validator: validator,
          context: context,
        ),
        CommonWidget.sizedBox(height: 7),
      ],
    );
  }

  TextFormField textformfield(
      {required TextEditingController controller,
      dynamic validator,
      dynamic onSaved,
      required dynamic hintText,
      VoidCallback? oncalenderTap,
      Color? fillcolor,
      Widget? suffixwidget,
      BoxConstraints? suffixIconConstraints,
      int? maxlength,
      int? maxline,
      readonly = false,
      dynamic keyboardType,
      double? radius,
      VoidCallback? onTap,
      EdgeInsetsGeometry? contentPadding,
      void Function(String)? onChanged,
      bool? enable,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      enabled: enable ?? true,
      controller: controller,
      onTap: onTap,
      maxLines: maxline ?? 1,
      validator: validator,
      onSaved: onSaved,
      minLines: 1,
      maxLength: maxlength,
      onChanged: onChanged,
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10.0),
      readOnly: readonly,
      cursorColor: appConstants.neutral6Color,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: Theme.of(context)
          .textTheme
          .body2MediumHeading
          .copyWith(color: appConstants.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        counterText: "",
        fillColor: Colors.white,
        filled: true,
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixwidget ?? const SizedBox.shrink(),
        hintStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(color: appConstants.neutral8Color),
        border: InputBorder.none,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.neutral6Color),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.paidColor),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appConstants.neutral6Color),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
      ),
    );
  }

  Widget textFormFieldsupplier({
    required TextEditingController controller,
    required dynamic hintText,
    required BuildContext context,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    VoidCallback? oncalenderTap,
    Color? fillcolor,
    Widget? suffixwidget,
    BoxConstraints? suffixIconConstraints,
    int? maxlength,
    int maxline = 1,
    bool readonly = false,
    bool? enabled,
    dynamic keyboardType,
    VoidCallback? onTap,
    TextStyle? style,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    bool? issuffixWidget,
  }) {
    return TextFormField(
      cursorColor: appConstants.neutral6Color,
      controller: controller,
      onTap: onTap,
      maxLines: maxline,
      validator: validator,
      onSaved: onSaved,
      maxLength: maxlength,
      readOnly: readonly,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType ?? keyboardType,
      style: style ??
          Theme.of(context).textTheme.body1BookHeading.copyWith(
                color: appConstants.textColor,
              ),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        counterText: "",
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixwidget ?? const SizedBox.shrink(),
        hintStyle: TextStyle(fontSize: 13.sp, color: appConstants.neutral6Color.withOpacity(0.6)),
        border: InputBorder.none,
        hintText: hintText,
        enabled: enabled ?? true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.neutral6Color)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.neutral6Color)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.neutral6Color)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.theme1Color)),
      ),
    );
  }

  Widget pickedDate({
    required String title,
    required VoidCallback ontap,
    required String hintText,
    required String? controller,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textfileText(text: title),
          CommonWidget.sizedBox(height: 5),
          textFormFieldsupplier(
            controller: TextEditingController(text: controller == null ? '' : controller.toString()),
            issuffixWidget: true,
            readonly: true,
            hintText: hintText,
            onTap: ontap,
            context: context,
            suffixwidget: Padding(
              padding: EdgeInsets.all(13.r),
              child: CommonWidget.imageButton(
                  svgPicturePath: "assets/photos/svg/common/calender.svg",
                  boxFit: BoxFit.fill,
                  color: appConstants.neutral6Color),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.validtion.translate(context);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget basicInfoDetails({required CreateCustomerLoadedState state}) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 10.w, right: 10.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            basicInfoTextFile(),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: CommonWidget.commonDashLine()),
            basicInfoFamilyDetails(state: state),
          ],
        ),
      ),
    );
  }
}
