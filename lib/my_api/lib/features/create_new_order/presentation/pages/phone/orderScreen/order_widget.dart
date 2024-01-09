import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_state.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/paymentCubit/payment_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/timeSlotCubit/time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/orderScreen/order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/widgets/custom_drop_down.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OrderScreenWidget extends State<OrderScreen> {
  late ProductsCubit productsCubit;
  late OrderCubit orderCubit;
  late CounterCubit counterCubit;
  late TimeSLotCubit timeSLotCubit;
  late PaymentCubit paymentCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    orderCubit = productsCubit.orderCubit;
    counterCubit = productsCubit.counterCubit;
    timeSLotCubit = productsCubit.timeSlotCubit;
    paymentCubit = productsCubit.paymentCubit;
    orderCubit.initialFetchData(selectedProducts: widget.product.selectedProduct);
    counterCubit.getValueForOrderScreenDialogBox(length: 0);
    timeSLotCubit.initialFetchData();
    paymentCubit.initialFetchData();
    super.initState();
  }

  Widget productedView({required OrderLoadedState state}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.selectedProducts.length,
      itemBuilder: (context, productIndex) {
        return CommonWidget.container(
          padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
          color: appConstants.white,
          child: Column(
            children: [
              productGeneralInfoAndCatlog(productIndex: productIndex, state: state),
              CommonWidget.sizedBox(height: 5),
              andProductQuantity(context: context, state: state, productIndex: productIndex),
              CommonWidget.sizedBox(height: 5),
              productQuantityView(state: state, productIndex: productIndex),
            ],
          ),
        );
      },
    );
  }

  Widget addMoreItemsButton() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoadedState) {
          return InkWell(
            onTap: () => productsCubit.changePage(
              checkScreen: CheckScreen.product,
              openeingOrderScreenFrom: widget.product.openeingOrderScreenFrom,
            ),
            child: CommonWidget.container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              borderRadius: 12.r,
              child: Row(
                children: [
                  CommonWidget.commonText(text: TranslationConstants.add_more_items.translate(context), fontSize: 15),
                  const Spacer(),
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/order_module/add_icon_circle_border.svg",
                    height: 22.h,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget addInstructionsButton() {
    return InkWell(
      onTap: () => showDialog(context: context, builder: (context) => addInstructionDialog()),
      child: CommonWidget.container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        borderRadius: 12.r,
        child: Row(
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.add_cooking_instructions.translate(context),
              fontSize: 15,
            ),
            const Spacer(),
            CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/order_module/add_instruction_icon.svg",
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget addInstructionDialog() {
    return AlertDialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: appConstants.transparent,
      content: CommonWidget.container(
        color: appConstants.white,
        width: double.infinity,
        borderRadius: 20,
        padding: EdgeInsets.all(15.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                      text: TranslationConstants.cooking_instructions.translate(context),
                      color: appConstants.theme1Color,
                      fontWeight: FontWeight.bold),
                  CommonWidget.svgIconButton(
                    svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                    iconSize: 30.h,
                    color: appConstants.theme1Color,
                    onTap: () => CommonRouter.pop(),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 20),
              CommonWidget.commonText(
                  text: TranslationConstants.instruction.translate(context), fontSize: 13, fontWeight: FontWeight.bold),
              CommonWidget.sizedBox(height: 10),
              CommonWidget.sizedBox(height: 5),
              BlocBuilder<CounterCubit, int>(
                bloc: counterCubit,
                builder: (context, words) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonWidget.textField(
                        controller: orderCubit.txtCookingInstructionsController,
                        maxLines: 3,
                        maxLength: 100,
                        style: TextStyle(fontSize: 18.sp),
                        contentPadding: EdgeInsets.all(13.h),
                        hintText: TranslationConstants.type_message.translate(context).toCamelcase(),
                        hintStyle: TextStyle(fontSize: 13.sp),
                        textInputType: TextInputType.emailAddress,
                        focusedBorderColor: appConstants.cookingWarning,
                        onChanged: (p0) {
                          counterCubit.getValueForOrderScreenDialogBox(length: p0.length);
                        },
                      ),
                      CommonWidget.sizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonWidget.commonText(
                            text: "$words ${TranslationConstants.characters_left.translate(context)}",
                            color: appConstants.neutral1Color.withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              CommonWidget.sizedBox(height: 23),
              CommonWidget.commonText(
                maxLines: 4,
                text: TranslationConstants.cooking_warring.translate(context),
                color: appConstants.neutral1Color.withOpacity(0.5),
                fontSize: 13,
                textAlign: TextAlign.start,
              ),
              CommonWidget.sizedBox(height: 23),
              CommonWidget.commonButton(
                height: 50.h,
                width: double.infinity,
                alignment: Alignment.center,
                text: TranslationConstants.cooking_add.translate(context),
                style: TextStyle(color: appConstants.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                context: context,
                onTap: () => CommonRouter.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cupenDropDownView({required OrderLoadedState state}) {
    CupponModel cuppon = state.selectedCupon;
    return CustomDropdownButton(
      items: orderCubit.cuponsDropDownItems,
      onMenuCLose: () => orderCubit.isDropDownActive(isDropDownActive: false, state: state),
      onMenuOpen: () => orderCubit.isDropDownActive(isDropDownActive: true, state: state),
      onTap: () => setCuponsDropDownItems(state: state),
      customDropDownButton: CommonWidget.container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: cuppon.offerPersentage > 0 ? 10.h : 18.h),
        alignment: Alignment.center,
        width: double.infinity,
        borderRadius: 12.r,
        child: Row(
          children: [
            cuppon.offerPersentage > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonWidget.commonText(
                          text: "${cuppon.offerPersentage}% OFF up to ${cuppon.maxAmt..formatCurrency()}",
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                      CommonWidget.commonText(
                          text:
                              "${TranslationConstants.save.translate(context)} ${cuppon.savedAmount..formatCurrency()}",
                          fontSize: 11,
                          color: appConstants.cookingWarning),
                    ],
                  )
                : CommonWidget.commonText(text: TranslationConstants.apply_coupons.translate(context), fontSize: 15),
            const Spacer(),
            state.isMenuOpen
                ? CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/common/up_arrow.svg",
                    height: 10.h,
                    color: appConstants.orderScreenSelectedCategoryColor,
                  )
                : CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/common/bottom_arrow.svg",
                    height: 10.h,
                    color: appConstants.orderScreenSelectedCategoryColor,
                  ),
          ],
        ),
      ),
      showHintOnly: true,
      iconSize: 36.r,
      elevation: 2,
      maxDialogWidth: 325.w,
      maxDialogHeight: 200.h,
      shadowColor: appConstants.orderScreenSearchFieldBorderColor,
      scrollController: ScrollController(),
      onChanged: (String? data) {
        for (var value in state.availableCupons) {
          if ((data ?? "").contains(value.offerPersentage.toString().trim()) &&
              (data ?? "").contains(value.maxAmt.toString().trim()) &&
              (data ?? "").contains(value.savedAmount.toString().trim())) {
            orderCubit.addCuppon(cuppon: value, state: state, cuponDiscount: value.savedAmount.toDouble());
            break;
          }
        }
      },
      onOptionSelected: (v) {},
    );
  }

  Widget diliveryMode({required OrderLoadedState state}) {
    return CommonWidget.container(
      width: double.infinity,
      color: appConstants.white,
      child: Row(
        children: [
          Checkbox(
            side: BorderSide(color: appConstants.cookingWarning),
            activeColor: appConstants.orderScreenSelectedCategoryColor,
            value: state.delivaryMode.name == OrderDiliveryMode.now.name ? true : false,
            onChanged: (value) {
              orderCubit.changeDelivaryMode(state: state, mode: OrderDiliveryMode.now);
              orderCubit.itemTotal(productData: state.selectedProducts);
            },
          ),
          CommonWidget.commonText(
              text: TranslationConstants.collect_now.translate(context), fontWeight: FontWeight.bold, fontSize: 13),
          Checkbox(
            side: BorderSide(color: appConstants.cookingWarning),
            activeColor: appConstants.orderScreenSelectedCategoryColor,
            value: state.delivaryMode.name == OrderDiliveryMode.delivary.name ? true : false,
            onChanged: (value) {
              orderCubit.changeDelivaryMode(state: state, mode: OrderDiliveryMode.delivary);
              orderCubit.itemTotal(productData: state.selectedProducts);
            },
          ),
          CommonWidget.commonText(
              text: TranslationConstants.delivery.translate(context).toCamelcase(),
              fontWeight: FontWeight.bold,
              fontSize: 13),
        ],
      ),
    );
  }

  Widget invoiceView({required OrderLoadedState state}) {
    return CommonWidget.container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      color: appConstants.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: TranslationConstants.item_total.translate(context)),
              CommonWidget.commonText(text: state.itemTotal.formatCurrency()),
            ],
          ),
          CommonWidget.sizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/bank_icon.svg", height: 20.h),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                  text: TranslationConstants.gst_charge.translate(context),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appConstants.black),
              const Spacer(),
              CommonWidget.commonText(
                text: state.gstCharge.formatCurrency(),
                fontSize: 14,
                color: appConstants.black,
              ),
            ],
          ),
          state.delivaryMode.name == OrderDiliveryMode.delivary.name
              ? CommonWidget.container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/delivary.svg", height: 20.h),
                      CommonWidget.sizedBox(width: 10),
                      CommonWidget.commonText(
                          text: TranslationConstants.delivery_charge.translate(context),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appConstants.neutral1Color),
                      const Spacer(),
                      CommonWidget.commonText(
                        text: state.delivaryCharge.formatCurrency(),
                        fontSize: 14,
                        color: appConstants.black,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Visibility(visible: state.discount > 0, child: discountView(state)),
          CommonWidget.sizedBox(height: 10),
          CommonWidget.commonDashLine(color: appConstants.neutral6Color.withOpacity(0.5)),
          CommonWidget.sizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(text: TranslationConstants.total.translate(context)),
              CommonWidget.commonText(text: state.total.formatCurrency()),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.balance_amount.translate(context).toCamelcase(),
                color: appConstants.orderScreenSelectedCategoryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              CommonWidget.commonText(
                text: "- ${state.balanceAmount..formatCurrency()}",
                color: appConstants.orderScreenSelectedCategoryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          CommonWidget.sizedBox(height: 5),
          Divider(
            color: appConstants.neutral6Color.withOpacity(0.5),
            thickness: 1.5,
          ),
          CommonWidget.sizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.collect_amount.translate(context).toCamelcase(),
                color: appConstants.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              CommonWidget.commonText(
                text: state.colloectedAmount.formatCurrency(),
                color: appConstants.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget deliveryTimeSlot({required TimeSLotCubitLoadedState state}) {
    DateTime nextDay = DateTime.now().add(const Duration(days: 1));
    return CommonWidget.container(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.delivery_time_slot.translate(context),
            fontSize: 15,
          ),
          CommonWidget.sizedBox(height: 10),
          selectDate(state, nextDay),
          CommonWidget.sizedBox(height: 10),
          Row(
            children: [
              CommonWidget.commonText(
                  text:
                      "${state.deliverytype.name.toCamelcase()} ${TranslationConstants.delivery.translate(context).toCamelcase()} : ",
                  fontSize: 12,
                  color: appConstants.green),
              CommonWidget.commonText(text: state.selectedTime, fontSize: 12, color: appConstants.green),
            ],
          ),
          CommonWidget.sizedBox(height: 15),
          standardDelivaryTime(state: state),
          CommonWidget.sizedBox(height: 15),
          CommonWidget.commonDashLine(color: appConstants.neutral6Color.withOpacity(0.5)),
          CommonWidget.sizedBox(height: 15),
          midnightDelivaryTime(state: state),
          CommonWidget.sizedBox(height: 15),
          CommonWidget.commonDashLine(color: appConstants.neutral6Color.withOpacity(0.5)),
          CommonWidget.sizedBox(height: 15),
          fixDelivaryTime(state: state),
        ],
      ),
    );
  }

// !Main Widget Partition
  Widget productGeneralInfoAndCatlog({required int productIndex, required OrderLoadedState state}) {
    return Row(
      children: [
        state.selectedProducts[productIndex].isVeg == true
            ? CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/vegetarian_icon.svg", height: 20.h)
            : CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/nonVegetarian_icon.svg", height: 20.h),
        CommonWidget.sizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: CommonWidget.container(
            width: 150,
            height: 36,
            alignment: Alignment.centerLeft,
            child: CommonWidget.commonText(
              text: state.selectedProducts[productIndex].name,
              fontSize: 15,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Spacer(),
        CommonWidget.commonButton(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
          color: appConstants.orderScreenSelectedCategoryColor,
          alignment: Alignment.center,
          text: TranslationConstants.catalogue.translate(context),
          style: TextStyle(color: appConstants.white, fontSize: 15.sp),
          context: context,
          onTap: () => CommonRouter.pushNamed(
            RouteList.cateloge_screen,
            arguments: state.selectedProducts[productIndex],
          ),
        ),
      ],
    );
  }

  Widget productQuantityView({required OrderLoadedState state, required int productIndex}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.selectedProducts[productIndex].selectedQuantity.length,
      itemBuilder: (context, quantityIndex) {
        var quantityData = state.selectedProducts[productIndex].selectedQuantity;
        QuantityModel quantity = quantityData[quantityIndex];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.sizedBox(
                width: 160,
                child: Row(
                  children: [
                    CommonWidget.commonBulletPoint(color: appConstants.theme1Color, size: 5.h),
                    CommonWidget.sizedBox(width: 20),
                    CommonWidget.commonText(
                        text: "${quantity.quantity} ${quantity.quantityType}",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: appConstants.black),
                    const Spacer(),
                    CommonWidget.commonText(
                        text: (quantity.price * quantity.piecs).formatCurrency(),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: appConstants.orderScreenSelectedCategoryColor),
                  ],
                ),
              ),
              const Spacer(),
              quantityControlContainer(
                  quantityData: quantityData, productIndex: productIndex, quantityIndex: quantityIndex, state: state),
              const Spacer(),
              InkWell(
                onTap: () {
                  orderCubit.romoveProduct(
                      rawProduct: state.selectedProducts,
                      productIndex: productIndex,
                      quantityIndex: quantityIndex,
                      state: state);
                  orderCubit.itemTotal(
                    productData: state.selectedProducts,
                  );
                },
                child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/common/trash.svg", color: appConstants.black, height: 23.h),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget quantityControlContainer({
    required List<QuantityModel> quantityData,
    required int productIndex,
    required int quantityIndex,
    required OrderLoadedState state,
  }) {
    return CommonWidget.container(
      width: 75,
      height: 30,
      color: appConstants.quantityManageContainerColor,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      borderRadius: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              orderCubit.decreaseQuantity(
                  product: quantityData[quantityIndex],
                  rawProducts: state.selectedProducts,
                  productIndex: productIndex,
                  quantityIndex: quantityIndex,
                  state: state);
              orderCubit.itemTotal(productData: state.selectedProducts);
            },
            child: CommonWidget.container(
              height: double.infinity,
              alignment: Alignment.center,
              color: appConstants.transparent,
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/common/minus_icon.svg",
                height: 2.h,
                color: appConstants.theme1Color,
              ),
            ),
          ),
          CommonWidget.commonText(
              text: "${quantityData[quantityIndex].piecs}",
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: appConstants.theme1Color),
          InkWell(
            onTap: () {
              orderCubit.increasQuantity(product: quantityData[quantityIndex], state: state);
              orderCubit.itemTotal(productData: state.selectedProducts);
            },
            child: CommonWidget.container(
              height: double.infinity,
              alignment: Alignment.center,
              color: appConstants.transparent,
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/common/plus_icon.svg",
                height: 10.h,
                width: 15.w,
                color: appConstants.theme1Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget andProductQuantity({
    required BuildContext context,
    required OrderLoadedState state,
    required int productIndex,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: selectQuantityButon(productIndex: productIndex, state: state),
        ),
        CommonWidget.sizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              CommonWidget.commonText(
                  text: TranslationConstants.quantity.translate(context), fontSize: 13, fontWeight: FontWeight.bold),
              CommonWidget.commonText(
                  text: " (${TranslationConstants.item.translate(context)})",
                  fontSize: 13,
                  color: appConstants.neutral6Color),
            ],
          ),
        ),
      ],
    );
  }

  Widget selectQuantityButon({
    required productIndex,
    required OrderLoadedState state,
  }) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) {
          return selectQuantityBottomSheet(state: state, productIndex: productIndex);
        },
      ),
      child: CommonWidget.container(
        height: 37,
        padding: EdgeInsets.symmetric(horizontal: 6.h),
        width: double.infinity,
        color: appConstants.transparent,
        borderRadius: 5.r,
        borderColor: appConstants.orderScreenSearchFieldBorderColor,
        isBorder: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonWidget.commonText(
                text: TranslationConstants.quantity.translate(context), fontSize: 14, fontWeight: FontWeight.bold),
            CommonWidget.sizedBox(width: 4),
            CommonWidget.commonText(
                text: "(${TranslationConstants.weight.translate(context)})",
                fontSize: 14,
                color: appConstants.neutral6Color),
            const Spacer(),
            Icon(
              Icons.arrow_drop_up,
              size: 25.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectQuantityBottomSheet({required OrderLoadedState state, required int productIndex}) {
    return CommonWidget.container(
      width: double.infinity,
      color: appConstants.white,
      borderRadius: 15.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonWidget.container(
            padding: EdgeInsets.all(10.h),
            height: 45,
            alignment: Alignment.bottomCenter,
            topLeft: 20.r,
            topRight: 20.r,
            width: double.infinity,
            borderColor: appConstants.textColor.withOpacity(0.1),
            isBorderOnlySide: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonWidget.commonText(
                  text:
                      "${TranslationConstants.quantity.translate(context)} (${TranslationConstants.weight.translate(context)})",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appConstants.theme1Color,
                ),
                const Spacer(),
                IconButton(
                  splashColor: appConstants.transparent,
                  padding: EdgeInsets.zero,
                  highlightColor: appConstants.transparent,
                  icon: Icon(
                    Icons.close,
                    size: 25.h,
                    color: appConstants.themeColor,
                  ),
                  onPressed: () => CommonRouter.pop(),
                ),
              ],
            ),
          ),
          Divider(height: 2.h, color: appConstants.neutral1Color.withOpacity(0.1)),
          CommonWidget.sizedBox(height: 10),
          BlocBuilder<OrderCubit, OrderState>(
            bloc: orderCubit,
            builder: (context, state) {
              if (state is OrderLoadedState) {
                return Container(
                  constraints: BoxConstraints(maxHeight: 315.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.selectedProducts[productIndex].availableQuantity.length,
                    itemBuilder: (context, index) {
                      var quantityData = state.selectedProducts[productIndex].availableQuantity;
                      QuantityModel quantity = quantityData[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                        child: InkWell(
                          onTap: () {
                            orderCubit.bottomSheetRadioButtonIndex = index;
                            orderCubit.update(state: state);
                          },
                          child: Row(
                            children: [
                              CommonWidget.commonText(
                                  text: "${quantity.quantity} ${quantity.quantityType}",
                                  fontSize: 15,
                                  fontWeight: orderCubit.bottomSheetRadioButtonIndex == index ? FontWeight.bold : null,
                                  color: appConstants.black),
                              const Spacer(),
                              CommonWidget.commonText(
                                text: (quantity.price).formatCurrency(),
                                fontSize: 15,
                                fontWeight: orderCubit.bottomSheetRadioButtonIndex == index ? FontWeight.bold : null,
                                color: appConstants.black,
                              ),
                              CommonWidget.sizedBox(width: 20),
                              orderCubit.bottomSheetRadioButtonIndex == index
                                  ? CommonWidget.imageBuilder(
                                      imageUrl: "assets/photos/svg/order_module/active_radio_button.svg",
                                      height: 20.h,
                                    )
                                  : CommonWidget.imageBuilder(
                                      imageUrl: "assets/photos/svg/order_module/dactive_radio_button.svg",
                                      height: 20.h,
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          CommonWidget.commonButton(
            margin: EdgeInsets.all(15.h),
            alignment: Alignment.center,
            text: TranslationConstants.apply.toCamelcase(),
            textColor: appConstants.white,
            context: context,
            onTap: () {
              QuantityModel compareProduct =
                  state.selectedProducts[productIndex].availableQuantity[orderCubit.bottomSheetRadioButtonIndex];
              for (var x in state.selectedProducts[productIndex].availableQuantity) {
                if (compareProduct.price.toString().contains(x.price.toString().trim()) &&
                    compareProduct.quantity.toString().contains(x.quantity.toString().trim()) &&
                    compareProduct.quantityType.toString().contains(x.quantityType.toString().trim())) {
                  orderCubit.addQuantityOfProduct(
                    productsData: state.selectedProducts,
                    productIndex: productIndex,
                    selectedQuantity: x,
                    state: state,
                  );
                }
              }
              orderCubit.itemTotal(
                productData: state.selectedProducts,
              );
              orderCubit.bottomSheetRadioButtonIndex = 0;
              CommonRouter.pop();
            },
            height: 45.h,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget discountView(OrderLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidget.container(
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/order_module/discount_icon.svg", height: 23.h),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.commonText(
                  text: TranslationConstants.discount.translate(context),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: appConstants.neutral1Color),
              const Spacer(),
              CommonWidget.commonText(
                text: "- ${state.discount..formatCurrency()}",
                fontSize: 14,
                color: appConstants.black,
              ),
            ],
          ),
        ),
        CommonWidget.sizedBox(height: 7),
        state.coupenDiscount > 0
            ? Row(
                children: [
                  CommonWidget.sizedBox(width: 28),
                  CommonWidget.commonText(
                      text:
                          "${TranslationConstants.coupon_discount.translate(context)} - ${state.coupenDiscount..formatCurrency()}",
                      fontSize: 13,
                      color: appConstants.neutral6Color),
                ],
              )
            : const SizedBox.shrink(),
        CommonWidget.sizedBox(height: 5),
        state.walletPoints > 0
            ? Row(
                children: [
                  CommonWidget.sizedBox(width: 28),
                  CommonWidget.commonText(
                      text:
                          "${TranslationConstants.use_your_wallet_points.translate(context)} - ${state.walletPoints..formatCurrency()}",
                      fontSize: 13,
                      color: appConstants.neutral6Color),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget selectDate(TimeSLotCubitLoadedState state, DateTime nextDay) {
    return CommonWidget.sizedBox(
      height: 53,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => timeSLotCubit.selectDate(
                  orderDelivaryTime: OrderDeliveryDate.today,
                  state: state,
                  selectedDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
              child: CommonWidget.container(
                alignment: Alignment.center,
                color: appConstants.white,
                borderColor: state.deliveryDate == OrderDeliveryDate.values[0]
                    ? appConstants.orderScreenSelectedCategoryColor
                    : appConstants.cookingWarning.withOpacity(0.2),
                isBorder: true,
                borderRadius: 10.r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonWidget.commonText(text: TranslationConstants.today.translate(context), fontSize: 13),
                    CommonWidget.commonText(
                        text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        fontSize: 11,
                        color: appConstants.cookingWarning.withOpacity(0.4)),
                  ],
                ),
              ),
            ),
          ),
          CommonWidget.sizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () => timeSLotCubit.selectDate(
                  orderDelivaryTime: OrderDeliveryDate.tommorow,
                  state: state,
                  selectedDate: "${nextDay.day}/${nextDay.month}/${nextDay.year}"),
              child: CommonWidget.container(
                alignment: Alignment.center,
                color: appConstants.white,
                borderColor: state.deliveryDate == OrderDeliveryDate.values[1]
                    ? appConstants.orderScreenSelectedCategoryColor
                    : appConstants.cookingWarning.withOpacity(0.2),
                isBorder: true,
                borderRadius: 10.r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonWidget.commonText(text: TranslationConstants.tomorrow_cart.translate(context), fontSize: 13),
                    CommonWidget.commonText(
                        text: "${nextDay.day}/${nextDay.month}/${nextDay.year}",
                        fontSize: 11,
                        color: appConstants.cookingWarning.withOpacity(0.4)),
                  ],
                ),
              ),
            ),
          ),
          CommonWidget.sizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () async {
                List<DateTime?>? date = await CommonWidget.datePicker(context: context, lastDate: DateTime.now());
                timeSLotCubit.otherDate = date![0];
                timeSLotCubit.selectDate(
                    orderDelivaryTime: OrderDeliveryDate.other,
                    state: state,
                    selectedDate:
                        "${timeSLotCubit.otherDate!.day}/${timeSLotCubit.otherDate!.month}/${timeSLotCubit.otherDate!.year}");
              },
              child: CommonWidget.container(
                alignment: Alignment.center,
                color: appConstants.white,
                borderColor: state.deliveryDate == OrderDeliveryDate.values[2]
                    ? appConstants.orderScreenSelectedCategoryColor
                    : appConstants.cookingWarning.withOpacity(0.2),
                isBorder: true,
                borderRadius: 10.r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/calender.svg", height: 15.h),
                        CommonWidget.sizedBox(width: 3),
                        CommonWidget.commonText(
                          textAlign: TextAlign.start,
                          height: 1.45.h,
                          text: TranslationConstants.other.translate(context),
                          fontSize: 13,
                        ),
                      ],
                    ),
                    timeSLotCubit.otherDate != null
                        ? CommonWidget.commonText(
                            text:
                                "${timeSLotCubit.otherDate!.day}/${timeSLotCubit.otherDate!.month}/${timeSLotCubit.otherDate!.year}",
                            fontSize: 11,
                            color: appConstants.cookingWarning.withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget standardDelivaryTime({required TimeSLotCubitLoadedState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: appConstants.black26),
              child: Radio(
                  activeColor: appConstants.orderScreenSelectedCategoryColor,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  value: state.deliverytype.name,
                  groupValue: OrderDelivaryType.values[0].name,
                  onChanged: (value) => timeSLotCubit.selectDelivaryType(
                      orderDelivaryType: OrderDelivaryType.standard,
                      state: state,
                      time: timeSLotCubit.standardDelivaryTime[0])),
            ),
            InkWell(
                onTap: () => timeSLotCubit.selectDelivaryType(
                    orderDelivaryType: OrderDelivaryType.standard,
                    state: state,
                    time: timeSLotCubit.standardDelivaryTime[0]),
                child: CommonWidget.sizedBox(
                  child: CommonWidget.commonText(
                      text: TranslationConstants.standard_delivery.translate(context), fontSize: 15),
                ))
          ],
        ),
        CommonWidget.sizedBox(height: 10),
        state.deliverytype.name == OrderDelivaryType.values[0].name
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: timeSLotCubit.standardDelivaryTime.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 10 / 3.1,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => timeSLotCubit.selectTime(time: timeSLotCubit.standardDelivaryTime[index], state: state),
                  child: CommonWidget.container(
                    color: state.selectedTime == timeSLotCubit.standardDelivaryTime[index]
                        ? appConstants.orderScreenSelectedCategoryColor.withOpacity(0.2)
                        : appConstants.white,
                    isBorder: true,
                    borderColor: state.selectedTime == timeSLotCubit.standardDelivaryTime[index]
                        ? appConstants.orderScreenSelectedCategoryColor
                        : appConstants.cookingWarning,
                    borderRadius: appConstants.prductCardRadius,
                    width: state.selectedTime == timeSLotCubit.standardDelivaryTime[index] ? 1.5.w : 1.w,
                    alignment: Alignment.center,
                    child: CommonWidget.commonText(
                        text: timeSLotCubit.standardDelivaryTime[index],
                        color: state.selectedTime == timeSLotCubit.standardDelivaryTime[index]
                            ? appConstants.orderScreenSelectedCategoryColor
                            : appConstants.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget midnightDelivaryTime({required TimeSLotCubitLoadedState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: appConstants.black26),
              child: Radio(
                activeColor: appConstants.orderScreenSelectedCategoryColor,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: state.deliverytype.name,
                groupValue: OrderDelivaryType.values[1].name,
                onChanged: (value) {
                  timeSLotCubit.selectDelivaryType(
                      orderDelivaryType: OrderDelivaryType.midnight, state: state, time: timeSLotCubit.midnightTime[0]);
                },
              ),
            ),
            InkWell(
              onTap: () => timeSLotCubit.selectDelivaryType(
                  orderDelivaryType: OrderDelivaryType.midnight, state: state, time: timeSLotCubit.midnightTime[0]),
              child: CommonWidget.sizedBox(
                  child: CommonWidget.commonText(
                      text: TranslationConstants.midnight_delivery.translate(context), fontSize: 15)),
            )
          ],
        ),
        state.deliverytype.name == OrderDelivaryType.values[1].name
            ? CommonWidget.container(
                margin: EdgeInsets.only(top: 10.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: timeSLotCubit.midnightTime.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 10 / 3.1,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => timeSLotCubit.selectTime(time: timeSLotCubit.midnightTime[index], state: state),
                    child: CommonWidget.container(
                      color: state.selectedTime == timeSLotCubit.midnightTime[index]
                          ? appConstants.orderScreenSelectedCategoryColor.withOpacity(0.3)
                          : appConstants.white,
                      isBorder: true,
                      borderColor: state.selectedTime == timeSLotCubit.midnightTime[index]
                          ? appConstants.orderScreenSelectedCategoryColor
                          : appConstants.cookingWarning,
                      borderRadius: appConstants.prductCardRadius,
                      width: state.selectedTime == timeSLotCubit.midnightTime[index] ? 1.5.w : 1.w,
                      alignment: Alignment.center,
                      child: CommonWidget.commonText(
                          text: timeSLotCubit.midnightTime[index],
                          color: state.selectedTime == timeSLotCubit.midnightTime[index]
                              ? appConstants.orderScreenSelectedCategoryColor
                              : appConstants.black,
                          fontSize: 11),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget fixDelivaryTime({required TimeSLotCubitLoadedState state}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data: ThemeData(unselectedWidgetColor: appConstants.black26),
              child: Radio(
                activeColor: appConstants.orderScreenSelectedCategoryColor,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: state.deliverytype.name,
                groupValue: OrderDelivaryType.values[2].name,
                onChanged: (value) {
                  timeSLotCubit.selectDelivaryType(
                      orderDelivaryType: OrderDelivaryType.fixTime,
                      state: state,
                      time: timeSLotCubit.fixDelivaryTimes[0]);
                },
              ),
            ),
            InkWell(
                onTap: () => timeSLotCubit.selectDelivaryType(
                    orderDelivaryType: OrderDelivaryType.fixTime,
                    state: state,
                    time: timeSLotCubit.fixDelivaryTimes[0]),
                child: CommonWidget.sizedBox(
                    child: CommonWidget.commonText(
                        text: TranslationConstants.fix_time_delivery.translate(context), fontSize: 15)))
          ],
        ),
        state.deliverytype.name == OrderDelivaryType.values[2].name
            ? CommonWidget.container(
                margin: EdgeInsets.only(top: 10.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: timeSLotCubit.fixDelivaryTimes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 10 / 3.1,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => timeSLotCubit.selectTime(time: timeSLotCubit.fixDelivaryTimes[index], state: state),
                    child: CommonWidget.container(
                      color: state.selectedTime == timeSLotCubit.fixDelivaryTimes[index]
                          ? appConstants.orderScreenSelectedCategoryColor.withOpacity(0.3)
                          : appConstants.white,
                      isBorder: true,
                      borderColor: state.selectedTime == timeSLotCubit.fixDelivaryTimes[index]
                          ? appConstants.orderScreenSelectedCategoryColor
                          : appConstants.cookingWarning,
                      borderRadius: appConstants.prductCardRadius,
                      width: state.selectedTime == timeSLotCubit.fixDelivaryTimes[index] ? 1.5.w : 1.w,
                      alignment: Alignment.center,
                      child: CommonWidget.commonText(
                          text: timeSLotCubit.fixDelivaryTimes[index],
                          color: state.selectedTime == timeSLotCubit.fixDelivaryTimes[index]
                              ? appConstants.orderScreenSelectedCategoryColor
                              : appConstants.black,
                          fontSize: 11),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

//! Methods
  void setQuantityDropDownItems({
    required int productIndex,
    required OrderLoadedState state,
  }) {
    orderCubit.quantityDropDownItems.clear();
    for (var x in state.selectedProducts[productIndex].availableQuantity) {
      orderCubit.quantityDropDownItems.add(
        DropdownMenuItem(
          value: "${x.quantity} ${x.quantityType} ${x.price}",
          child: Row(
            children: [
              Expanded(child: CommonWidget.commonText(text: "${x.quantity} ${x.quantityType}")),
              CommonWidget.commonText(
                text: "${x.price}",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
  }

  void setCuponsDropDownItems({required OrderLoadedState state}) {
    orderCubit.cuponsDropDownItems.clear();
    for (var x in state.availableCupons) {
      orderCubit.cuponsDropDownItems.add(DropdownMenuItem(
        value: "${x.offerPersentage}${x.savedAmount}${x.maxAmt}",
        child: Row(children: [
          CommonWidget.commonText(
              text: "%${x.offerPersentage} OFF up to ${x.maxAmt..formatCurrency()}",
              fontSize: 13,
              fontWeight: FontWeight.bold),
          const Spacer(),
          CommonWidget.commonText(
              text: "${TranslationConstants.save.translate(context)} ${x.savedAmount..formatCurrency()}",
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ]),
      ));
    }
  }
}
