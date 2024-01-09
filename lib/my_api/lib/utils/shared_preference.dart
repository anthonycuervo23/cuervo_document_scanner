import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  late SharedPreferences shared;

  Future<void> getInstance() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    shared = sharedPreferences;
  }

  // Singleton instance
  static final SharedPref _singleton = SharedPref._();

  // Singleton accessor
  static SharedPref get instance => _singleton;
}
