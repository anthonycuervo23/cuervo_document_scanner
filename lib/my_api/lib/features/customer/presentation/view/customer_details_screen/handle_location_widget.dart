import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/location_picker_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/handle_location_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:flutter/material.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class HandleLoctionWidget extends State<HandleLocationScreen> {
  late CounterCubit counterCubitForAddressType;
  late CounterCubit counterCubitForLocationField;
  TextEditingController flatNo = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController txtaddress = TextEditingController();
  Addresstype selectedAddress = Addresstype.home;
  @override
  void initState() {
    counterCubitForAddressType = getItInstance<CounterCubit>();
    counterCubitForLocationField = getItInstance<CounterCubit>();
    loadData(widget.args.navigateFrom);
    super.initState();
  }

  Widget shippingAddview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfileText(text: TranslationConstants.address_type.translate(context)),
            selectAddressType(),
            CommonWidget.sizedBox(height: 10),
            textfileText(text: TranslationConstants.flat_no_building_name.translate(context)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: textformfield(
                controller: flatNo,
                hintText: TranslationConstants.enter_flate_building_name.translate(context),
                keyboardType: TextInputType.name,
                maxline: 3,
              ),
            ),
            CommonWidget.sizedBox(height: 10),
            textfileText(
              text: TranslationConstants.area_locality.translate(context),
            ),
            areaAndLocalationfield(),
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
                controller: landMark,
                hintText: TranslationConstants.enter_nearby.translate(context),
                keyboardType: TextInputType.name,
                maxline: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectAddressType() {
    bool update = false;
    return BlocBuilder<CounterCubit, int>(
      bloc: counterCubitForAddressType,
      builder: (context, state) {
        update == true ? changeAddressType(index: state) : null;
        return Row(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                update = true;
                counterCubitForAddressType.chanagePageIndex(index: index);
              },
              child: addressTypeContainer(state, index, context),
            ),
          ),
        );
      },
    );
  }

  Widget areaAndLocalationfield() {
    return BlocBuilder<CounterCubit, int>(
      bloc: counterCubitForLocationField,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: InkWell(
            onTap: () async {
              String? address = (await CommonRouter.pushNamed(RouteList.location_picker_screen,
                  arguments: LocationPickerScreenArguments(
                      navigationFrom: widget.args.navigateFrom, address: widget.args.address ?? ""))) as String?;
              if (address != null) {
                txtaddress = TextEditingController(text: address);
                counterCubitForLocationField.reloadState();
              }
            },
            child: textformfield(
                enable: false,
                controller: txtaddress,
                hintText: TranslationConstants.enter_area_locality.translate(context),
                keyboardType: TextInputType.name,
                maxline: 3),
          ),
        );
      },
    );
  }

  Widget addressTypeContainer(int state, int index, BuildContext context) {
    return CommonWidget.container(
      height: 45,
      width: 75,
      isBorder: true,
      alignment: Alignment.center,
      color: Addresstype.values[index] == selectedAddress ? appConstants.deslectedBackGroundColor : null,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
      borderColor:
          Addresstype.values[index] == selectedAddress ? appConstants.editbuttonColor : appConstants.neutral6Color,
      borderRadius: 8.r,
      child: CommonWidget.commonText(
        text: Addresstype.values[index].name.toCamelcase(),
        style: Theme.of(context).textTheme.caption1BoldHeading.copyWith(
            color: Addresstype.values[index] == selectedAddress
                ? appConstants.editbuttonColor
                : appConstants.neutral1Color,
            fontSize: 15),
      ),
    );
  }

  Widget textfileText({required String text, FocusNode? focusNode1}) {
    return CommonWidget.commonText(text: text, fontSize: 13, fontWeight: FontWeight.bold, color: appConstants.black);
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

  void loadData(CheckLoactionNavigation navigateFrom) {
    if (navigateFrom == CheckLoactionNavigation.updateAddress) {
      flatNo = TextEditingController(text: widget.args.flanNo);
      landMark = TextEditingController(text: widget.args.landmark);
      txtaddress = TextEditingController(text: widget.args.address);
      selectedAddress = widget.args.addresstype!;
    }
  }

  void changeAddressType({required int index}) {
    if (index == 0) {
      selectedAddress = Addresstype.home;
    } else if (index == 1) {
      selectedAddress = Addresstype.work;
    } else {
      selectedAddress = Addresstype.other;
    }
  }
}
