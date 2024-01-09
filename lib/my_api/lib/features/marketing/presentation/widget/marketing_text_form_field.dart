import 'package:flutter/material.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextFormField marketingTextformfield({
  required TextEditingController controller,
  dynamic validator,
  dynamic onSaved,
  required dynamic hintText,
  VoidCallback? oncalenderTap,
  Color? fillcolor,
  Widget? suffixwidget,
  BoxConstraints? suffixIconConstraints,
  int? maxlength,
  int maxline = 1,
  readonly = false,
  dynamic keyboardType,
  VoidCallback? onTap,
  bool? isEnable,
  InputBorder? enabledBorder,
  InputBorder? focusedBorder,
  InputBorder? errorBorder,
  InputBorder? focusedErrorBorder,
  InputBorder? disabledBorder,
  List<TextInputFormatter>? inputFormatters,
  required BuildContext context,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTap,
    enabled: isEnable ?? true,
    maxLines: maxline,
    validator: validator,
    onSaved: onSaved,
    maxLength: maxlength,
    readOnly: readonly,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    style: TextStyle(color: appConstants.black),
    scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10.0),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      counterText: "",
      fillColor: Colors.white,
      filled: true,
      suffixIconConstraints: suffixIconConstraints,
      suffixIcon: suffixwidget ?? const SizedBox.shrink(),
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(color: appConstants.neutral6Color.withOpacity(0.6), fontSize: 13.sp),
      disabledBorder: disabledBorder ??
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: appConstants.theme1Color.withOpacity(0.3))),
      enabledBorder: enabledBorder ??
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: appConstants.theme1Color.withOpacity(0.3))),
      focusedBorder: focusedBorder ??
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: appConstants.theme1Color.withOpacity(0.3))),
      errorBorder: errorBorder ??
          OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: appConstants.red)),
      focusedErrorBorder: focusedErrorBorder ??
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: appConstants.theme1Color.withOpacity(0.3))),
    ),
  );
}
