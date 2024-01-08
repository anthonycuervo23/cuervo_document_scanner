import 'dart:io';
import 'dart:math';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/core/build_context.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_state.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddDeataisCubit extends Cubit<AddDetailsState> {
  final LoadingCubit loadingCubit;
  AddDeataisCubit({required this.loadingCubit}) : super(AddDetailsLoadingState());

  TextEditingController titleController = TextEditingController();
  TextEditingController shortDesController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  MarketingDataModel? marketingDataModel;
  String? imagePath;

  void inilationLoading({required SelectedTab selectedTab}) {
    emit(AddDetailsLoadedState(
      selectedTab: selectedTab,
      index: selectedTab.index,
      typeLink: TranslationConstants.select_link_type.translate(buildContext),
      status: true,
    ));
  }

  Future<String?> pickImge() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? path = await imagePicker.pickImage(source: ImageSource.gallery);
    var file = File(path!.path);
    final bytes = file.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if (mb < 5) {
      return path.path;
    } else {
      return null;
    }
  }

  void changeTypeLink({required AddDetailsLoadedState state, String? value}) {
    emit(state.copyWith(typeLink: value));
  }

  void startDatePicker({required List<DateTime?>? date, required AddDetailsLoadedState state}) {
    startDateController = TextEditingController(text: "${date?[0]?.day}/${date?[0]?.month}/${date?[0]?.year}");
    emit(state.copyWith(startDate: date![0], random: Random().nextDouble()));
  }

  void endDatePicker({required List<DateTime?>? date, required AddDetailsLoadedState state}) {
    endDateController = TextEditingController(text: "${date?[0]?.day}/${date?[0]?.month}/${date?[0]?.year}");
    emit(state.copyWith(endDate: date![0], random: Random().nextDouble()));
  }

  void changeStatus({required AddDetailsLoadedState state, required bool value}) {
    emit(state.copyWith(status: value));
  }

  void fillModelData() {
    AddDetailsLoadedState addDetailsLoadedState;
    addDetailsLoadedState = state as AddDetailsLoadedState;

    titleController = TextEditingController(text: marketingDataModel?.title);
    shortDesController = TextEditingController(text: marketingDataModel?.desription);
    linkController = TextEditingController(text: marketingDataModel?.link);
    startDateController = TextEditingController(text: marketingDataModel?.startDate);
    endDateController = TextEditingController(text: marketingDataModel?.endDate);
    emit(addDetailsLoadedState.copyWith(
      status: marketingDataModel?.liveStatus,
      typeLink: marketingDataModel?.linkType,
      startDate: parseDate(marketingDataModel?.startDate ?? ""),
      endDate: parseDate(marketingDataModel?.endDate ?? ""),
    ));
  }
}
