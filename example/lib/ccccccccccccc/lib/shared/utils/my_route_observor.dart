import 'dart:isolate';

import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/main.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_isolate/flutter_isolate.dart';

int currentTime = 0;
String currentScreen = '';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  FlutterIsolate? isolate;

  Future<void> runTimer(String routeName) async {
    // userAppActivity?.addAll({routeName: currentTime.toString()});
    // dmtBox.put(HiveConstants.USER_APP_ACTIVITY, userAppActivity);
    // print(userAppActivity);

    // print("currentTime" + currentTime.toString());
    // print("currentScreen" + currentScreen.toString());

    // isolateForRouter(routeName: routeName);

    // isolate?.kill();
    // isolate = null;
    // isolate = await FlutterIsolate.spawn(isolate1, routeName);

    routeIsolate?.kill();

    int oldDuration = (userAppActivity.containsKey(routeName)) ? userAppActivity[routeName]! : 0;
    String newRouteName = routeName;

    currentRouteName = routeName;

    if (newRouteName == '/') {
      newRouteName = '/splash';
    }

    newRouteName = newRouteName.toString().replaceAll('/', '');

    Future.microtask(() async {
      routeIsolate = await Isolate.spawn(
        computeIsolate,
        Message(sendPort: routingIsolateReceivePort.sendPort, message: newRouteName, oldDuration: oldDuration),
      );
    });
  }

  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;

    navigationCount = navigationCount + 1;
    dmtBox.put(HiveConstants.NAV_NUMBER, navigationCount);

    // DefaultCacheManager().store.emptyMemoryCache();

    // print('screenName $screenName');
    runTimer(screenName ?? "");
    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
