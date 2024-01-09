import 'dart:developer';
import 'dart:io';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/user_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_login_details_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/update_profile_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/upload_file_params.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/delete_family_detail.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/update_login_details.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/update_user_detail.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/upload_file.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_state.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_geocoder/location_geocoder.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ToggleCubit relationListShowCubit;
  final LoadingCubit loadingCubit;
  final UploadFile uploadFile;
  final UpdateUserDetail updateUserDetail;
  final DeleteFamilyDetail deleteFamilyDetail;
  final UpdateLoginDetails updateLoginDetails;
  final GetUserDataCubit userDataLoadCubit;
  EditProfileCubit({
    required this.relationListShowCubit,
    required this.loadingCubit,
    required this.uploadFile,
    required this.updateUserDetail,
    required this.deleteFamilyDetail,
    required this.updateLoginDetails,
    required this.userDataLoadCubit,
  }) : super(EditProfileLoadingState());

  final ImagePicker imagePicker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController flatNumberController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  File? imagePath;

  void userDataLoad({UserEntity? userDataEntity}) {
    if (userDataEntity != null) {
    } else {
      userDataLoadCubit.loadUserData(loadShow: true);
    }

    if (userEntity != null) {
      nameController.text = userEntity?.name?.isNotEmpty == true ? userEntity!.name ?? '' : (googleUserName ?? '');
      emailController.text = userEntity?.email ?? "";
      numberController.text = userEntity?.mobile ?? '';
      flatNumberController.text = userEntity?.address.flatNo ?? '';
      areaController.text = userEntity!.address.locality;
      landmarkController.text = userEntity!.address.landmark;
      emit(EditProfileLoadedState(userDataEntity: userEntity!));
    }
  }

  void deleteFamilyMember({required int id, required EditProfileLoadedState state}) async {
    loadingCubit.show();
    Either<AppError, PostApiResponse> response = await deleteFamilyDetail(id);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(EditProfileErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          userEntity?.familtyInfo.removeWhere((element) => element.id == id);
          if (state.userDataEntity.familtyInfo.isEmpty) {
            setDate(
              state: state,
              userEntity: state.userDataEntity.copyWith(familyDetailsShow: false),
            );
          }
          userDataLoadCubit.loadUserData(loadShow: true);
          emit(state.copyWith(userDataEntity: userEntity));
          CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: data.message);
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }

  void setDate({required EditProfileLoadedState state, required UserEntity userEntity}) {
    emit(state.copyWith(userDataEntity: userEntity));
  }

  void uploadProfilePhoto({required BuildContext context, required EditProfileLoadedState state}) async {
    if (imagePath != null) {
      loadingCubit.show();
      Either<AppError, UploadFileEntity> response = await uploadFile(
        UploadFileParams(file: imagePath!.path, type: 'profile'),
      );
      response.fold(
        (error) async {
          loadingCubit.hide();
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
          emit(EditProfileErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
        },
        (UploadFileEntity data) {
          loadingCubit.hide();
          emit(state.copyWith(userDataEntity: state.userDataEntity.copyWith(profilePhoto: data.fullPath)));
        },
      );
    } else {
      CustomSnackbar.show(
        snackbarType: SnackbarType.ERROR,
        message: TranslationConstants.something_went_wrong.translate(context),
      );
    }
  }

  Future<void> setData({required double latitude, required double longitude}) async {
    final LocatitonGeocoder geocoder = LocatitonGeocoder(appConstants.loctionApiKey);
    final address = await geocoder.findAddressesFromCoordinates(Coordinates(latitude, longitude));
    cityName = address.first.locality ?? '';
    stateName = address.first.adminArea ?? '';
    countryName = address.first.countryName ?? '';
    pinCode = address.first.postalCode ?? '';
    log(address.first.postalCode.toString());
  }

  void updateUserDetails({
    required EditProfileLoadedState state,
    required BuildContext context,
    required UserNewOld userNewOld,
  }) async {
    loadingCubit.show();
    UserEntity userEntity = state.userDataEntity;
    log(userEntity.countryCode.toString());

    String address = areaController.text;

    if (address.contains(countryName)) {
      address = address.replaceAll(countryName, '');
    }
    if (address.contains(pinCode)) {
      address = address.replaceAll(pinCode, '');
    }
    if (address.contains(stateName)) {
      address = address.replaceAll(stateName, '');
    }
    if (address.contains(cityName)) {
      address = address.replaceAll(cityName, '');
    }
    address = address.replaceAll(', ,', '');

    address = address.replaceAll(' ,', '');
    address = address.replaceAll('-', '');
    address = address.trim();

    UpdateUserDetailParams updateUserDetailParams = UpdateUserDetailParams(
      name: nameController.text,
      countryCode: userEntity.countryCode,
      dob: state.userDataEntity.dob,
      anniversaryDate: state.userDataEntity.anniversaryDate,
      address: AddressData(
        flatNo: flatNumberController.text,
        locality: address,
        landmark: landmarkController.text,
        city: cityName,
        state: stateName,
        country: countryName,
        zipCode: pinCode,
      ),
      profilePhoto: userEntity.profilePhoto,
      familtyInfo: userEntity.familtyInfo,
    );

    Either<AppError, PostApiResponse> response = await updateUserDetail(updateUserDetailParams);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        // emit(EditProfileErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          userDataLoadCubit.loadUserData(loadShow: true);

          if (UserNewOld.newUser == userNewOld) {
            BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
            CommonRouter.pushReplacementNamed(RouteList.app_home);
          } else {
            CommonRouter.popUntil(RouteList.app_home);
            BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
          }
          CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: data.message);
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }

  void pickImage(imagePath) {
    loadingCubit.show();
    emit(EditProfileImagePicked(imagePath!));
    loadingCubit.hide();
  }

  void hideShowRelationList({required bool value}) {
    relationListShowCubit.setValue(value: value);
  }

  void familyRelation({required EditProfileLoadedState state}) {
    emit(EditProfileLoadedState(userDataEntity: state.userDataEntity));
  }

  void updateLoginDetail({
    required UpdateLoginDetailsParams updateLoginDetailsParams,
    required UserNewOld userNewOld,
  }) async {
    loadingCubit.show();
    Either<AppError, PostApiResponse> response = await updateLoginDetails(updateLoginDetailsParams);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
      },
      (PostApiResponse data) {
        loadingCubit.hide();
        if (data.status) {
          CommonRouter.pushNamed(
            RouteList.otp_verification_screen,
            arguments: GenerateOtpArgument(
              mobileNumber: updateLoginDetailsParams.mobileNumber,
              updateLoginDetailsParams: updateLoginDetailsParams,
              useOldNew: userNewOld,
            ),
          );
          // loadUserData();
        } else {
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: data.message);
        }
      },
    );
  }

  void updateData({required UserEntity userDataEntity, required EditProfileLoadedState state}) {
    emit(state.copyWith(userDataEntity: userDataEntity));
  }
}
