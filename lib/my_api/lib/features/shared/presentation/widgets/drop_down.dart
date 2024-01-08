// ignore_for_file: must_be_immutable, library_private_types_in_public_api, no_logic_in_create_state

import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownButton extends StatefulWidget {
  final String selectedOptions;
  final List<String>? dataList;
  final Function(String option) onOptionSelected;
  final bool useTextField;
  Widget? dropDownWidget;
  double? fontSize;
  double? height;
  double? scrolllingHeight;
  double? size;
  TextStyle? style;
  EdgeInsetsGeometry? padding;
  VoidCallback? onTap;
  AlignmentGeometry? titleTextAlignment;
  double? mainContainerRadius;
  CustomDropdownButton({
    required this.selectedOptions,
    required this.onOptionSelected,
    required this.useTextField,
    this.dataList,
    this.dropDownWidget,
    this.fontSize,
    this.height,
    this.style,
    this.padding,
    this.onTap,
    this.size,
    this.scrolllingHeight,
    this.titleTextAlignment,
    this.mainContainerRadius,
    super.key,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState(selectedOptions, dataList ?? []);
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> with SingleTickerProviderStateMixin {
  String optionItemSelected;
  List<String> dataList;
  late AnimationController expandController;
  late Animation<double> animation;
  late ToggleCubit toggleCubit;
  late DropDownCubit dropDownCubit;
  TextEditingController searchController = TextEditingController();
  _CustomDropdownButtonState(this.optionItemSelected, this.dataList);

  @override
  void initState() {
    super.initState();
    toggleCubit = getItInstance<ToggleCubit>();
    dropDownCubit = getItInstance<DropDownCubit>();
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    dropDownCubit.searchList = dataList;
    runExpandCheck();
  }

  void runExpandCheck() {
    if (toggleCubit.state) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    toggleCubit.close();
    dropDownCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return relationDropDownWidget(context: context);
  }

  Widget relationDropDownWidget({required BuildContext context}) {
    return BlocBuilder<DropDownCubit, double>(
      bloc: dropDownCubit,
      builder: (context, state) {
        return BlocBuilder<ToggleCubit, bool>(
          bloc: toggleCubit,
          builder: (context, relationstate) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    toggleCubit.setValue(value: !toggleCubit.state);
                    runExpandCheck();
                    // widget.onTap!.call();
                  },
                  child: Container(
                    padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: appConstants.white,
                      border: Border.all(color: const Color(0xff084277).withOpacity(0.4), width: 1.2.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: widget.titleTextAlignment ?? Alignment.center,
                            child: CommonWidget.commonText(
                              text: optionItemSelected,
                              style: widget.style ??
                                  TextStyle(
                                    color: const Color(0xff293847),
                                    fontSize: widget.fontSize ?? 20.sp,
                                  ),
                            ),
                          ),
                        ),
                        Icon(
                          toggleCubit.state ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
                          size: widget.size ?? 26.r,
                          color: const Color(0xff293847),
                        ),
                      ],
                    ),
                  ),
                ),
                SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: animation,
                  child: Container(
                    height: widget.height ?? 200,
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: const Color(0xffffffff),
                      border: Border.all(color: const Color(0xff084277).withOpacity(0.2)),
                    ),
                    child: _buildDropListOptions(context: context, dataList: dataList),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDropListOptions({
    required BuildContext context,
    required List<String> dataList,
  }) {
    return widget.dropDownWidget ??
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.useTextField
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: SizedBox(
                      height: 35.h,
                      child: TextField(
                        cursorColor: const Color(0xff084277),
                        controller: searchController,
                        onChanged: (v) => dropDownCubit.onSearchTextChanged(dataList: dataList, text: v),
                        decoration: InputDecoration(
                          hintText: "Search..",
                          contentPadding: EdgeInsets.only(top: 10.h, left: 10.w),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: const Color(0xff084277).withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                              color: Color(0xff4392F1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: const Color(0xff084277).withOpacity(0.5),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          hintStyle: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Scrollbar(
              child: SizedBox(
                height: widget.scrolllingHeight,
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dropDownCubit.searchList
                        .map(
                          (option) => GestureDetector(
                            onTap: () {
                              optionItemSelected = option;
                              toggleCubit.setValue(value: false);
                              expandController.reverse();
                              widget.onOptionSelected(option);
                              FocusScopeNode currentFocus = FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: widget.dropDownWidget ??
                                Container(
                                  color: option.compareTo(optionItemSelected) == 0
                                      ? const Color(0xff4392F1)
                                      : Colors.transparent,
                                  width: ScreenUtil().screenWidth,
                                  padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
                                  child: CommonWidget.commonText(
                                    text: option,
                                    style: const TextStyle(color: Colors.black),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
