import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/widgets/textformfieldEditProfile.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDropdown extends StatefulWidget {
  final String selectedOptions;
  final List<String> dataList;
  final Function(String option) onOptionSelected;
  const CommonDropdown({
    super.key,
    required this.selectedOptions,
    required this.dataList,
    required this.onOptionSelected,
  });

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> with SingleTickerProviderStateMixin {
  late String optionItemSelected;
  late List<String> dataList;
  late AnimationController expandController;
  late Animation<double> animation;
  late ToggleCubit toggleCubit;
  ScrollController scollBarController = ScrollController();

  @override
  void initState() {
    super.initState();
    optionItemSelected = widget.selectedOptions;
    dataList = widget.dataList;
    toggleCubit = getItInstance<ToggleCubit>();
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (toggleCubit.state) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return relationDropDownWidget(context: context);
  }

  Widget relationDropDownWidget({required BuildContext context}) {
    return BlocBuilder<ToggleCubit, bool>(
      bloc: toggleCubit,
      builder: (context, relationstate) {
        return Column(
          children: <Widget>[
            textFormFieldEditProfile(
              context: context,
              controller: TextEditingController(text: optionItemSelected),
              hintText: TranslationConstants.choose_relationship.translate(context),
              readonly: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return TranslationConstants.choose_relationship.translate(context);
                }
                return null;
              },
              onTap: () {
                // await familyDobSelect(state, index, editProfileCubit);
                toggleCubit.setValue(value: !toggleCubit.state);
                _runExpandCheck();
              },
              suffixwidget: Padding(
                padding: EdgeInsets.all(13.r),
                child: Icon(
                  toggleCubit.state ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 30.r,
                  color: appConstants.default1Color,
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(appConstants.buttonRadius),
            //     color: appConstants.whiteBackgroundColor,
            //     border: Border.all(color: appConstants.default6Color, width: 1.2.r),
            //   ),
            //   child: GestureDetector(
            //     onTap: () {
            //       toggleCubit.setValue(value: !toggleCubit.state);
            //       _runExpandCheck();
            //     },
            //     child: Row(
            //       mainAxisSize: MainAxisSize.max,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         Expanded(
            //           child: Text(
            //             optionItemSelected.isNotEmpty
            //                 ? optionItemSelected
            //                 : TranslationConstants.please_select_option.translate(context),
            //             style: optionItemSelected.isNotEmpty
            //                 ? Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color)
            //                 : Theme.of(context).textTheme.bodyBookHeading.copyWith(
            //                       color: appConstants.default5Color,
            //                     ),
            //           ),
            //         ),
            //         Icon(
            //           toggleCubit.state ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            //           size: 26.r,
            //           color: appConstants.default1Color,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: appConstants.whiteBackgroundColor,
                  border: Border.all(
                    color: toggleCubit.state ? appConstants.default6Color : appConstants.greyBackgroundColor,
                    width: 1.2.r,
                  ),
                ),
                child: SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: animation,
                  child: _buildDropListOptions(context: context, dataList: dataList),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropListOptions({
    required BuildContext context,
    required List<String> dataList,
  }) {
    return Container(
      constraints: BoxConstraints(maxHeight: 150.h),
      child: RawScrollbar(
        thumbVisibility: true,
        controller: scollBarController,
        radius: Radius.circular(10.r),
        child: SingleChildScrollView(
          controller: scollBarController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dataList
                .map(
                  (option) => GestureDetector(
                    onTap: () {
                      optionItemSelected = option;
                      toggleCubit.setValue(value: false);
                      expandController.reverse();
                      widget.onOptionSelected(option);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().screenWidth,
                          padding: EdgeInsets.only(top: 10.h, right: 5.w, left: 8.w, bottom: 5.h),
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                                  color: appConstants.default1Color,
                                ),
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Divider(
                            height: 1,
                            color: dataList.last != option ? appConstants.default9Color : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
