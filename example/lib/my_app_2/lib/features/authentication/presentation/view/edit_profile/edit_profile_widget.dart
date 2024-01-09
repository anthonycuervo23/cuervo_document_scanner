// ignore_for_file: void_checks

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_state.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/edit_profile/edit_profile_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/widgets/textformfieldEditProfile.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class EditProfileWidget extends State<EditProfileScreen> {
  late EditProfileCubit editProfileCubit;
  late AuthenticationCubit authenticationCubit;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> familyDetailsFormKey = GlobalKey<FormState>();
  bool isRelationSelected = false;

  @override
  void initState() {
    editProfileCubit = getItInstance<EditProfileCubit>();
    authenticationCubit = getItInstance<AuthenticationCubit>();
    editProfileCubit.userDataLoad(userDataEntity: userEntity);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    editProfileCubit.loadingCubit.hide();
    authenticationCubit.loadingCubit.hide();
    editProfileCubit.close();
    authenticationCubit.close();
  }

  Widget userDetails({required BuildContext context, required EditProfileLoadedState state}) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.sizedBox(height: 15),
          titleOfTextField(text: TranslationConstants.full_name.translate(context), isRequired: true),
          textFormFieldEditProfile(
            context: context,
            controller: editProfileCubit.nameController,
            hintText: TranslationConstants.enter_name.translate(context),
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.this_field_is_required.translate(context);
              }
              return null;
            },
            onChanged: (value) {
              if (value.isEmpty || value.length == 1) {
                formKey.currentState!.validate();
              }
            },
          ),
          Visibility(
            visible: widget.userNewOld != UserNewOld.newUser || state.userDataEntity.email.isNotEmpty,
            child: titleOfTextField(
              text: TranslationConstants.email_id.translate(context),
              isFieldDisable: state.userDataEntity.email.isNotEmpty,
            ),
          ),
          Visibility(
            visible: widget.userNewOld != UserNewOld.newUser || state.userDataEntity.email.isNotEmpty,
            child: textFormFieldEditProfile(
              context: context,
              controller: editProfileCubit.emailController,
              hintText: TranslationConstants.enter_email_id.translate(context),
              suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
              onChanged: (value) {
                if (value.isEmpty || value.length == 1) {
                  formKey.currentState!.validate();
                }
              },
              enabled: state.userDataEntity.email.isNotEmpty ? false : true,
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                    color:
                        state.userDataEntity.email.isNotEmpty ? appConstants.default4Color : appConstants.default1Color,
                  ),
              suffixwidget: state.userDataEntity.email.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
                        height: 18.r,
                        width: 18.r,
                        color: appConstants.default4Color,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 5.w),
                      child: CommonWidget.commonButton(
                        context: context,
                        width: 60.w,
                        borderRadius: 5.r,
                        textColor: appConstants.buttonTextColor,
                        alignment: Alignment.center,
                        text: TranslationConstants.verify.translate(context),
                        style: Theme.of(context)
                            .textTheme
                            .captionMediumHeading
                            .copyWith(color: appConstants.buttonTextColor),
                        onTap: () async {
                          CommonWidget.keyboardClose(context: context);
                          if (editProfileCubit.emailController.text.isEmpty) {
                            CustomSnackbar.show(
                              snackbarType: SnackbarType.ERROR,
                              message: TranslationConstants.enter_email_id.translate(context),
                            );
                          } else {
                            editProfileCubit.updateLoginDetail(
                              userNewOld: UserNewOld.oldUser,
                              updateLoginDetailsParams: UpdateLoginDetailsParams(
                                loginType: LogintType.email,
                                countryCode: TranslationConstants.num_ninie_one.translate(context),
                                mobileNumber: authenticationCubit.mobileController.text,
                                email: editProfileCubit.emailController.text,
                              ),
                            );
                          }
                        },
                      ),
                    ),
            ),
          ),
          Visibility(
            visible: widget.userNewOld != UserNewOld.newUser || state.userDataEntity.mobile.isNotEmpty,
            child: titleOfTextField(
              text: TranslationConstants.mobile_number.translate(context),
              isFieldDisable: state.userDataEntity.mobile.isNotEmpty,
            ),
          ),
          Visibility(
            visible: widget.userNewOld != UserNewOld.newUser || state.userDataEntity.mobile.isNotEmpty,
            child: textFormFieldEditProfile(
              context: context,
              controller: editProfileCubit.numberController,
              hintText: TranslationConstants.enter_mobile_number.translate(context),
              maxlength: 11,
              inputFormatters: [PhoneNumberFormatter()],
              keyboardType: TextInputType.number,
              enabled: state.userDataEntity.mobile.isNotEmpty ? false : true,
              suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                    color: state.userDataEntity.mobile.isNotEmpty
                        ? appConstants.default4Color
                        : appConstants.default1Color,
                  ),
              suffixwidget: state.userDataEntity.mobile.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
                        height: 18.r,
                        width: 18.r,
                        color: appConstants.default4Color,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CommonWidget.commonButton(
                        context: context,
                        width: 60.w,
                        borderRadius: 5.r,
                        textColor: appConstants.buttonTextColor,
                        alignment: Alignment.center,
                        text: TranslationConstants.verify.translate(context),
                        style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                              color: appConstants.buttonTextColor,
                            ),
                        onTap: () {
                          CommonWidget.keyboardClose(context: context);
                          if (state.userDataEntity.mobile.isEmpty) {}
                          if (editProfileCubit.numberController.text.trim().replaceAll(' ', '').length == 10) {
                            // CommonRouter.pushNamed(RouteList.otp_verification, arguments: phoneNumber);
                            // authenticationCubit.generateOtpMobile(mobilenumber: editProfileCubit.numberController.text);
                            editProfileCubit.updateLoginDetail(
                              userNewOld: UserNewOld.oldUser,
                              updateLoginDetailsParams: UpdateLoginDetailsParams(
                                loginType: LogintType.phone,
                                countryCode: '+91',
                                mobileNumber: editProfileCubit.numberController.text.trim().replaceAll(' ', ''),
                                email: state.userDataEntity.email,
                              ),
                            );
                          } else {
                            if (state.userDataEntity.mobile.isEmpty) {
                              CustomSnackbar.show(
                                snackbarType: SnackbarType.ERROR,
                                message: TranslationConstants.enter_mobile_number.translate(context),
                              );
                            } else {
                              CustomSnackbar.show(
                                snackbarType: SnackbarType.ERROR,
                                message: TranslationConstants.enter_valid_phone_number.translate(context),
                              );
                            }
                          }
                        },
                      ),
                    ),
            ),
          ),
          titleOfTextField(text: TranslationConstants.date_of_birth.translate(context), isRequired: true),
          textFormFieldEditProfile(
            context: context,
            controller: TextEditingController(text: state.userDataEntity.dob),
            hintText: TranslationConstants.DD_MM_YYYY.translate(context),
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.this_field_is_required.translate(context);
              }
              return null;
            },
            onTap: () async {
              List<DateTime> selectedDate = await CommonWidget.datePicker(
                context: context,
                minDate: DateTime(DateTime.now().year - 100),
                isRangeDate: false,
                maxDate: DateTime.now(),
              );
              String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
              editProfileCubit.setDate(
                state: state,
                userEntity: state.userDataEntity.copyWith(dob: formattedDate),
              );
            },
            readonly: true,
            suffixwidget: Padding(
              padding: EdgeInsets.all(13.r),
              child: CommonWidget.imageButton(
                svgPicturePath: "assets/photos/svg/common/calender.svg",
                iconSize: 6.r,
                boxFit: BoxFit.fill,
                onTap: () async {
                  List<DateTime> selectedDate = await CommonWidget.datePicker(
                    context: context,
                    minDate: DateTime(DateTime.now().year - 100),
                    isRangeDate: false,
                    maxDate: DateTime.now(),
                  );
                  String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
                  editProfileCubit.setDate(
                    state: state,
                    userEntity: state.userDataEntity.copyWith(dob: formattedDate),
                  );
                },
              ),
            ),
          ),
          titleOfTextField(text: TranslationConstants.anniversary_date.translate(context)),
          textFormFieldEditProfile(
            context: context,
            controller: TextEditingController(text: state.userDataEntity.anniversaryDate),
            hintText: TranslationConstants.DD_MM_YYYY.translate(context),
            onTap: () async {
              List<DateTime> selectedDate = await CommonWidget.datePicker(
                context: context,
                minDate: DateTime(DateTime.now().year - 100),
                isRangeDate: false,
                maxDate: DateTime.now(),
              );
              String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
              editProfileCubit.setDate(
                state: state,
                userEntity: state.userDataEntity.copyWith(anniversaryDate: formattedDate),
              );
            },
            readonly: true,
            suffixwidget: Padding(
              padding: EdgeInsets.all(13.r),
              child: state.userDataEntity.anniversaryDate.isEmpty
                  ? CommonWidget.imageButton(
                      svgPicturePath: "assets/photos/svg/common/calender.svg",
                      iconSize: 6.r,
                      boxFit: BoxFit.fill,
                      onTap: () async {
                        List<DateTime> selectedDate = await CommonWidget.datePicker(
                          context: context,
                          minDate: DateTime(DateTime.now().year - 100),
                          isRangeDate: false,
                          maxDate: DateTime.now(),
                        );
                        String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
                        editProfileCubit.setDate(
                          state: state,
                          userEntity: state.userDataEntity.copyWith(anniversaryDate: formattedDate),
                        );
                      },
                    )
                  : InkWell(
                      onTap: () {
                        editProfileCubit.setDate(
                          state: state,
                          userEntity: state.userDataEntity.copyWith(anniversaryDate: ''),
                        );
                      },
                      child: CommonWidget.commonIcon(
                        icon: Icons.cancel,
                        iconSize: 18.r,
                        iconColor: appConstants.primary1Color,
                      ),
                    ),
            ),
          ),
          titleOfTextField(text: TranslationConstants.flat_no_building_name.translate(context), isRequired: true),
          textFormFieldEditProfile(
            controller: editProfileCubit.flatNumberController,
            hintText: TranslationConstants.enter_flate_building_name.translate(context),
            context: context,
            maxline: 3,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              if (value.isEmpty || value.length == 1) {
                formKey.currentState!.validate();
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return TranslationConstants.this_field_is_required.translate(context);
              }
              return null;
            },
          ),
          titleOfTextField(text: TranslationConstants.area_sector_locality.translate(context), isRequired: true),
          GestureDetector(
            onTap: () async {
              PermissionStatus status = await Permission.location.request();
              if (status.isGranted) {
                if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                  var args = await CommonRouter.pushNamed(
                    RouteList.location_picker_screen,
                    arguments: const LoactionArguments(
                      checkLoactionNavigator: CheckLoactionNavigation.cart,
                      isNew: true,
                      isEditProfile: true,
                    ),
                  );
                  if (args is AddressScreenArguments) {
                    editProfileCubit.areaController.text = args.fullAddress;
                    editProfileCubit.setData(latitude: args.latitude, longitude: args.longitude);
                  }
                } else {
                  CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: "Please enalble location");
                }
              } else if (status.isPermanentlyDenied) {
                CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: "Location permission Required");
                await Future.delayed(const Duration(seconds: 1)).then((value) => openAppSettings());
              } else {
                CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: "Location permission Required");
              }
            },
            child: textFormFieldEditProfile(
              hintText: TranslationConstants.enter_area_loclity.translate(context),
              controller: editProfileCubit.areaController,
              enabled: false,
              context: context,
              maxline: 3,
              suffixwidget: CommonWidget.sizedBox(
                width: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CommonWidget.sizedBox(
                      height: 40,
                      child: VerticalDivider(
                        width: 5,
                        color: appConstants.default6Color,
                        thickness: 1.5.r,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/edit_profile/location.svg",
                        ),
                        CommonWidget.commonText(
                          text: TranslationConstants.use_map.translate(context),
                          style: Theme.of(context)
                              .textTheme
                              .overLineMediumHeading
                              .copyWith(color: appConstants.default1Color),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              titleOfTextField(text: TranslationConstants.nearby_landmark.translate(context), isRequired: false),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h, top: 18.h),
                child: Text(
                  ' (${TranslationConstants.optional.translate(context)})',
                  style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default5Color),
                ),
              ),
            ],
          ),
          textFormFieldEditProfile(
            context: context,
            controller: editProfileCubit.landmarkController,
            keyboardType: TextInputType.streetAddress,
            hintText: TranslationConstants.enter_nearby.translate(context),
          ),
        ],
      ),
    );
  }

  Widget familyDetails({required BuildContext context, required EditProfileLoadedState state}) {
    return Form(
      key: familyDetailsFormKey,
      child: Column(
        children: [
          Row(
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.family_details.translate(context),
                style: Theme.of(context)
                    .textTheme
                    .subTitle2BoldHeading
                    .copyWith(color: appConstants.default1Color, height: 2),
              ),
              CommonWidget.commonText(
                text: ' (${TranslationConstants.optional.translate(context)})',
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default5Color,
                      height: 1,
                    ),
              ),
              const Spacer(),
              CommonWidget.toggleButton(
                value: state.userDataEntity.familyDetailsShow,
                onChanged: (bool value) {
                  editProfileCubit.setDate(
                    state: state,
                    userEntity: state.userDataEntity.copyWith(familyDetailsShow: value),
                  );
                },
              ),
            ],
          ),
          Visibility(
            visible: state.userDataEntity.familyDetailsShow,
            child: Column(
              children: [
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: state.userDataEntity.familtyInfo.length,
                  itemBuilder: (context, index) {
                    return addFamilyDetailBox(
                      editProfileCubit: editProfileCubit,
                      index: index,
                      state: state,
                    );
                  },
                ),
                CommonWidget.sizedBox(height: 5),
                CommonWidget.commonButton(
                  context: context,
                  height: 45.h,
                  alignment: Alignment.center,
                  isBorder: true,
                  text: TranslationConstants.add_member.translate(context),
                  style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.primary1Color),
                  color: appConstants.buttonTextColor,
                  borderColor: appConstants.primary1Color,
                  textColor: appConstants.primary1Color,
                  onTap: () {
                    familyDetailsFormKey.currentState!.validate();
                    if (state.userDataEntity.familtyInfo.isEmpty) {
                      addMember(state);
                    } else {
                      if (state.userDataEntity.familtyInfo.any((element) => element.name.text.isEmpty)) {
                        return snackBarCustom(
                          context: context,
                          message: TranslationConstants.enter_family_memaber_name.translate(context),
                        );
                      } else if (state.userDataEntity.familtyInfo.any((element) => element.relation.text.isEmpty)) {
                        return snackBarCustom(
                          context: context,
                          message: TranslationConstants.enter_relationship_of_family_member.translate(context),
                        );
                      } else if (state.userDataEntity.familtyInfo.any((element) => element.dateOfBirth.isEmpty)) {
                        return snackBarCustom(
                          context: context,
                          message: TranslationConstants.enter_dob_of_family_member.translate(context),
                        );
                      } else {
                        addMember(state);
                      }
                    }
                  },
                ),
                CommonWidget.sizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addMember(EditProfileLoadedState state) {
    UserEntity? userEntityData = state.userDataEntity.copyWith(
      familtyInfo: state.userDataEntity.familtyInfo,
      familyDetailsShow: true,
    );
    userEntityData.familtyInfo.add(
      FamiltyInfo(
        name: TextEditingController(text: ''),
        relation: TextEditingController(text: ''),
        dateOfBirth: '',
        anniversaryDate: '',
      ),
    );
    editProfileCubit.setDate(state: state, userEntity: userEntityData);
  }

  Widget saveButton({
    required BuildContext context,
    required EditProfileLoadedState state,
    required UserNewOld userNewOld,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: CommonWidget.commonButton(
        context: context,
        height: 45.h,
        alignment: Alignment.center,
        text: widget.userNewOld == UserNewOld.newUser
            ? TranslationConstants.save_profile.translate(context)
            : TranslationConstants.update_profile.translate(context),
        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        onTap: () {
          if (editProfileCubit.nameController.text.isEmpty) {
            return snackBarCustom(
              context: context,
              message: TranslationConstants.enter_name.translate(context),
            );
          } else if (state.userDataEntity.dob.isEmpty) {
            return snackBarCustom(
              context: context,
              message: TranslationConstants.select_date_of_birth.translate(context),
            );
          } else if (editProfileCubit.flatNumberController.text.isEmpty) {
            return snackBarCustom(
              context: context,
              message: TranslationConstants.enter_flat_house_no.translate(context),
            );
          } else if (editProfileCubit.areaController.text.isEmpty) {
            return snackBarCustom(
              context: context,
              message: TranslationConstants.enter_area_locality.translate(context),
            );
          }
          if (state.userDataEntity.familtyInfo.isNotEmpty) {
            if (state.userDataEntity.familtyInfo.any((element) => element.name.text.isEmpty)) {
              return snackBarCustom(
                context: context,
                message: TranslationConstants.enter_family_memaber_name.translate(context),
              );
            } else if (state.userDataEntity.familtyInfo.any((element) => element.relation.text.isEmpty)) {
              return snackBarCustom(
                context: context,
                message: TranslationConstants.enter_relationship_of_family_member.translate(context),
              );
            } else if (state.userDataEntity.familtyInfo.any((element) => element.dateOfBirth.isEmpty)) {
              return snackBarCustom(
                context: context,
                message: TranslationConstants.enter_dob_of_family_member.translate(context),
              );
            }
          }

          if (formKey.currentState!.validate() && familyDetailsFormKey.currentState!.validate()) {
            editProfileCubit.updateUserDetails(
              state: state,
              context: context,
              userNewOld: widget.userNewOld,
            );
          }
        },
      ),
    );
  }

  snackBarCustom({required BuildContext context, required String message}) {
    CustomSnackbar.show(
      snackbarType: SnackbarType.ERROR,
      message: message,
    );
  }

  Widget uploadImage({required BuildContext context, required EditProfileLoadedState state}) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 80.r,
            width: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.15),
            ),
            padding: state.userDataEntity.profilePhoto != ''
                ? EdgeInsets.all(state.userDataEntity.profilePhoto.endsWith('svg') ? 5.r : 0)
                : accountInfoEntity?.defaultImage.isNotEmpty == true
                    ? EdgeInsets.all(accountInfoEntity!.defaultImage.endsWith('svg') ? 5.r : 0)
                    : const EdgeInsets.all(0),
            child: state.userDataEntity.profilePhoto != ''
                ? CommonWidget.imageBuilder(
                    borderRadius: 40,
                    imageUrl: state.userDataEntity.profilePhoto,
                  )
                : accountInfoEntity?.defaultImage.isNotEmpty == true
                    ? CommonWidget.imageBuilder(
                        borderRadius: 40,
                        imageUrl: accountInfoEntity!.defaultImage,
                      )
                    : CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/edit_profile/avtar_picture.svg",
                        fit: BoxFit.cover,
                      ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: InkWell(
              onTap: () {
                if (state.userDataEntity.profilePhoto != '') {
                  editProfileCubit.setDate(
                    state: state,
                    userEntity: state.userDataEntity.copyWith(profilePhoto: ''),
                  );
                } else {
                  uploadProfilePicture(
                    context: context,
                    editProfileCubit: editProfileCubit,
                    state: state,
                  );
                }
              },
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: appConstants.primary1Color,
                child: state.userDataEntity.profilePhoto != ''
                    ? Center(
                        child: Icon(
                          Icons.close,
                          color: appConstants.whiteBackgroundColor,
                          size: 17.r,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: appConstants.whiteBackgroundColor,
                          size: 17.r,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addFamilyDetailBox({
    required EditProfileCubit editProfileCubit,
    required int index,
    required EditProfileLoadedState state,
  }) {
    FamiltyInfo familtyInfo = state.userDataEntity.familtyInfo[index];

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: CommonWidget.boaderRadius(appConstants.prductCardRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.only(left: 14.w, right: 10.w),
          childrenPadding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 10.h),
          backgroundColor: appConstants.greyBackgroundColor,
          collapsedBackgroundColor: appConstants.greyBackgroundColor,
          iconColor: appConstants.default1Color,
          shape: Border.all(color: Colors.transparent, width: 0),
          onExpansionChanged: (value) {
            UserEntity userDataEntity = state.userDataEntity;
            userDataEntity.familtyInfo[index].isFamilyDetailsExpand = value;
            editProfileCubit.updateData(userDataEntity: userDataEntity, state: state);
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: familtyInfo.name.text,
                style: Theme.of(context).textTheme.bodyBookHeading.copyWith(color: appConstants.default1Color),
              ),
              CommonWidget.imageButton(
                svgPicturePath: "assets/photos/svg/common/trash.svg",
                iconSize: 16.h,
                onTap: () async {
                  var data = await CommonWidget.showAlertDialog(
                    context: context,
                    text: TranslationConstants.want_delete_family_name.translate(context),
                  );
                  if (data) {
                    if (familtyInfo.id != null) {
                      editProfileCubit.deleteFamilyMember(id: familtyInfo.id!, state: state);
                    } else {
                      bool isShow = true;
                      state.userDataEntity.familtyInfo.removeAt(index);
                      if (state.userDataEntity.familtyInfo.isEmpty) {
                        isShow = false;
                      }
                      editProfileCubit.setDate(
                        state: state,
                        userEntity: state.userDataEntity.copyWith(
                          familtyInfo: state.userDataEntity.familtyInfo,
                          familyDetailsShow: isShow,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
          trailing: Icon(
            familtyInfo.isFamilyDetailsExpand == true ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 30.r,
            color: appConstants.default1Color,
          ),
          children: [
            CommonWidget.commonDashLine(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleOfTextField(text: TranslationConstants.name.translate(context), isRequired: true),
                textFormFieldEditProfile(
                  controller: familtyInfo.name,
                  onChanged: (value) {
                    if (value.isEmpty || value.length == 1) {
                      familyDetailsFormKey.currentState!.validate();
                    }
                  },
                  hintText: TranslationConstants.enter_name_infamily.translate(context),
                  context: context,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TranslationConstants.this_field_is_required.translate(context);
                    }
                    return null;
                  },
                ),
                titleOfTextField(text: TranslationConstants.relationship.translate(context), isRequired: true),
                CommonDropdown(
                  dataList: state.userDataEntity.relationshipOptions,
                  selectedOptions: familtyInfo.relation.text,
                  onOptionSelected: (option) {
                    familtyInfo.relation = TextEditingController(text: option.toString());
                    editProfileCubit.familyRelation(state: state);
                    formKey.currentState?.validate();
                  },
                ),
                titleOfTextField(text: TranslationConstants.date_of_birth.translate(context), isRequired: true),
                textFormFieldEditProfile(
                  context: context,
                  controller: TextEditingController(text: familtyInfo.dateOfBirth),
                  hintText: TranslationConstants.DD_MM_YYYY.translate(context),
                  readonly: true,
                  validator: (value) {
                    if (familtyInfo.dateOfBirth.isEmpty) {
                      return TranslationConstants.this_field_is_required.translate(context);
                    }
                    return null;
                  },
                  onTap: () async {
                    await familyDobSelect(
                      state: state,
                      index: index,
                      editProfileCubit: editProfileCubit,
                    );
                  },
                  suffixwidget: Padding(
                    padding: EdgeInsets.all(13.r),
                    child: CommonWidget.imageButton(
                      svgPicturePath: "assets/photos/svg/common/calender.svg",
                      iconSize: 6.r,
                      boxFit: BoxFit.fill,
                      onTap: () async {
                        await familyDobSelect(
                          state: state,
                          index: index,
                          editProfileCubit: editProfileCubit,
                        );
                      },
                    ),
                  ),
                ),
                titleOfTextField(text: TranslationConstants.anniversary_date.translate(context)),
                textFormFieldEditProfile(
                  context: context,
                  controller: TextEditingController(text: familtyInfo.anniversaryDate.toString()),
                  hintText: TranslationConstants.DD_MM_YYYY.translate(context),
                  readonly: true,
                  onTap: () async {
                    await familyAnniversaryDateSelect(
                      state: state,
                      index: index,
                      editProfileCubit: editProfileCubit,
                    );
                  },
                  suffixwidget: Padding(
                    padding: EdgeInsets.all(13.r),
                    child: familtyInfo.anniversaryDate!.isEmpty
                        ? CommonWidget.imageButton(
                            svgPicturePath: "assets/photos/svg/common/calender.svg",
                            iconSize: 6.r,
                            boxFit: BoxFit.fill,
                            onTap: () async {
                              await familyAnniversaryDateSelect(
                                state: state,
                                index: index,
                                editProfileCubit: editProfileCubit,
                              );
                            },
                          )
                        : InkWell(
                            onTap: () {
                              List<FamiltyInfo> info = state.userDataEntity.familtyInfo;
                              info[index].anniversaryDate = '';
                              editProfileCubit.setDate(
                                state: state,
                                userEntity: state.userDataEntity.copyWith(familtyInfo: info),
                              );
                            },
                            child: CommonWidget.commonIcon(
                              icon: Icons.cancel,
                              iconSize: 16.r,
                              iconColor: appConstants.primary1Color,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> familyDobSelect({
    required EditProfileLoadedState state,
    required int index,
    required EditProfileCubit editProfileCubit,
  }) async {
    List<DateTime> selectedDate = await CommonWidget.datePicker(
      context: context,
      maxDate: DateTime.now(),
      minDate: DateTime(DateTime.now().year - 100),
      isRangeDate: false,
    );
    String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
    List<FamiltyInfo> info = state.userDataEntity.familtyInfo;
    info[index].dateOfBirth = formattedDate;
    familyDetailsFormKey.currentState?.validate();
    editProfileCubit.setDate(
      state: state,
      userEntity: state.userDataEntity.copyWith(familtyInfo: info),
    );
  }

  Future<void> familyAnniversaryDateSelect({
    required EditProfileLoadedState state,
    required int index,
    required EditProfileCubit editProfileCubit,
  }) async {
    List<DateTime> selectedDate = await CommonWidget.datePicker(
      context: context,
      maxDate: DateTime.now(),
      minDate: DateTime(DateTime.now().year - 100),
      isRangeDate: false,
    );
    String formattedDate = CommonWidget.dateToString(date: selectedDate.first);
    List<FamiltyInfo> info = state.userDataEntity.familtyInfo;
    info[index].anniversaryDate = formattedDate;
    editProfileCubit.setDate(
      state: state,
      userEntity: state.userDataEntity.copyWith(familtyInfo: info),
    );
  }

  Widget titleOfTextField({required String text, bool isRequired = false, bool isFieldDisable = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h, top: 18.h),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyBookHeading
                .copyWith(color: isFieldDisable ? appConstants.default4Color : appConstants.default1Color),
          ),
          Visibility(
            visible: isRequired,
            child: CommonWidget.commonRequiredStatr(context: context),
          ),
        ],
      ),
    );
  }

  bool isProfileUpdated({required UserEntity oldData, required EditProfileCubit cubit}) {
    return oldData.name != cubit.nameController.text ||
        oldData.email != cubit.emailController.text ||
        oldData.address.flatNo != cubit.flatNumberController.text ||
        oldData.address.locality != cubit.areaController.text ||
        oldData.address.landmark != cubit.landmarkController.text ||
        oldData.mobile != cubit.numberController.text;
  }
}
