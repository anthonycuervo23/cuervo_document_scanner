import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/refer_list/presentation/view/refer_list_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/sort_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferListScreen extends StatefulWidget {
  final List<ReferDetailModel> referData;
  const ReferListScreen({super.key, required this.referData});

  @override
  State<ReferListScreen> createState() => _ReferListScreenState();
}

class _ReferListScreenState extends ReferListWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.backGroundColor,
      appBar: CustomAppBar(
        context,
        title: TranslationConstants.refer_list.translate(context),
        titleCenter: false,
        onTap: () => CommonRouter.pop(),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: commonSearchAndFilterField(
              context: context,
              controller: TextEditingController(),
              onChanged: (v) {},
              onTapSearchCalenderButton: () {
                searchFilterDialog(context: context, searchFilterCubit: searchFilterCubit);
              },
              onTapForFilter: () {
                sortFilterDialog(context: context, counterCubit: counterCubit, sortFilterCubit: sortFilterCubit);
              },
            ),
          ),

          // buildTable(),
          dataTable()
        ],
      ),
    );
  }
}
