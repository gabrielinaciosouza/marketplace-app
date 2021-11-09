import 'package:flutter/material.dart';

import '../ui.dart';

class Supplier<T> extends InheritedWidget {
  const Supplier({
    Key? key,
    required this.presenter,
    required Widget child,
  }) : super(key: key, child: child);

  final T presenter;

  static Supplier of<T>(BuildContext context) {
    final Supplier? result =
        context.dependOnInheritedWidgetOfExactType<Supplier<T>>();
    if (result == null) throw const PresenterNotFound();
    return result;
  }

  @override
  bool updateShouldNotify(Supplier oldWidget) =>
      presenter != oldWidget.presenter;
}
