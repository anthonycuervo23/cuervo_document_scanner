import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);

  List loadedPages = [0];
  bool isMounted = true;

  changedBottomNavigation(int index) async {
    if (!loadedPages.contains(index)) {
      loadedPages.add(index);
    }
    emit(index);
  }
}
