import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final ToggleCubit promotionalActivationCubit;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  SettingCubit({required this.promotionalActivationCubit}) : super(SettingLoadedState());

  // Future<bool> logout() async {
  //   try {
  //     await firebaseAuth.signOut();
  //     await googleSignIn.signOut();
  //     return true;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     return false;
  //   }
  // }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    CommonRouter.pushNamed(RouteList.login_screen);
  }
}
