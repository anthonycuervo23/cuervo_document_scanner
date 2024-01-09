import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? detachedCallback;
  final AsyncCallback? inactiveCallback;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.detachedCallback,
    this.inactiveCallback,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallback != null) {
          await inactiveCallback!();
        }
        break;
      case AppLifecycleState.paused:
        // shouldShowAppOpenAdd = true;
        if (detachedCallback != null) {
          await detachedCallback!();
        }
        break;
      case AppLifecycleState.detached:
        // shouldShowAppOpenAdd = false;
        break;
      case AppLifecycleState.hidden:
        // shouldShowAppOpenAdd = true;
        if (detachedCallback != null) {
          await detachedCallback!();
        }
        break;
    }
  }
}
