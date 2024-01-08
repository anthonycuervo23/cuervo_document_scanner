import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/create_combo/create_combo_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/create_combo/create_combo_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: constant_identifier_names
enum ComboType { Edit, Create }

class CreateComboScreen extends StatefulWidget {
  final ComboType comboType;
  const CreateComboScreen({super.key, required this.comboType});

  @override
  State<CreateComboScreen> createState() => _CreateComboScreenState();
}

class _CreateComboScreenState extends CreateComboWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        context,
        title: widget.comboType == ComboType.Edit
            ? TranslationConstants.edit_combo.translate(context)
            : TranslationConstants.create_combo.translate(context),
        titleCenter: false,
        elevation: 1,
        shadowcolor: appConstants.black54,
        shadowColor: true,
        onTap: () => CommonRouter.pop(),
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        child: BlocBuilder<CreateComboCubit, CreateComboState>(
          bloc: createComboCubit,
          builder: (context, state) {
            if (state is CreateComboLoadedState) {
              return screenView(context: context, state: state, comboType: widget.comboType);
            }
            if (state is CreateComboLoadedState) {
              return Center(child: CommonWidget.loadingIos());
            }
            if (state is CreateComboErrorState) {
              return CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: state.errorMessage);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
