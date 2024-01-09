// ignore_for_file: depend_on_referenced_packages

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class PolicyScreen extends StatefulWidget {
  final TypeOfPolicy typeOfPolicy;

  const PolicyScreen({super.key, required this.typeOfPolicy});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late PolicyCubit policyCubit;

  @override
  void initState() {
    policyCubit = getItInstance<PolicyCubit>();
    policyCubit.loadInitialData(typeOfPolicy: widget.typeOfPolicy);
    super.initState();
  }

  @override
  void dispose() {
    policyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(context, onTap: () => CommonRouter.pop()),
      body: BlocBuilder(
        bloc: policyCubit,
        builder: (context, state) {
          if (state is PolicyLoadedState) {
            PolicyEntity policyDataEntity = state.policyDataEntity;
            dom.Document document = htmlparser.parse(policyDataEntity.description);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.commonPadding(
                  child: CommonWidget.commonText(
                    text: policyDataEntity.title,
                    style: Theme.of(context).textTheme.h3BoldHeading.copyWith(color: appConstants.default1Color),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Divider(color: appConstants.default7Color, height: 1.h, thickness: 2),
                ),
                Html.fromDom(document: document)
              ],
            );
          } else if (state is PolicyLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is PolicyErrorState) {
          return CommonWidget.dataNotFound(
              context: context,
              heading: TranslationConstants.something_went_wrong.translate(context),
              subHeading: state.errorMessage,
              buttonLabel: TranslationConstants.try_again.translate(context),
              // onTap: () => productCategoryCubit.getCategory(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
