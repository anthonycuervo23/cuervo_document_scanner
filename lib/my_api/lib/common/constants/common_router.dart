import 'package:catcher/catcher.dart';

class CommonRouter {
  CommonRouter._();
  static void pop({Object? args}) {
    Catcher.navigatorKey?.currentState?.pop(args);
  }

  static void popUntil(String routeName) {
    Catcher.navigatorKey?.currentState?.popUntil(
      (route) => route.settings.name == routeName,
    );
  }

  static Future<Object?> pushNamed(
    String routeName, {
    Object? arguments,
  }) async {
    Object? data = await Catcher.navigatorKey?.currentState?.pushNamed(routeName, arguments: arguments);
    return data;
  }

  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    Catcher.navigatorKey?.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Catcher.navigatorKey?.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
