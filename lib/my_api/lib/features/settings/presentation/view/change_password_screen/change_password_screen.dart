import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/core/build_context.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/change_password_screen/change_password_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ChangePasswordWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(buildContext);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: appBar(),
        body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          bloc: changePasswordCubit,
          builder: (context, state) {
            if (state is ChangePasswordLoadedState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  children: [
                    commonTextField(
                      titleText: TranslationConstants.currunt_password.translate(context),
                      hintText: TranslationConstants.currunt_password.translate(context),
                      onIconTab: () {
                        changePasswordCubit.changeVisibilities(
                          state: state,
                          textFieldTypes: TextFieldType.curruntPassword,
                        );
                      },
                      state: state,
                      icon: state.isVisibleCurruntPassword ?? false == true
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      obscureText: !(state.isVisibleCurruntPassword ?? false),
                    ),
                    CommonWidget.sizedBox(height: 10),
                    commonTextField(
                      titleText: TranslationConstants.new_password.translate(context),
                      hintText: TranslationConstants.new_password.translate(context),
                      onIconTab: () {
                        changePasswordCubit.changeVisibilities(
                          state: state,
                          textFieldTypes: TextFieldType.newPassword,
                        );
                      },
                      obscureText: !(state.isVisibleNewPassword ?? false),
                      state: state,
                      icon: state.isVisibleNewPassword == true
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    CommonWidget.sizedBox(height: 10),
                    commonTextField(
                      titleText: TranslationConstants.confirm_password.translate(context),
                      hintText: TranslationConstants.confirm_password.translate(context),
                      obscureText: !(state.isVisibleConfirmPassword ?? false),
                      onIconTab: () {
                        changePasswordCubit.changeVisibilities(
                          state: state,
                          textFieldTypes: TextFieldType.confirmPassword,
                        );
                      },
                      state: state,
                      icon: state.isVisibleConfirmPassword == true
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ],
                ),
              );
            } else if (state is ChangePasswordLoadingState) {
              const Center(child: CircularProgressIndicator());
            } else if (state is ChangePasswordErrorState) {
              return Center(child: Text(state.errorMessage));
            }

            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: upDatePasswordButton(),
      ),
    );
  }
}
