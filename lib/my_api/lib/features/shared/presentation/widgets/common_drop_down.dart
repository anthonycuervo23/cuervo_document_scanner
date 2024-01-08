// ignore_for_file: prefer_const_constructors

import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final String hint;
  final TextEditingController searchController;
  final AddNewProductLoadedState state;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hint,
    required this.searchController,
    required this.state,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Color(0xff084277).withOpacity(0.5),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.black,
              size: 40.r,
            ),
          ),
          hint: Text(
            widget.hint,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          onChanged: widget.onChanged,
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(
              left: 10.h,
            ),
            height: 40.h,
            width: 200.w,
          ),
          dropdownStyleData: DropdownStyleData(
            scrollPadding: EdgeInsets.only(right: 10.w),
            elevation: 2,
            offset: Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: Radius.circular(10.r),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Color(0xff084277).withOpacity(0.5),
              ),
            ),
            maxHeight: 200.h,
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 35.h,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: widget.searchController,
            searchInnerWidgetHeight: 50.h,
            searchInnerWidget: Container(
              height: 50.h,
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 4.h,
                right: 12.w,
                left: 12.w,
              ),
              child: TextFormField(
                cursorColor: Color(0xff084277),
                expands: true,
                maxLines: null,
                controller: widget.searchController,
                onTap: () {
                  widget.searchController.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.searchController.text.length),
                  );
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  hintText: '',
                  hintStyle: TextStyle(fontSize: 12.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: Color(0xff084277).withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: Color(0xff4392F1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: Color(0xff084277).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue.toCamelcase());
            },
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              widget.searchController.clear();
            }
          },
        ),
      ),
    );
  }
}
