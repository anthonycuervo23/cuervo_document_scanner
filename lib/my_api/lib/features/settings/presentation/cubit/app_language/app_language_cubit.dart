import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/app_language_entity.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  final LoadingCubit loadingCubit;
  AppLanguageCubit({required this.loadingCubit}) : super(const AppLanguageLoadingState());

  void loadAppLanguages() {
    List<AppLanguageEntity> appLanuageList = [
      AppLanguageEntity(
        imageUrl:
            "https://img.freepik.com/free-vector/illustration-india-flag_53876-27130.jpg?w=1380&t=st=1697703185~exp=1697703785~hmac=7b3396f2c9c685f055c2001f451555de8c915b5f22fda05676eb31e6e40d492c",
        id: 0,
        name: 'Hindi',
        shortCode: 'hi',
        isDefault: 1,
      ),
      AppLanguageEntity(
        imageUrl:
            "https://img.freepik.com/free-vector/illustration-usa-flag_53876-18165.jpg?w=1380&t=st=1697703220~exp=1697703820~hmac=4871bb332364a00f15df1819e9268088544ddaf637208516d724a841e6de30d3",
        id: 1,
        name: 'English',
        shortCode: 'en',
        isDefault: 0,
      ),
      AppLanguageEntity(
        imageUrl:
            "https://img.freepik.com/free-vector/illustration-italy-flag_53876-27098.jpg?w=1380&t=st=1697703242~exp=1697703842~hmac=41a90c245de55117391581704c4ed923ba7d91f5eb9a4fd975999421222b10d0",
        id: 2,
        name: 'Gujarati',
        shortCode: 'gu',
        isDefault: 0,
      ),
      AppLanguageEntity(
        imageUrl:
            "https://img.freepik.com/free-vector/illustration-turkey-flag_53876-27134.jpg?w=1380&t=st=1697703262~exp=1697703862~hmac=22e61ec479f2407f8e6740619b97c0959cf0757c46e3f22dc307fb401b1df10a",
        id: 3,
        name: 'Bengali',
        shortCode: 'Ben',
        isDefault: 0,
      ),
      AppLanguageEntity(
        imageUrl:
            "https://img.freepik.com/free-vector/illustration-russia-flag_53876-27016.jpg?w=1380&t=st=1697703331~exp=1697703931~hmac=032621438362bbc76cdd8f02fb46c1036569346307253a5461d1aea5e76b3d7d",
        id: 4,
        name: 'German',
        shortCode: 'ger',
        isDefault: 0,
      ),
    ];
    emit(AppLanguageLoadedState(appLanguageList: appLanuageList));
  }

  void changeLanguage(int index) {}
}
