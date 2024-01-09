// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_state.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/edit_profile/edit_profile_widget.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  final UserNewOld userNewOld;
  const EditProfileScreen({super.key, required this.userNewOld});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends EditProfileWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      bloc: editProfileCubit,
      builder: (contex, state) {
        if (state is EditProfileLoadedState) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) return;
              if (widget.userNewOld == UserNewOld.newUser) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  CommonRouter.popUntil(RouteList.app_home);
                  BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
                }
                SystemNavigator.pop();
              } else {
                final navigator = Navigator.of(context);
                var value = await bakeButtonPopup(state: state, context: contex);
                if (value) {
                  navigator.pop();
                }
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: appConstants.whiteBackgroundColor,
              appBar: customAppBar(
                context,
                backArrow: widget.userNewOld == UserNewOld.newUser ? false : true,
                textColor: appConstants.default1Color,
                onTap: () async {
                  var value = await bakeButtonPopup(state: state, context: contex);
                  if (value) {
                    CommonRouter.pop();
                  }
                },
                title: widget.userNewOld == UserNewOld.oldUser
                    ? TranslationConstants.edit_profile.translate(context)
                    : TranslationConstants.my_profile.translate(context),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 18.h, right: 18.h, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      uploadImage(context: context, state: state),
                      userDetails(context: context, state: state),
                      familyDetails(context: context, state: state),
                      saveButton(context: context, state: state, userNewOld: widget.userNewOld),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is EditProfileLoadingState || state is EditProfileImagePicked) {
          return Center(child: CommonWidget.loadingIos());
        } else if (state is EditProfileErrorState) {
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
    );
  }

  Future<bool> bakeButtonPopup({required EditProfileLoadedState state, required BuildContext context}) async {
    if (isProfileUpdated(oldData: state.userDataEntity, cubit: editProfileCubit)) {
      var data = await CommonWidget.showAlertDialog(
        context: context,
        isTitle: true,
        titleText: TranslationConstants.confirm_delete.translate(context),
        text: TranslationConstants.sure_delete_favorite_item.translate(context),
        textColor: appConstants.default3Color,
      );
      return data;
    }
    return true;
  }
}
