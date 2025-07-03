import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  List<StreamSubscription> subscriptions = [];

  void register<T>(StreamSubscription<T> sub, {required void Function(T event) listener}) {
    subscriptions.add(sub);
    return sub.onData(listener);
  }

  @override
  void dispose() {
    for (var sub in subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}
