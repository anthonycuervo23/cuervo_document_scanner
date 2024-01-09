import 'dart:io';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/user_entity.dart';
import 'package:bakery_shop_flutter/model/family_details_model.dart';

abstract class EditProfileState {
  const EditProfileState();

  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();

  @override
  List<Object> get props => [];
}

class EditProfileLoadingState extends EditProfileState {
  EditProfileLoadingState();

  @override
  List<Object> get props => [];
}

class EditProfileImagePicked extends EditProfileState {
  final File? imageFile;

  EditProfileImagePicked(this.imageFile);
}

class EditProfileLoadedState extends EditProfileState {
  final UserEntity userDataEntity;

  const EditProfileLoadedState({required this.userDataEntity});

  EditProfileLoadedState copyWith({UserEntity? userDataEntity}) {
    return EditProfileLoadedState(userDataEntity: userDataEntity ?? this.userDataEntity);
  }

  @override
  List<Object> get props => [userDataEntity];
}

class EditProfileFamilyDeleted extends EditProfileState {
  final List<FamilyDetails> familyDetailData;

  EditProfileFamilyDeleted(this.familyDetailData);
}

class EditProfileErrorState extends EditProfileState {
  final AppErrorType appErrorType;
  final String errorMessage;

  EditProfileErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
