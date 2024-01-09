import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/my_profile/my_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/my_profile_screen/my_profile_screen.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

abstract class MyProfileScreenWidget extends State<MyProfileScreen> with WidgetsBindingObserver {
  late MyProfileCubit myProfileCubit;

  @override
  void initState() {
    super.initState();
    myProfileCubit = getItInstance<MyProfileCubit>();
    if (userEntity != null) {
      myProfileCubit.dataSave(userDataEntity: userEntity!);
    } else {
      myProfileCubit.loadUserData();
    }
  }

  @override
  void dispose() {
    myProfileCubit.loadingCubit.hide();
    myProfileCubit.close();
    super.dispose();
  }

  Widget userDataView(MyProfileLoadedState state, BuildContext context) {
    return Container(
      color: appConstants.greyBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              CommonWidget.sizedBox(height: 110),
              userDetailsBox(state, context),
            ],
          ),
          userProfileImage(state: state),
        ],
      ),
    );
  }

  Widget userDetailsBox(MyProfileLoadedState state, BuildContext context) {
    return CommonWidget.container(
      width: ScreenUtil.defaultSize.width,
      color: appConstants.whiteBackgroundColor,
      isBorderOnlySide: true,
      topLeft: 30.r,
      topRight: 20.r,
      child: Padding(
        padding: EdgeInsets.only(top: 60.h, right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.commonText(
              text: state.userDataEntity.name == '' ? 'Your Name' : state.userDataEntity.name!.toCamelcase(),
              style: Theme.of(context).textTheme.h4BoldHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: '${TranslationConstants.total_referral_points.translate(context)} : ',
                  style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                        color: appConstants.default4Color,
                      ),
                ),
                CommonWidget.commonText(
                  text: '500',
                  style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CommonWidget.commonText(
                        text: '${TranslationConstants.code.translate(context)}  : ',
                        style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                      CommonWidget.commonText(
                        text: state.userDataEntity.referralCode,
                        style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                              color: appConstants.primary1Color,
                            ),
                      ),
                    ],
                  ),
                  CommonWidget.imageButton(
                    svgPicturePath: "assets/photos/svg/common/copy_icon.svg",
                    color: appConstants.default3Color,
                    iconSize: 16.h,
                    onTap: () => Clipboard.setData(
                      ClipboardData(
                        text: state.userDataEntity.referralCode,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
              child: CommonWidget.commonDashLine(),
            ),
            userDetails(context: context, state: state),
          ],
        ),
      ),
    );
  }

  Widget userDetails({required BuildContext context, required MyProfileLoadedState state}) {
    return Wrap(
      children: [
        Visibility(
          visible: state.userDataEntity.mobile.isNotEmpty,
          child: commonBox(
            backgroundColor: appConstants.profilePhone2Color,
            text: TranslationConstants.mobile.translate(context),
            svgImagePath: 'assets/photos/svg/profile_screen/mobile_profile_icon.svg',
            data: state.userDataEntity.mobile,
          ),
        ),
        Visibility(
          visible: state.userDataEntity.email.isNotEmpty,
          child: commonBox(
            backgroundColor: appConstants.profileEmail2Color,
            text: TranslationConstants.email_id.translate(context),
            boxWidth: 180.w,
            svgImagePath: 'assets/photos/svg/profile_screen/email_profile_icon.svg',
            data: state.userDataEntity.email,
          ),
        ),
        Visibility(
          visible: state.userDataEntity.dob.isNotEmpty,
          child: commonBox(
            backgroundColor: appConstants.profileDob2Color,
            text: TranslationConstants.date_of_birth.translate(context),
            svgImagePath: 'assets/photos/svg/profile_screen/date_of_birth_profile.svg',
            data: state.userDataEntity.dob,
          ),
        ),
        Visibility(
          visible: state.userDataEntity.anniversaryDate.isNotEmpty,
          child: commonBox(
            backgroundColor: appConstants.profileAnniversary2Color,
            text: TranslationConstants.anniversary_date.translate(context),
            svgImagePath: 'assets/photos/svg/profile_screen/anniversary_profile.svg',
            data: state.userDataEntity.anniversaryDate,
          ),
        ),
        Visibility(
          visible: state.userDataEntity.fullAddress.isNotEmpty,
          child: commonBox(
            backgroundColor: appConstants.profileAddress2Color,
            text: TranslationConstants.address.translate(context),
            boxWidth: ScreenUtil().screenWidth,
            svgImagePath: 'assets/photos/svg/profile_screen/address_profile.svg',
            data: state.userDataEntity.fullAddress,
          ),
        ),
      ],
    );
  }

  Widget familyDetails({required MyProfileLoadedState state}) {
    return CommonWidget.container(
      ispaddingAllSide: false,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      color: appConstants.whiteBackgroundColor,
      child: Column(
        children: [
          CommonWidget.sizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: CommonWidget.sizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.family_details.translate(context),
                    style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                          color: appConstants.default1Color,
                          height: 1.r,
                        ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: CommonWidget.sizedBox(
                        width: 210,
                        child: CommonWidget.commonDashLine(
                          height: 10.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: state.userDataEntity.familtyInfo.length,
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return CommonWidget.container(
                child: familyDetailsBox(state: state, index: index),
              );
            },
          )
        ],
      ),
    );
  }

  Widget userProfileImage({required MyProfileLoadedState state}) {
    return Positioned(
      top: 55.h,
      child: Container(
        height: 100.r,
        width: 100.r,
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
                borderRadius: 50,
                imageUrl: state.userDataEntity.profilePhoto,
              )
            : accountInfoEntity?.defaultImage.isNotEmpty == true
                ? CommonWidget.imageBuilder(
                    borderRadius: 50,
                    imageUrl: accountInfoEntity!.defaultImage,
                  )
                : CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/edit_profile/avtar_picture.svg",
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }

  Widget commonBox({
    required String text,
    required String svgImagePath,
    required String data,
    required Color? backgroundColor,
    double? boxWidth,
    double? boxHeight,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: CommonWidget.sizedBox(
        width: boxWidth ?? ScreenUtil().screenWidth / 2.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: backgroundColor,
                child: CommonWidget.imageBuilder(
                  imageUrl: svgImagePath,
                  height: 20.h,
                ),
              ),
            ),
            CommonWidget.commonText(
              text: text,
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
            ),
            CommonWidget.commonText(
              text: data,
              style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default4Color),
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget familyDetailsBox({required MyProfileLoadedState state, required int index}) {
    FamiltyInfo familtyInfo = state.userDataEntity.familtyInfo[index];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
      child: CommonWidget.container(
        ispaddingAllSide: true,
        paddingAllSide: 15.r,
        borderRadius: appConstants.prductCardRadius,
        isBorder: true,
        borderColor: appConstants.default8Color,
        borderWidth: 1.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: familtyInfo.name.text != '',
                    child: familyTextBox(
                      textOfTitle: TranslationConstants.name.translate(context),
                      textOfData: familtyInfo.name.text,
                      context: context,
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: familtyInfo.relation.text != '',
                    child: familyTextBox(
                      textOfTitle: TranslationConstants.relationship.translate(context),
                      textOfData: familtyInfo.relation.text,
                      context: context,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Visibility(
                    visible: familtyInfo.dateOfBirth != '',
                    child: familyTextBox(
                      textOfTitle: TranslationConstants.date_of_birth.translate(context),
                      textOfData: familtyInfo.dateOfBirth,
                      context: context,
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: familtyInfo.anniversaryDate != '',
                    child: familyTextBox(
                      textOfTitle: TranslationConstants.anniversary_date.translate(context),
                      textOfData: familtyInfo.anniversaryDate ?? '',
                      context: context,
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

  static Widget familyTextBox({
    required String textOfTitle,
    required String textOfData,
    required context,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: textOfTitle,
            style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default5Color),
          ),
          CommonWidget.sizedBox(
            width: 150,
            child: CommonWidget.commonText(
              text: textOfData,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
            ),
          ),
        ],
      ),
    );
  }
}
